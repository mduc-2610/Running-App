import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart/';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomStack(
        children: [
          BackgroundContainer(
            height: media.height * 0.42,
          ),
          MainWrapper(
            child: Column(
              children: [
                Header(
                  title: "",
                  iconButtons: [
                    {
                      "icon": Icons.settings_outlined,
                      "onPressed": () {
                        Navigator.pushNamed(context, '/setting');
                      }
                    }
                  ],
                ),
                SizedBox(height: media.height * 0.02,),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/img/home/avatar.png",
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: media.width * 0.02,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đặng Minh Đức",
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                        SizedBox(height: media.height * 0.005,),
                        Text(
                          "Starter 7",
                          style: TextStyle(
                              color: TColor.DESCRIPTION,
                              fontSize: FontSize.SMALL,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: media.height * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: media.width * 0.7,
                      height: media.height * 0.17,
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 15
                      ),
                      decoration: BoxDecoration(
                        color: TColor.SECONDARY_BACKGROUND,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Seasonal Ranking",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Current",
                                style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: FontSize.SMALL,
                                    fontWeight: FontWeight.w500
                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Highest",
                                style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: FontSize.SMALL,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        for(var x in [
                          {
                            "icon": Icons.local_activity_outlined,
                            "color": Color(0xff2c50f0),
                            "text": "Activities"
                          },
                          {
                            "icon": Icons.people_outline,
                            "color": Color(0xfff3b242),
                            "text": "Followers"
                          }
                        ])...[
                          CustomTextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(8)
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                TColor.SECONDARY_BACKGROUND
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                )
                              )
                            ),
                            onPressed: () {},
                            child: Column(
                              children: [
                                IconBox(
                                  icon: x["icon"] as IconData,
                                  iconColor: TColor.PRIMARY_TEXT,
                                  iconBackgroundColor: x["color"] as Color,
                                ),
                                Text(
                                  "Activities",
                                  style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            ),
                          ),
                          if(x["text"] == "Activities") SizedBox(height: media.height * 0.01,)
                        ],
                      ],
                    )
                  ],
                ),
                SizedBox(height: media.height * 0.05,),
                // Best performance
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(var x in ["Total stats", "Achievements"])
                          SizedBox(
                            width: media.width * 0.46,
                            child: CustomTextButton(
                              onPressed: () {},
                              child: Text(
                                  x,
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.NORMAL,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: media.width * 0.07
                                      )
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color?>(
                                      x == "Total stats" ? TColor.PRIMARY : null
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  )
                              ),
                            ),
                          )
                      ],
                    ),
                    SizedBox(height: media.height * 0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomBoxLayout(
                              icon: Icons.social_distance,
                              iconColor: Color(0xff000000),
                              iconBackgroundColor: Color(0xffffffff),
                              backgroundColor: Color(0xff232b35),
                              firstText: "0",
                              secondText: "Total Distance",
                              thirdText: " (km)",
                              firstTextColor: Color(0xffffffff),
                              secondTextColor: Color(0xffcdcdcd),
                              layout: 1,
                            ),
                            SizedBox(height: media.height * 0.01,),
                            CustomBoxLayout(
                              icon: Icons.speed_rounded,
                              iconColor: Color(0xffffffff),
                              iconBackgroundColor: Color(0xff6c6cf2),
                              backgroundColor: Color(0xffe1e3fd),
                              firstText: "0",
                              secondText: "Avg. Pace",
                              thirdText: " (min/km)",
                              firstTextColor: Color(0xff000000),
                              secondTextColor: Color(0xff344152),
                              layout: 2,
                            ),
                            SizedBox(height: media.height * 0.01,),
                            CustomBoxLayout(
                              icon: Icons.monitor_heart_outlined,
                              iconColor: Color(0xffffffff),
                              iconBackgroundColor: Color(0xfff3af9b),
                              backgroundColor: Color(0xfffcefeb),
                              firstText: "0",
                              secondText: "Avg. Heartbeat",
                              thirdText: " (bpm)",
                              firstTextColor: Color(0xff000000),
                              secondTextColor: Color(0xff344152),
                              layout: 2,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomBoxLayout(
                              icon: Icons.calendar_today_rounded,
                              iconColor: Color(0xffffffff),
                              iconBackgroundColor: Color(0xfff5c343),
                              backgroundColor: Color(0xfffdf3d3),
                              firstText: "00",
                              secondText: "Active Days",
                              firstTextColor: Color(0xff000000),
                              secondTextColor: Color(0xff344152),
                              layout: 2,
                            ),
                            SizedBox(height: media.height * 0.01,),
                            CustomBoxLayout(
                              icon: Icons.access_time_rounded,
                              iconColor: Color(0xffffffff),
                              iconBackgroundColor: Color(0xff232b35),
                              backgroundColor: Color(0xfff4f6f8),
                              firstText: "0",
                              secondText: "Total Time",
                              firstTextColor: Color(0xff000000),
                              secondTextColor: Color(0xff344152),
                              layout: 1,
                            ),
                            SizedBox(height: media.height * 0.01,),
                            CustomBoxLayout(
                              icon: Icons.directions_run_rounded,
                              iconColor: Color(0xffffffff),
                              iconBackgroundColor: Color(0xff316ff6),
                              backgroundColor: Color(0xff6098f8),
                              firstText: "0",
                              secondText: "Avg. Cadence",
                              thirdText: " (spm)",
                              firstTextColor: Color(0xffffffff),
                              secondTextColor: Color(0xffffffff),
                              layout: 2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconBox extends StatelessWidget {
  final Color iconColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final double? borderRadius;

  const IconBox({
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.icon,
    this.borderRadius,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: iconBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}


class CustomBoxLayout extends IconBox {
  final int layout;
  final String firstText;
  final String secondText;
  final String? thirdText;
  final Color firstTextColor;
  final Color secondTextColor;
  final Color backgroundColor;

  const CustomBoxLayout({
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
        padding: EdgeInsets.symmetric(
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
                    fontWeight: FontWeight.w800
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
                        fontWeight: FontWeight.w800
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


