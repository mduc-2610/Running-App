import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext context;
  final VoidCallback? onPressed;

  CustomBackButton({
    Key? key,
    required this.context,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icon(Icons.arrow_back_ios_rounded),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}
