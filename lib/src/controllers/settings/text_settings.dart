import 'package:flutter/material.dart';

/// Represents settings used to create and draw text.
@immutable
class TextSettings {
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextAlign textAlign;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Border? border;
  final FocusNode? focusNode; // Keep FocusNode but make it optional

  const TextSettings({
    this.fontSize = 14,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.textAlign = TextAlign.center,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.border,
    this.focusNode,
  });

  TextStyle get textStyle => TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      );

  TextSettings copyWith({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    TextAlign? textAlign,
    Color? backgroundColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Border? border,
    FocusNode? focusNode,
  }) {
    return TextSettings(
      fontSize: fontSize ?? this.fontSize,
      color: color ?? this.color,
      fontWeight: fontWeight ?? this.fontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
      textAlign: textAlign ?? this.textAlign,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
    );
  }
}
