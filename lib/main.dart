import 'package:flutter/foundation.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import './providers/localization_provider.dart';
import './providers/app_config_provider.dart';
import './providers/app_language_provider.dart';
import './helpers/localization/demo_localization.dart';
import './helpers/localization/language_localization.dart';
import './constants/constants.dart';
import './screens/startup_screen.dart';
import './screens/tabs_screen.dart';

final navigatorkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  //Firebase Core
  // FirebaseApp app = await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AppConfigProvider()),
        ChangeNotifierProvider(create: (ctx) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (ctx) => LocalizationProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: Constants.appName,
          navigatorKey: navigatorkey,
          localizationsDelegates: const [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          locale:
              Provider.of<AppLanguageProvider>(context, listen: true).appLocal,
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: ColorConstants.primaryColor,
            backgroundColor: ColorConstants.backgroundColor,
            appBarTheme: const AppBarTheme(color: ColorConstants.primaryColor),
          ),
          home: StartupScreen(),
          routes: {
            StartupScreen.rounteName: (ctx) => StartupScreen(),
            TabsScreen.routeName: (ctx) => const TabsScreen(),
          },
        );
      },
    );
  }
}
