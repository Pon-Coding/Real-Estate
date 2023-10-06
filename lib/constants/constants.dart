import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static const String appName = "blueRE";
  static const String copyRight = "© 2022 by blue Technology Co., Ltd.";

  static const String fontGrialLine = "GrialIconsLine";
  static const String fontGrialFill = "GrialIconsFill";

  static const String appFeatureRoot = "root";
  static const String appFeatureMain = "main";
  static const String appFeatureMenu = "menu";
  static const String appFeatureHome = "home";
  static const String appFeatureInbox = "inbox";
  static const String appFeatureHomeShortCut = "home_shortcut";
  static const String appFeatureHomeWebView = "home_webview";
  static const String appFeatureMySelf = "my_self";
  static const String appFeatureMyTeam = "my_team";
  static const String searchPageTypeFlutter = "F";
  static const String searchPageTypeWebView = "W";
  static const double textHeight = 40.0;
  static bool isValidHexaCode(String str) {
    RegExp hexColor = RegExp(r'^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

    if (!str.isNotEmpty) {
      return false;
    }

    if (hexColor.hasMatch(str)) {
      return true;
    } else {
      return false;
    }
  }
}

class PhotoConstants {
  PhotoConstants._();

  static const String defaultLocation = "lib/assets/images";

  static const String appIcon = "$defaultLocation/app_icon.svg";
  static const String defaultProfile =
      "$defaultLocation/default_profile_user.svg";
  static const String pageNotFound = "$defaultLocation/not_found.svg";
  static const String inboxIcon = "$defaultLocation/inbox.svg";
  static const String orgChartTop = "$defaultLocation/org_chart_top.svg";
  static const String orgChartInfo = "$defaultLocation/org_chart_info.svg";
  static const String orgChartBack = "$defaultLocation/org_chart_back.svg";
  static const String orgChartNext = "$defaultLocation/org_chart_next.svg";
  static const String otpIcon = "$defaultLocation/otp_icon.svg";
}

class GifConstants {
  GifConstants._();

  static const String defaultLocation = "lib/assets/gifs";

  static const String success = "$defaultLocation/success.json";
  static const String successFingerprint =
      "$defaultLocation/fingerprint_success.json";
  static const String error = "$defaultLocation/error.json";
  static const String errorFingerprint =
      "$defaultLocation/fingerprint_fail.json";
  static const String pleaseWait = "$defaultLocation/please_wait.json";
}

class SPConstants {
  // SharedPreferences - Local Storage
  SPConstants._();

  static const String languageCode = "language_code";
  static const String companyID = "company_id";
  static const String token = "token";
  static const String tokenExpire = "token_expire";
  static const String oldID = "old_id";
  static const String id = "id";
  static const String appLogo = "app_logo";
  static const String isTriggeredLocalNetwork = "is_triggered_local_network";
  static const String enableTwoFA = "enable_twoFA";
  static const String verifiedTwoFA = "verified_twoFA";
  static const String localizationString = "localization_string";
  static const String localizationVersion = "localization_version";
}

class ColorConstants {
  ColorConstants._();

  static const Color primaryColor = Color.fromRGBO(30, 141, 200, 1);
  static const Color secondaryColor = Colors.white;
  static const Color tertiaryColor = Colors.white;
  static const Color quaternaryColor = Color.fromRGBO(196, 196, 196, 1);

  static const Color onPrimaryColor = Colors.white;
  static const Color onSecondaryColor = Colors.black;
  static const Color onTertiaryColor = Colors.white;
  static const Color onQuaternaryColor = Colors.black;

  static const Color backgroundColor = Color.fromRGBO(249, 249, 249, 1);
  static const Color surfaceColor = Color.fromRGBO(30, 141, 200, 1);
  static const Color errorColor = Color.fromRGBO(176, 0, 32, 1);
  static const Color successColor = Color.fromRGBO(40, 167, 69, 1);
  static const Color badgeColor = Color.fromRGBO(176, 0, 32, 1);

  static const Color onBackgroundColor = Colors.black;
  static const Color onSurfaceColor = Colors.white;
  static const Color onErrorColor = Colors.white;
  static const Color onSuccessColor = Colors.white;
  static const Color onBadgeColor = Colors.white;
}

class RadiusConstants {
  RadiusConstants._();

  /// Small - 5
  static const double small = 5;

  /// Medium - 10
  static const double medium = 10;

  /// Large - 15
  static const double large = 15;

  /// Extra large - 20
  static const double extraLarge = 20;
}

class PaddingConstants {
  PaddingConstants._();

  /// None - 0
  static const double none = 0;

  /// None - 2
  static const double mini = 1;

  /// Small - 5
  static const double small = 5;

  /// Medium - 10
  static const double medium = 10;

  /// Large - 15
  static const double large = 15;

  /// Extra large - 20
  static const double extraLarge = 20;
}

class SpaceConstants {
  SpaceConstants._();

  /// None - 0
  static const double none = 0;

  /// None - 2
  static const double mini = 2;

  /// Small - 5
  static const double small = 5;

  /// Medium - 10
  static const double medium = 10;

  /// Large - 15
  static const double large = 15;

  /// Extra large - 20
  static const double extraLarge = 20;
}

class Pagination {
  Pagination._();

  static const int recordlimitation = 10;
  static const int defaultPage = 1;

  static const String? limit = "limit";
  static const String? page = "page";
  static const String? sort = "sort";
  static const String? filter = "filter";

  static const String? next = "next";
  static const String? prev = "prev";
  static const String? first = "first";
  static const String? last = "last";

  static Map<String, String> getParameters(
      {String sort = "",
      String filter = "",
      int page = defaultPage,
      int limit = recordlimitation}) {
    //  List<Map<String, String>> parameters =[];

    // parameters.add(Map<String, String>(Pagination.LIMIT, limit.toString()));
    // parameters.add(Map<String, String>(Pagination.PAGE, page.toString()));
    // parameters.add(Map<String, String>(Pagination.SORT, sort));
    // parameters.add(Map<String, String>(Pagination.FILTER, filter));

    // List<Map<String?, String?>> parameters = [
    //   {Pagination.limit: limit.toString()},
    //   {Pagination.page: page.toString()},
    //   {Pagination.sort: sort},
    //   {Pagination.filter: filter}
    // ];
    // Map<String, String>? parameters = {
    //   // Pagination.limit!: limit.toString(),
    //   // Pagination.page!: page.toString(),
    //   Pagination.sort!: sort!,
    //   Pagination.filter!: filter!
    // };

    Map<String, String> parameter = {
      Pagination.sort!: sort,
      Pagination.filter!: filter,
      Pagination.page!: page.toString(),
      Pagination.limit!: limit.toString()
    };
    return parameter;
  }
}
