import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CheckboxPrimary extends StatelessWidget {
  final bool? value;
  final Function(bool?) onChanged;
  final Color? color;
  const CheckboxPrimary({
    Key? key,
    required this.value,
    required this.onChanged,
    this.color,
  }) : super(key: key);

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return ColorConstants.primaryColor;
    }
    return color ?? ColorConstants.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: value,
      onChanged: onChanged,
    );
  }
}
