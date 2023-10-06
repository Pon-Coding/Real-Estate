import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppTheme {
  AppTheme._();
  static const VerticalDivider verticalDivider = VerticalDivider(
    width: 2,
     thickness: 2,
    color: ColorConstants.primaryColor,
  );
  static const Divider horizontalDivider = Divider(
    height: 2,
     thickness: 2,
    color: ColorConstants.primaryColor,
  );
}
