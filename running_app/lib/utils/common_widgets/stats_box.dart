import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/icon_box.dart';
import 'package:running_app/utils/constants.dart';


class StatsBoxLayout extends IconBox {
  final int layout;
  final String firstText;
  final String secondText;
  final String? thirdText;
  final Color firstTextColor;
  final Color secondTextColor;
  final Color backgroundColor;

  const StatsBoxLayout({
    required Color iconColor,
    required Color iconBackgroundColor,
    required IconData icon,
    double? borderRadius,
    required this.layout,
    required this.firstText,
    required this.secondText,
    required this.firstTextColor,
    this.thirdText,
    required this.secondTextColor,
    required this.backgroundColor,
    super.key
  }) : super(
      iconColor: iconColor,
      icon: icon,
      iconBackgroundColor: iconBackgroundColor,
      borderRadius: borderRadius
  );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
        padding: const EdgeInsets.symmetric(
//         // vertical: 20,
          horizontal: 10,
        ),
        height: media.height * (layout == 1 ? 0.20 : 0.12),
        width: media.width * 0.46,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(layout == 1)...[
              IconBox(
                iconColor: iconColor,
                iconBackgroundColor: iconBackgroundColor,
                icon: icon,
              ),
              SizedBox(height: media.height * 0.01,),
              Text(
                  firstText,
                  style: TextStyle(
                      color: firstTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    letterSpacing: 0.9
                  )
              ),
              SizedBox(height: media.height * 0.01,),
            ]
            else...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      firstText,
                      style: TextStyle(
                          color: firstTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        letterSpacing: 0.9
                      )
                  ),
                  IconBox(
                    iconColor: iconColor,
                    iconBackgroundColor: iconBackgroundColor,
                    icon: icon,
                  ),
                ],
              ),
              SizedBox(height: media.height * 0.01,),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  secondText,
                  style: TextStyle(
                      color: secondTextColor,
                      fontSize: FontSize.SMALL,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  thirdText ?? "",
                  style: TextStyle(
                      color: secondTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}

