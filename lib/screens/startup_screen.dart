import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../helpers/converters/image_source_converter.dart';
import '../helpers/fonts/text_style_theme.dart';
import '../providers/app_config_provider.dart';
import '../providers/app_language_provider.dart';

import '../providers/localization_provider.dart';

import '../screens/tabs_screen.dart';
import '../helpers/extensions/string_ext.dart';

import '../services/localization_service.dart';
import '../widgets/status_app_bar.dart';

class StartupScreen extends StatefulWidget {
  static const rounteName = "/startup_screen";

  late LocalizationService _localizationService;

  StartupScreen({Key? key}) : super(key: key) {
    _localizationService = LocalizationService();
  }

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  late SharedPreferences _prefs;
  Uint8List? _applicationLogo;
  String _applicationStatus = StringExtension.emptyString;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      setState(() {
        _applicationStatus = "Getting start...";
      });

      // Application Logo
      _prefs = await SharedPreferences.getInstance();
      Object? applicationLogo = _prefs.get(SPConstants.appLogo);
      setState(() {
        _applicationLogo = applicationLogo != null
            ? ImageSourceConverter.converter(applicationLogo.toString())
            : null;
      });

      // Firebase Push Notification
      // setState(() {
      //   _applicationStatus = "Getting permission...";
      // });
      // await _requestPermissionAndToken();
      // await _iOSConfigure();
      // await _androidConfigure();

      // Application Flow
      setState(() {
        _applicationStatus = "Getting configuration...";
      });
      await _loadingConfig(context);
      Future.delayed(const Duration(seconds: 1), () async {
        setState(() {
          _applicationStatus = "Getting profile...";
        });
        await _validateLogin(context);
        await Navigator.of(context)
            .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
      });
    });
  }

  Future<void> _requestPermissionAndToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM Token: $fcmToken");
  }

  Future<void> _iOSConfigure() async {
    if (Platform.isIOS) {
      // Foreground
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> _androidConfigure() async {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();

      // Background and Terminated
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // Foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android =
            message.notification != null ? message.notification!.android : null;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: android.smallIcon,
                  importance: channel.importance,
                ),
              ));
        }
      });
    }
  }

  Future<void> _validateLogin(BuildContext context) async {
    String? tokenInStorage = _prefs.getString(SPConstants.token);
    String? tokenExpire = _prefs.getString(SPConstants.tokenExpire);
    String? companyID = _prefs.getString(SPConstants.companyID);

    dynamic verified = _prefs.getBool(SPConstants.verifiedTwoFA);

    if (tokenInStorage != null &&
        tokenInStorage != StringExtension.emptyString &&
        tokenExpire != null &&
        tokenExpire != StringExtension.emptyString &&
        verified != null &&
        verified != StringExtension.emptyString) {
      DateTime tokenInStorage = DateTime.parse(tokenExpire.toString());
      if (tokenInStorage.isAfter(DateTime.now()) && verified) {
        await _updateLocalization(context);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
        return;
      } else {
        await _prefs.remove(SPConstants.token);
        await _prefs.remove(SPConstants.tokenExpire);
        await _prefs.remove(SPConstants.id);
        await _prefs.remove(SPConstants.enableTwoFA);
        await _prefs.remove(SPConstants.verifiedTwoFA);
      }
    }
  }

  Future<void> _loadingConfig(BuildContext context) async {
    const String environment =
        String.fromEnvironment("ENV", defaultValue: AppConfigProvider.prod);
    await Provider.of<AppConfigProvider>(context, listen: false)
        .initConfig(environment);
    await Provider.of<AppLanguageProvider>(context, listen: false)
        .fetchLocale(context);
    // await Provider.of<AppLanguageProvider>(context, listen: false)
    //     .resetLanguage(context);
    await Provider.of<LocalizationProvider>(context, listen: false)
        .initFromStorage(context);
  }

  Future<void> _updateLocalization(BuildContext context) async {
    try {
      String? localizationVersion =
          _prefs.getString(SPConstants.localizationVersion);
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (localizationVersion == null ||
          localizationVersion != packageInfo.version) {
        await _prefs.setString(
            SPConstants.localizationVersion, packageInfo.version);
        await widget._localizationService.get(context);
      }
    } catch (_) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      await _prefs.setString(
          SPConstants.localizationVersion, packageInfo.version);
    }
  }

  Widget _buildAppIcon(BuildContext context) {
    if (_applicationLogo != null) {
      return Image.memory(
        _applicationLogo!,
        fit: BoxFit.contain,
        width: (MediaQuery.of(context).size.width / 1.5),
      );
    } else {
      return SvgPicture.asset(
        PhotoConstants.appIcon,
        fit: BoxFit.contain,
        width: (MediaQuery.of(context).size.width / 1.5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatusAppBar(
      color: Colors.transparent,
      brightness: Brightness.light,
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 6,
                    child: _buildAppIcon(context),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(
                height: SpaceConstants.extraLarge,
              ),
              Text(
                _applicationStatus,
                textAlign: TextAlign.center,
                style: TextStyleTheme().paragraph(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
