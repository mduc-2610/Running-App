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
    TextStyle? textStyle = const TextStyle(
      color: Color(0xffcdcdcd),
      fontSize: FontSize.NORMAL,
    ),
    TextEditingController? controller,
  }) : super(
    key: key,
    style: textStyle,
    decoration: decoration,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    onSaved: onSaved,
    controller: controller,
  );
}
