import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final VoidCallback onPressed;
  final Widget child;
  final Icon? icon;
  final Color? background;

  const CustomMainButton({
    Key? key,
    required this.horizontalPadding,
    this.verticalPadding = 18.0,
    this.borderRadius = 12.0,
    required this.onPressed,
    required this.child,
    this.icon,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(background),
      ),
      child: icon == null
          ? child
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          const SizedBox(width: 5), // Adjust spacing between text and icon
          icon!,
        ],
      ),
    );
  }
}

