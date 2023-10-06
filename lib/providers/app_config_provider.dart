import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/app_config.dart';

class AppConfigProvider with ChangeNotifier {
  AppConfig _config = AppConfig();

  static const String dev = "dev";
  static const String prod = "prod";

  AppConfig get config => _config;

  Future<void> initConfig(String environment) async {
    _config = await _getconfig(environment);
    notifyListeners();
  }

  Future<AppConfig> _getconfig(String env) async {
    final contents = await rootBundle.loadString('lib/assets/configs/$env.json',
        cache: false);
    final json = jsonDecode(contents);
    return AppConfig.fromJson(json);
  }
}
