import 'package:flutter/material.dart';

import '../constants.dart';
class CustomTextFormField extends TextFormField {
  CustomTextFormField({
    Key? key,
    required InputDecoration decoration,
    required TextInputType keyboardType,
    bool obscureText = false,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
    TextStyle inputTextStyle = const TextStyle(
      color: Color(0xffcdcdcd),
      fontSize: FontSize.NORMAL,
    ),
    Color cursorColor = const Color(0xffcdcdcd),
    TextEditingController? controller,
    int? maxLength,
    int? maxLines,
    String? initialValue,
    double? cursorHeight,
    TextAlign textAlign = TextAlign.left,
  }) : super(
    key: key,
    style: inputTextStyle,
    decoration: decoration,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    onSaved: onSaved,
    controller: controller,
    cursorColor: cursorColor,
    maxLength: maxLength,
    initialValue: initialValue,
    maxLines: maxLines,
    cursorHeight: cursorHeight,
    textAlign:textAlign,
  );
}
