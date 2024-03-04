import 'package:flutter/material.dart';

class CustomStack extends StatelessWidget {
  final List<Widget>? children;

  CustomStack({this.children});

  @override
  Widget build(BuildContext context) {
    // Assuming you have media defined somewhere
    final media = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image.asset(
          "assets/img/home/background_1.png",
          width: media.width,
          height: media.height,
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
