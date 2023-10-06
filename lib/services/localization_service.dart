import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoint.dart';
import '../constants/constants.dart';
import '../providers/localization_provider.dart';
import '../helpers/uri_helper.dart';
import '../models/api_response.dart';
import 'network_service.dart';

class LocalizationService {
  Future<void> get(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String path =
        await URIHelper().combineUriEndPoint([APIEndpoint.localization]);

    ApiResponse response =
        await NetworkService().requestAsync(path, Method.get);

    await prefs.setString(
        SPConstants.localizationString, response.data as String);

    await Provider.of<LocalizationProvider>(context, listen: false)
        .init(response.data as String);
  }
}
