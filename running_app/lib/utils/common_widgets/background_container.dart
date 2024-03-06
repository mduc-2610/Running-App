import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class BackgroundContainer extends StatelessWidget {
  final double? height;
  final double? width;
  const BackgroundContainer({
    this.height,
    this.width,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
      width: width ?? media.width,
      height: height ?? media.height * 0.535,
      decoration: BoxDecoration(
        color: TColor.PRIMARY.withOpacity(0.6),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(26),
            bottomLeft: Radius.circular(26)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // specify shadow color
            spreadRadius: 2,  // extend the shadow
            blurRadius: 5, // soften the shadow
            offset: Offset(0, 3), // Offset in the y direction for the shadow
          ),
        ],
      ),
    );
  }
}
