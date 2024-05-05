import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class BackgroundContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  const BackgroundContainer({
    this.height,
    this.width,
    this.borderRadius,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
      width: width ?? media.width,
      height: height ?? media.height * 0.44,
      decoration: BoxDecoration(
        color: TColor.PRIMARY.withOpacity(0.6),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(borderRadius ?? 26),
            bottomLeft: Radius.circular(borderRadius ?? 26)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // specify shadow color
            spreadRadius: 2,  // extend the shadow
            blurRadius: 5, // soften the shadow
            offset: const Offset(0, 3), // Offset in the y direction for the shadow
          ),
        ],
      ),
    );
  }
}
