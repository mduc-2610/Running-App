import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;
  final double? leftMargin;
  final double? topMargin;
  final double? rightMargin;
  final double? bottomMargin;

  const MainWrapper({
    Key? key,
    required this.child,
    this.leftMargin,
    this.topMargin,
    this.rightMargin,
    this.bottomMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);

    return Container(
      margin: EdgeInsets.fromLTRB(
          leftMargin ?? media.width * 0.025,
          topMargin ?? media.height * 0.01,
          // topMargin ?? 0,
          rightMargin ?? media.width * 0.025,
          // bottomMargin ?? media.height * 0.025
          bottomMargin ?? 0
      ),
      child: child,
    );
  }
}