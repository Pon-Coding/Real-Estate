import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import 'demo_localization.dart';

class LanguageCodeConst {
  LanguageCodeConst._();

  static const String english = "en";
  static const String cambodian = "km";
}

class CountryCodeConst {
  CountryCodeConst._();

  static const String unitedKingdom = "GB";
  static const String cambodia = "KH";
}

class LanguageJSONConst {
  LanguageJSONConst._();

  static const String helloWorld = "helloWorld";
  static const String enterOrScanCompanyID = "enterOrScanCompanyID";
  static const String findYourCompanyID = "findYourCompanyID";
  static const String username = "username";
  static const String password = "password";
  static const String iAcceptThe = "iAcceptThe";
  static const String privacyPolicyTermCondition = "privacyPolicyTermCondition";
  static const String resetCompanyID = "resetCompanyID";
  static const String login = "login";
  static const String validateTextEmpty = "validateTextEmpty";
  static const String popUpSecurityAlert = "popUpSecurityAlert";
  static const String popUpSecurityContent1 = "popUpSecurityContent1";
  static const String popUpSecurityContent2 = "popUpSecurityContent2";
  static const String popUpEmulatorAlertContent = "popUpEmulatorAlertContent";
  static const String popUpModifiedAPKAlertContent =
      "popUpModifiedAPKAlertContent";
  static const String popUpClose = "popUpClose";
  static const String popUpAcceptRisk = "popUpAcceptRisk";
  static const String version = "version";
  static const String apiVersion = "apiVersion";
  static const String language = "language";
  static const String privacyPolicy = "privacyPolicy";
  static const String termsAndConditions = "termsAndConditions";
  static const String gninfo = "gninfo";
  static const String settings = "settings";
  static const String logOut = "logOut";
  static const String viewProfile = "viewProfile";
  static const String tabHome = "tabHome";
  static const String tabMenu = "tabMenu";
  static const String tabTeam = "tabTeam";
  static const String tabInbox = "tabInbox";
  static const String welcome = "welcome";
  static const String mySelf = "mySelf";
  static const String myWork = "myWork";
  static const String goodMorning = "goodMorning";
  static const String goodAfternoon = "goodAfternoon";
  static const String goodEvening = "goodEvening";
  static const String goodNight = "goodNight";
  static const String homeQuickAccess = "homeQuickAccess";
  static const String teamTop = "teamTop";
  static const String logoutMessage = "logoutMessage";
  static const String getCompanyLogoMessage = "getCompanyLogoMessage";
}

Locale locale(String languageCode) {
  switch (languageCode) {
    case LanguageCodeConst.english:
      return const Locale(LanguageCodeConst.english);
    case LanguageCodeConst.cambodian:
      return const Locale(LanguageCodeConst.cambodian);
    default:
      return const Locale(LanguageCodeConst.english);
  }
}

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(SPConstants.languageCode, languageCode);
  return locale(languageCode);
}

List<Locale> supportedLocales = [
  locale(LanguageCodeConst.english),
  locale(LanguageCodeConst.cambodian),
];

List<String> isSupportedLocales = [
  LanguageCodeConst.english,
  LanguageCodeConst.cambodian,
];

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).translate(key);
}
