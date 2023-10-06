import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../providers/localization_provider.dart';
import 'language_localization.dart';

class DemoLocalization {
  DemoLocalization(this.locale);

  final Locale locale;
  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization)!;
  }

  Map<String, String> _localizedValues = {};

  Future<void> load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/l10n/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));

    if (navigatorkey.currentContext != null) {
      String providerLocalization = Provider.of<LocalizationProvider>(
              navigatorkey.currentContext!,
              listen: false)
          .localization;
      if (providerLocalization.isNotEmpty) {
        Map<String, dynamic> mappedJsonFromServer =
            json.decode(providerLocalization);
        _localizedValues.addEntries(mappedJsonFromServer
            .map((key, value) => MapEntry(key, value.toString()))
            .entries);
      }
    }
  }

  String translate(String key) {
    return _localizedValues[key].toString();
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<DemoLocalization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return isSupportedLocales.contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) => true;
}
