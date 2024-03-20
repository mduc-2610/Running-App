import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class SeparateBar extends StatelessWidget {
  final double width;
  final double height;
  const SeparateBar({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Width of the bar
      height: height, // Height of the bar
      decoration: BoxDecoration(
        color: TColor.DESCRIPTION, // Color of the bar
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
    );
  }
}