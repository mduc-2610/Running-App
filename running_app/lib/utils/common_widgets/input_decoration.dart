import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';


class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    String? hintText,
    TextStyle? hintStyle = const TextStyle(
        color: Color(0xffcdcdcd),
        fontSize: FontSize.NORMAL,
    ),
    bool alignLabelWithHint = false,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    Color? fillColor,
    Color enabledBorderColor = const Color(0xff495466),
    Color focusedBorderColor = const Color(0xff42447c),
    Color errorBorderColor = Colors.red,
    TextStyle? errorStyle,
    Icon? prefixIcon,
    Icon? suffixIcon,
    EdgeInsets? contentPadding,
    double borderSide = 2.0,
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never,
    Text? label,
    String? labelText,
    TextStyle? labelStyle,
    String? counterText,
  }) : super(
    hintText: hintText,
    hintStyle: hintStyle,
    alignLabelWithHint: alignLabelWithHint,
    border: OutlineInputBorder(borderRadius: borderRadius),
    filled: true,
    fillColor: fillColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: enabledBorderColor, width: borderSide),
      borderRadius: borderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focusedBorderColor, width: borderSide),
      borderRadius: borderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorBorderColor, width: borderSide),
      borderRadius: borderRadius,
    ),
    floatingLabelBehavior: floatingLabelBehavior,
    errorStyle: errorStyle,
    contentPadding: contentPadding ?? const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 20.0
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    label: label,
    labelText: labelText,
    labelStyle: labelStyle,
    counterText: counterText
  );
}