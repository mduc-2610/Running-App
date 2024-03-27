import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class EventMemberDetailView extends StatefulWidget {
  const EventMemberDetailView({super.key});

  @override
  State<EventMemberDetailView> createState() => _EventMemberDetailViewState();
}

class _EventMemberDetailViewState extends State<EventMemberDetailView> {
  bool certified = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: const CustomAppBar(
          title: Header(title: "Dang Minh Duc", noIcon: true,),
        ),
        body: DefaultBackgroundLayout(
          child: Stack(
              children: [
                MainWrapper(
                  child: Column(
                    children: [
                      // User section
                      CustomTextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 2, color: TColor.BORDER_COLOR)
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      "assets/img/community/ptit_logo.png",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(width: media.width * 0.03,),
                                  Text(
                                    "Dang Minh Duc",
                                    style: TextStyle(
                                      color: TColor.PRIMARY_TEXT,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: TColor.PRIMARY_TEXT,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: media.height * 0.02,),

                      // User stats section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for(var x in [
                            {
                              "icon": "assets/img/activity/distance_icon.svg",
                              "figure": "2,422km",
                              "text": "Total distance",
                            },
                            {
                              "icon": "assets/img/activity/timer_icon.svg",
                              "figure": "182h22m",
                              "text": "Total time",
                            }
                          ])
                          Container(
                            width: media.width * 0.46,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12
                            ),
                            decoration: BoxDecoration(
                              color: TColor.SECONDARY_BACKGROUND,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: TColor.BORDER_COLOR
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  x["icon"] as String,
                                  width: 35,
                                  height: 35,
                                ),
                                SizedBox(width: media.width * 0.03,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      x["figure"] as String,
                                      style: TxtStyle.headSection,
                                    ),
                                    Text(
                                      x["text"] as String,
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),

                      // Activities and active days section
                      Column(
                        children: [
                          for(var x in [
                            {
                              "icon": const Icon(
                                Icons.local_fire_department_outlined,
                                color: Color(0xffF3Af3D),
                                size: 30,
                              ),
                              "text": "Total activities",
                              "figure": "464"
                            },
                            {
                              "icon": const Stack(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: Color(0xff6C6CF2),
                                    size: 30,
                                  ),
                                  Positioned(
                                    left: 5,
                                    bottom: 2,
                                    child: Icon(
                                      Icons.check,
                                      color: Color(0xff6C6CF2),
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                              "text": "Active days",
                              "figure": "40"
                            }
                          ])
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(width: 2, color: TColor.BORDER_COLOR)
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    x["icon"] as Widget,
                                    SizedBox(width: media.width * 0.03,),
                                    Text(
                                      "Dang Minh Duc",
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.NORMAL,
                                          fontWeight: FontWeight.w600
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "40",
                                  style: TextStyle(
                                      color: TColor.PRIMARY_TEXT,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),

                      CustomTextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2, color: TColor.BORDER_COLOR),
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Valid activities",
                                    style: TxtStyle.headSection
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: TColor.PRIMARY_TEXT,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: media.height * 0.02,),

                      // Notify certification section
                      if(false)...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16
                          ),
                          decoration: BoxDecoration(
                              color: TColor.SECONDARY_BACKGROUND,
                              border: Border.all(
                                  width: 1,
                                  color: TColor.BORDER_COLOR
                              ),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: TColor.PRIMARY,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: TColor.PRIMARY_TEXT,
                                  size: 40,
                                ),
                              ),
                              SizedBox(width: media.width * 0.05,),
                              SizedBox(
                                width: media.width * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Challenge completed ",
                                      style: TextStyle(
                                          color: TColor.PRIMARY,
                                          fontSize: FontSize.LARGE,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.9
                                      ),
                                    ),
                                    SizedBox(height: media.height * 0.005,),
                                    Text(
                                      "Congratulations on completing the running event challenge! Your dedication and contribution is truly commendable.",
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ] else...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16
                          ),
                          decoration: BoxDecoration(
                              color: TColor.SECONDARY_BACKGROUND,
                              border: Border.all(
                                  width: 1,
                                  color: TColor.BORDER_COLOR
                              ),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: TColor.PRIMARY,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.clear_rounded,
                                  color: TColor.PRIMARY_TEXT,
                                  size: 40,
                                ),
                              ),
                              SizedBox(width: media.width * 0.05,),
                              SizedBox(
                                width: media.width * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Not completed ",
                                      style: TextStyle(
                                          color: TColor.PRIMARY,
                                          fontSize: FontSize.LARGE,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.9
                                      ),
                                    ),
                                    SizedBox(height: media.height * 0.005,),
                                    Text(
                                      "Member hasn't completed this challenge",
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                )
              ]
          ),
        )
    );
  }
}