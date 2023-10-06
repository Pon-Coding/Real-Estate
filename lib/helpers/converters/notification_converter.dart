import 'package:blue_real_estate/constants/constants.dart';
import 'package:blue_real_estate/helpers/fonts/grial_icons_font.dart';
import 'package:flutter/material.dart';

enum NotificationType { confirmation, notification, success, error, warning }

class NotificationConverter {
  factory NotificationConverter() => _singleton;
  NotificationConverter._internal();
  static final NotificationConverter _singleton =
      NotificationConverter._internal();

  String getIcon(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.confirmation:
        return GrialIconsFont.check;
      case NotificationType.notification:
        return GrialIconsFont.bell;
      case NotificationType.success:
        return GrialIconsFont.check;
      case NotificationType.error:
        return GrialIconsFont.close;
      case NotificationType.warning:
        return GrialIconsFont.alertTriangle;
      default:
        return GrialIconsFont.bell;
    }
  }

  Color getColor(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.confirmation:
        return ColorConstants.primaryColor;
      case NotificationType.notification:
        return ColorConstants.primaryColor;
      case NotificationType.success:
        return ColorConstants.successColor;
      case NotificationType.error:
        return ColorConstants.errorColor;
      case NotificationType.warning:
        return ColorConstants.primaryColor;
      default:
        return ColorConstants.primaryColor;
    }
  }
}
