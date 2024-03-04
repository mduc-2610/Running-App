import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? iconSize;
  final ButtonStyle? style;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingBottom;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconSize,
    this.style,
    this.paddingLeft,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      color: color,
      iconSize: iconSize,
      style: style,
      padding: EdgeInsets.fromLTRB(
          paddingLeft ?? 0,
          paddingTop ?? 0,
          paddingRight ?? 0,
          paddingBottom ?? 0
      ),

      constraints: BoxConstraints(),
    );
  }
}
