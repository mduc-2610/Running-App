import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  Color? backgroundColor;
  double? marginTop;
  double? height;
  Loading({
    this.backgroundColor,
    this.marginTop,
    this.height,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          width: media.width,
          height: height ?? media.height,
          // width: media.w,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.black.withOpacity(0.2),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: marginTop ?? media.height * 0.37,
          ),
          child: Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: const [Colors.white],
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
