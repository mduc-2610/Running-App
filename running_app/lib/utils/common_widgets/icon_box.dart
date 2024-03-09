import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final Color iconColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final double? borderRadius;

  const IconBox({
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.icon,
    this.borderRadius,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: iconBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}