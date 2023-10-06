import 'package:flutter/material.dart';

class TextStyleTheme {
  factory TextStyleTheme() => _singleton;
  TextStyleTheme._internal();
  static final TextStyleTheme _singleton = TextStyleTheme._internal();

  /// 36 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().headline1(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? headline1(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().headline1,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );

  /// 32 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().headline2(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? headline2(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().headline2,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );

  /// 28 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().headline3(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? headline3(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().headline3,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );

  /// 24 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().headline4(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? headline4(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().headline4,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );

  /// 18 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().headline5(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? headline5(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().headline5,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );

  /// 14 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().headline6(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? headline6(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().headline6,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );

  /// 10 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().headline7(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? headline7(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().headline7,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );

  /// 16 Regular
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// Text(
  ///   style: TextStyleTheme().paragraph(textColor: Colors.blue),
  /// )
  /// ```
  /// {@end-tool}
  ///
  TextStyle? paragraph(
          {Color? textColor,
          TextDecoration? decoration,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: FontSizeTheme().paragraph,
        color: textColor,
        decoration: decoration,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      );
}

class FontSizeTheme {
  factory FontSizeTheme() => _singleton;
  FontSizeTheme._internal();
  static final FontSizeTheme _singleton = FontSizeTheme._internal();

  /// 36 Regular
  final double? headline1 = 36;

  /// 32 Regular
  final double? headline2 = 32;

  /// 28 Regular
  final double? headline3 = 28;

  /// 24 Regular
  final double? headline4 = 24;

  /// 18 Regular
  final double? headline5 = 18;

  /// 14 Regular
  final double? headline6 = 14;

  /// 10 Regular
  final double? headline7 = 10;

  /// 16 Regular
  final double? paragraph = 16;
}
