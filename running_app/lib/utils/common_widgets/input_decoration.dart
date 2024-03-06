import 'package:flutter/material.dart';


class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    String? hintText,
    TextStyle? hintStyle = const TextStyle(
        color: Color(0xffcdcdcd),
        fontSize: 15
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
    floatingLabelBehavior: FloatingLabelBehavior.never,
    errorStyle: errorStyle,
    contentPadding: contentPadding ?? const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 20.0
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );
}