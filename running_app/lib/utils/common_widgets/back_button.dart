import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';

class CustomBackButton extends CustomIconButton {
  final BuildContext context;

  CustomBackButton({
    Key? key,
    VoidCallback? onPressed,
    Color? color,
    double? iconSize,
    double? paddingLeft,
    double? paddingTop,
    double? paddingRight,
    double? paddingBottom,
    required this.context,
  }) : super(
    key: key,
    icon: const Icon(Icons.arrow_back_ios_rounded),
    onPressed: onPressed ?? () => _defaultOnPressed(context),
    color: color ?? Colors.white,
    iconSize: iconSize ?? 22,
    paddingLeft: paddingLeft,
    paddingTop: paddingTop,
    paddingRight: paddingRight,
    paddingBottom: paddingBottom
  );

  static void _defaultOnPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
