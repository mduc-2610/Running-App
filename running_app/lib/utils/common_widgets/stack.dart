import 'package:flutter/material.dart';

class CustomStack extends StatelessWidget {
  final List<Widget>? children;
  final double? backgroundHeight;

  const CustomStack({super.key, this.children, this.backgroundHeight});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Image.asset(
          "assets/img/home/background_1.png",
          width: media.width,
          height: backgroundHeight ?? media.height,
          fit: BoxFit.cover,
        ),
        ...?children,
        // You can add other widgets on top of the image here
      ],
    );
  }
}

// Usage:
// CustomStackWidget()
