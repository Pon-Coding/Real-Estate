import 'package:blue_real_estate/constants/constants.dart';
import 'package:flutter/material.dart';

@immutable
class BoxOutline extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsets? padding;
  final Border? border;
  final BorderRadius? borderRadius;
  final AlignmentGeometry? alignment;

  const BoxOutline({
    Key? key,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.border,
    this.borderRadius,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius:
            borderRadius ?? BorderRadius.circular(RadiusConstants.medium),
        border: border ?? Border.all(color: ColorConstants.primaryColor),
      ),
      child: child,
    );
  }
}
