// https://stackoverflow.com/questions/53644897/how-do-i-remove-content-padding-from-textfield
// https://www.kindacode.com/article/customize-borders-of-textfield-textformfield-in-flutter/
// https://stackoverflow.com/questions/56730412/change-the-default-border-color-of-textformfield-in-flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';

class TextFormFieldPrimary extends StatelessWidget {
  final int? maxLines;
  final String? initialValue;
  final String? hintText;
  final bool? obscureText;
  final bool? isDense;
  final TextStyle? hintStyle;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextAlign? textAlign;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final BorderSide? errorBorderSide;
  final BorderSide? focusedErrorBorderSide;
  final BorderRadius? enabledBorderRadius;
  final BorderRadius? focusedBorderRadius;
  final BorderRadius? errorBorderRadius;
  final BorderRadius? focusedErrorBorderRadius;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  const TextFormFieldPrimary({
    Key? key,
    this.onSaved,
    this.validator,
    this.obscureText,
    this.isDense,
    this.maxLines,
    this.initialValue,
    this.hintText,
    this.hintStyle,
    this.textAlign,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.errorBorderSide,
    this.focusedErrorBorderSide,
    this.enabledBorderRadius,
    this.focusedBorderRadius,
    this.errorBorderRadius,
    this.focusedErrorBorderRadius,
    this.textInputType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
      obscureText: obscureText ?? false,
      initialValue: initialValue,
      maxLines: obscureText == null || obscureText == false ? maxLines : 1,
      decoration: InputDecoration(
        isDense: isDense,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: isDense == true
            ? const EdgeInsets.symmetric(
                horizontal: PaddingConstants.medium,
                vertical: PaddingConstants.medium)
            : const EdgeInsets.symmetric(horizontal: PaddingConstants.medium),
        enabledBorder: OutlineInputBorder(
          borderRadius: enabledBorderRadius ??
              const BorderRadius.all(Radius.circular(RadiusConstants.medium)),
          borderSide: enabledBorderSide ??
              const BorderSide(color: ColorConstants.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: focusedBorderRadius ??
              const BorderRadius.all(Radius.circular(RadiusConstants.medium)),
          borderSide: focusedBorderSide ??
              const BorderSide(color: ColorConstants.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: errorBorderRadius ??
              const BorderRadius.all(Radius.circular(RadiusConstants.medium)),
          borderSide: errorBorderSide ??
              const BorderSide(color: ColorConstants.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: focusedErrorBorderRadius ??
              const BorderRadius.all(Radius.circular(RadiusConstants.medium)),
          borderSide: focusedErrorBorderSide ??
              const BorderSide(color: ColorConstants.errorColor),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
