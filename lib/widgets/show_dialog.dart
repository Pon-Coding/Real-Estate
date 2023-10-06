// 1. https://medium.flutterdevs.com/custom-dialog-in-flutter-7ca5c2a8d33a
// 2. https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
import 'package:blue_real_estate/helpers/converters/notification_converter.dart';
import 'package:blue_real_estate/helpers/fonts/text_style_theme.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Future<void> showMyDialog(
  String title,
  NotificationType notificationType, {
  List<String> contentList = const [],
  BuildContext? context,
  bool disableOkButton = false,
  List<Widget> customActionButtons = const [],
}) async {
  List<Widget>? actionButtons = [];
  List<Widget> contentWidgetList = [];
  context = context ?? navigatorkey.currentContext!;

  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context!).pop();
    },
  );

  if (!disableOkButton) actionButtons.add(okButton);
  actionButtons.addAll(customActionButtons);

  for (String content in contentList) {
    contentWidgetList.add(Text(content));
  }

  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: NotificationConverter().getColor(notificationType),
          ),
          child: Text(
            NotificationConverter().getIcon(notificationType),
            style: TextStyle(
              fontFamily: "GrialIconsLine",
              fontSize: FontSizeTheme().headline5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(title),
      ],
    ),
    content: SingleChildScrollView(
      child: ListBody(
        children: contentWidgetList,
      ),
    ),
    actions: actionButtons,
  );

  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return alert;
    },
  );
}
