import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/img/home/background_1.png",
              ),
              fit: BoxFit.cover),
        ),
        child: child);
  }
}
