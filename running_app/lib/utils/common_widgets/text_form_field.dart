import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextStyle? inputTextStyle;
  final Color cursorColor;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final String? initialValue;
  final double? cursorHeight;
  final TextAlign textAlign;
  final bool? clearIcon;
  final FocusNode? focusNode;
  final ValueChanged? onChanged;
  final VoidCallback? onClearChanged;
  final bool? showClearButton;
  final bool? readOnly;
  final bool noneEditable;
  const CustomTextFormField({
    Key? key,
    required this.decoration,
    required this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.inputTextStyle,
    this.cursorColor = const Color(0xffcdcdcd),
    this.controller,
    this.maxLength,
    this.maxLines,
    this.initialValue,
    this.cursorHeight,
    this.textAlign = TextAlign.left,
    this.clearIcon = true,
    this.focusNode,
    this.onChanged,
    this.onClearChanged,
    this.showClearButton,
    this.readOnly,
    this.noneEditable = false,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _showClearButton;

  @override
  void initState() {
    super.initState();
    _showClearButton = widget.showClearButton ?? widget.controller?.text.isNotEmpty ?? false;
    widget.controller?.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = widget.controller?.text.isNotEmpty ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.inputTextStyle ?? TextStyle(
          color: (widget.noneEditable == false) ? Color(0xffcdcdcd) : Color(0xffcdcdcd).withOpacity(0.5),
          fontSize: FontSize.NORMAL,
      ),
      decoration: widget.decoration.copyWith(
        suffixIcon: (widget.clearIcon == true && _showClearButton && !widget.noneEditable)
            ? IconButton(
          icon: Icon(
              Icons.cancel,
              color: TColor.DESCRIPTION,
              size: 20,
          ),
          onPressed: widget.onClearChanged ?? () {
            if (widget.controller != null) {
              widget.controller!.clear();
              setState(() {
                _showClearButton = false;
              });
            }
          },
        )
            : null,
      ),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      maxLines: widget.maxLines ?? 1,
      cursorHeight: widget.cursorHeight,
      textAlign: widget.textAlign,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      readOnly: widget.noneEditable,
    );
  }
}
