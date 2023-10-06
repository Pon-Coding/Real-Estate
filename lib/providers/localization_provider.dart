import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../helpers/extensions/string_ext.dart';
import '../main.dart';
import 'app_language_provider.dart';

class LocalizationProvider with ChangeNotifier {
  String _localization = StringExtension.emptyString;

  String get localization => _localization;

  Future<void> init(String localization) async {
    try {
      _localization = localization;
      Provider.of<AppLanguageProvider>(navigatorkey.currentContext!,
              listen: false)
          .notifyListeners();
    } catch (_) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> initFromStorage(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? localizationString =
          prefs.getString(SPConstants.localizationString);
      if (localizationString != null && localizationString.isNotEmpty) {
        _localization = localizationString;
        Provider.of<AppLanguageProvider>(context, listen: false)
            .notifyListeners();
      }
    } catch (_) {
    } finally {
      notifyListeners();
    }
  }
}
