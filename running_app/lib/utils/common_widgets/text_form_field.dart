import 'package:flutter/material.dart';

import '../constants.dart';
class CustomTextFormField extends TextFormField {
  CustomTextFormField({
    Key? key,
    required InputDecoration decoration, // Require decoration to be provided
    required TextInputType keyboardType, // Require keyboardType to be provided
    bool obscureText = false,
    FormFieldValidator<String>? validator, // Allow validator to be nullable
    FormFieldSetter<String>? onSaved, // Allow onSaved to be nullable
    TextStyle inputTextStyle = const TextStyle(
      color: Color(0xffcdcdcd),
      fontSize: FontSize.NORMAL,
    ),
    Color cursorColor = const Color(0xffcdcdcd),
    TextEditingController? controller,
    int? maxLength,
    String? initialValue,
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

  );
}
