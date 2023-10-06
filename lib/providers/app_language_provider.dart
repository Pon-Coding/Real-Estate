import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../helpers/localization/language_localization.dart';
import '../providers/app_config_provider.dart';

class AppLanguageProvider with ChangeNotifier {
  Locale _appLocale = locale(LanguageCodeConst.english);

  Locale get appLocal => _appLocale;

  Future<void> fetchLocale(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _appLocale = locale(prefs.getString(SPConstants.languageCode)!);
    } on TypeError catch (_) {
      String lang = Provider.of<AppConfigProvider>(context, listen: false)
          .config
          .defaultLanguage
          .toString();
      _appLocale = await setLocale(lang);
    } catch (_) {
      _appLocale = await setLocale(LanguageCodeConst.english);
    } finally {
      notifyListeners();
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      if (_appLocale.languageCode == languageCode) return;

      _appLocale = await setLocale(languageCode);
    } catch (_) {
      _appLocale = await setLocale(LanguageCodeConst.english);
    } finally {
      notifyListeners();
    }
  }

  Future<void> resetLanguage(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(SPConstants.languageCode);
      fetchLocale(context);
    } catch (_) {
    } finally {
      notifyListeners();
    }
  }
}
