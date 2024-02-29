import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final double iconSize;
  final BuildContext context;

  const CustomBackButton({
    Key? key,
    required this.context,
    this.onPressed,
    this.color = Colors.white,
    this.iconSize = 25,
  }) : super(key: key);

  // Default onPressed function
  static void _defaultOnPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: onPressed ?? () => _defaultOnPressed(context),
      color: color,
      iconSize: iconSize,
    );
  }
}
