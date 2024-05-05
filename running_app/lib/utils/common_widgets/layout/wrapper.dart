import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                TImage.PRIMARY_BACKGROUND_IMAGE
              ),
              fit: BoxFit.cover),
        ),
        child: child);
  }
}
