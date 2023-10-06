import 'package:blue_real_estate/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../providers/app_config_provider.dart';

class URIHelper {
  factory URIHelper() => _singleton;
  URIHelper._internal();
  static final URIHelper _singleton = URIHelper._internal();

  Future<String> combineUriEndPoint(List<String> uriParts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String baseURL = prefs.getString(SPConstants.companyID).toString();
    String version = Provider.of<AppConfigProvider>(
            navigatorkey.currentContext!,
            listen: false)
        .config
        .apiVersion
        .toString();

    if (version.isNotEmpty) {
      baseURL = addAPIVersion(baseURL, version);
    }

    uriParts.insert(0, baseURL);
    return combineUri(uriParts);
  }

  String addAPIVersion(String baseURL, String version) {
    String uri = "";
    if (baseURL.isNotEmpty) {
      List<String> trims = ["\\", "/"];
      uri = trimLastCharacter(
        trimLastCharacter(baseURL, trims.first),
        trims.last,
      );
      uri = "${uri}_v$version";
    }
    return uri;
  }

  String combineUri(List<String> uriParts) {
    String uri = "";
    if (uriParts.isNotEmpty) {
      List<String> trims = ["\\", "/"];
      uri = trimLastCharacter(
        trimLastCharacter((uriParts[0]), trims.first),
        trims.last,
      );
      for (int i = 1; i < uriParts.length; i++) {
        String firstUri = trimFirstCharacter(
            trimFirstCharacter(uri, trims.first), trims.last);
        firstUri = trimLastCharacter(
            trimLastCharacter(firstUri, trims.first), trims.last);
        String secondUri = trimFirstCharacter(
            trimFirstCharacter((uriParts[i]), trims.first), trims.last);
        secondUri = trimLastCharacter(
            trimLastCharacter(secondUri, trims.first), trims.last);
        uri = "$firstUri/$secondUri";
      }
    }
    return uri;
  }

  String trimLastCharacter(String srcStr, String pattern) {
    if (srcStr.isNotEmpty) {
      if (srcStr.endsWith(pattern)) {
        final v = srcStr.substring(0, srcStr.length - pattern.length);
        return trimLastCharacter(v, pattern);
      }
      return srcStr;
    }
    return srcStr;
  }

  String trimFirstCharacter(String srcStr, String pattern) {
    if (srcStr.isNotEmpty) {
      if (srcStr.startsWith(pattern)) {
        final v = srcStr.substring(pattern.length, srcStr.length);
        return trimFirstCharacter(v, pattern);
      }
      return srcStr;
    }
    return srcStr;
  }
}
