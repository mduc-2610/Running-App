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

  }) : super(
    hintText: hintText,
    hintStyle: hintStyle,
    alignLabelWithHint: alignLabelWithHint,
    border: OutlineInputBorder(borderRadius: borderRadius),
    filled: true,
    fillColor: fillColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: enabledBorderColor, width: 2.0),
      borderRadius: borderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
      borderRadius: borderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorBorderColor, width: 2.0),
      borderRadius: borderRadius,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    errorStyle: errorStyle,
    contentPadding: const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 20.0
    ),
  );
}