import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class CustomMainButton extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final VoidCallback onPressed;
  final Widget child;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Color? background;
  final double? borderWidth;
  final Color? borderWidthColor;
  final ButtonStyle? style;

  const CustomMainButton({
    Key? key,
    required this.horizontalPadding,
    this.verticalPadding = 18.0,
    this.borderRadius = 12.0,
    required this.onPressed,
    required this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.background,
    this.borderWidth,
    this.borderWidthColor,
    this.style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style ?? ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderWidth != null && borderWidthColor != null ?
            BorderSide(color: borderWidthColor!, width: borderWidth!) : BorderSide.none,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(background ?? TColor.PRIMARY),
      ),
      child: suffixIcon == null && prefixIcon == null
          ? child
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIcon ?? SizedBox(),
          const SizedBox(width: 5),
          child,
          const SizedBox(width: 5),
          suffixIcon ?? SizedBox(),
        ],
      ),
    );
  }
}

