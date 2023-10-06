import 'package:flutter/material.dart';

import '../main.dart';

Future<void> showModalBottomScrollable(
  List<Widget> listViewChildren, {
  BuildContext? context,
  double initialChildSize = 0.9,
  double minChildSize = 0.5,
  double maxChildSize = 1,
}) {
  context = context ?? navigatorkey.currentContext!;

  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: controller,
              children: listViewChildren,
            ),
          ),
        ),
      );
    },
  );
}
