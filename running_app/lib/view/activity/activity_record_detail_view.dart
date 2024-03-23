import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom_sheet.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class ActivityRecordDetailView extends StatefulWidget {
  const ActivityRecordDetailView({super.key});

  @override
  State<ActivityRecordDetailView> createState() => _ActivityRecordDetailViewState();
}

class _ActivityRecordDetailViewState extends State<ActivityRecordDetailView> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(title: "Activity", noIcon: true),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: media.height * 0.01,),
                    //User section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/img/community/ptit_logo.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: media.width * 0.02,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dang Minh Duc",
                                    style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.NORMAL,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.run_circle_rounded,
                                        color: TColor.DESCRIPTION,
                                        size: 20,
                                      ),
                                      Text(
                                        " Feb 12, 2024 at 1:36 PM",
                                        style: TxtStyle.descSection,
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        CustomIconButton(
                          icon: Icon(
                            Icons.more_horiz_rounded,
                            color: TColor.PRIMARY_TEXT,
                          ),
                          onPressed: () {
                            showActionList(
                                context,
                                [
                                  {
                                    "text": "Edit Activity",
                                    "onPressed": () {
                                      Navigator.pushNamed(context, '/activity_record_edit');
                                    }
                                  },
                                  {
                                    "text": "Delete Activity",
                                    "textColor": Colors.red,
                                    "onPressed": () {
        
                                    }
                                  }
                                ],
                                "Options");
                          },
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.01,),
        
                    // Caption section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Afternoon Run",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.NORMAL,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "Lorem ",
                          style: TxtStyle.descSection,
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.01,),
        
                    // Stats section
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     for (int j = 0; j < 3; j++) ...[
                    //       Row(
                    //         children: [
                    //           if (j != 0) ...[
                    //             SeparateBar(
                    //                 width: 2, height: media.height * 0.04),
                    //             SizedBox(width: media.width * 0.03)
                    //           ],
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 "Distance",
                    //                 style: TextStyle(
                    //                     color: TColor.DESCRIPTION,
                    //                     fontSize: FontSize.SMALL,
                    //                     fontWeight: FontWeight.w500),
                    //               ),
                    //               Text(
                    //                 "1.83 km",
                    //                 style: TextStyle(
                    //                     color: TColor.PRIMARY_TEXT,
                    //                     fontSize: FontSize.NORMAL,
                    //                     fontWeight: FontWeight.w800),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ]
                    //   ],
                    // ),
        
                    // Image section
                    Column(
                      children: [
                        SizedBox(
                          height: media.height * 0.27,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              scrollDirection: Axis.horizontal,
                              viewportFraction: 1
                            ),
                            items: [
                              Image.asset(
                                "assets/img/community/ptit_background.jpg",
                                fit: BoxFit.contain,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        DotsIndicator(
                          dotsCount: 10,
                          position: currentSlide,
                          decorator: DotsDecorator(
                            activeColor: TColor.PRIMARY,
                            spacing: const EdgeInsets.only(left: 8),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.01,),
        
                    // Stats detail section
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10
                          ),
                          width: media.width,
                          decoration: BoxDecoration(
                            color: TColor.SECONDARY_BACKGROUND,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 1,
                              color: TColor.BORDER_COLOR
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Distance: ",
                                style: TextStyle(
                                  color: TColor.DESCRIPTION,
                                  fontSize: FontSize.SMALL,
                                ),
                              ),
                              Text(
                                "1.83 km",
                                style: TxtStyle.headSection,
                              )
                            ],
                          ),
                        ),
                        // SizedBox(height: media.height * 0.01,),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                            )
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: media.height * 0.15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    for (var x in [
                                      {
                                        "type": "Moving Time",
                                        "figure": "1.83km",
                                      },
                                      {
                                        "type": "Avg. Moving Pace",
                                        "figure": "1.83km",
                                      },
                                    ]) ...[
                                      Container(
                                        width: media.width * 0.45,
                                        // width: (media.width - media.,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              x["type"] as String,
                                              style: TextStyle(
                                                color: TColor.DESCRIPTION,
                                                fontSize: FontSize.SMALL,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: media.height * 0.01,),
                                            Text(
                                              x["figure"] as String,
                                              style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.EXTRA_LARGE,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      if(x["type"] == "Moving Time") SeparateBar(width: 1, height: media.height * 0.2, color: TColor.BORDER_COLOR,),
                                    ],
                                  ],
                                ),
                              ),
                              SeparateBar(width: media.width, height: 1, color: TColor.BORDER_COLOR,),
                              SizedBox(
                                height: media.height * 0.15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (var x in [
                                      {
                                        "type": "Elapsed Time",
                                        "figure": "1.83km",
                                      },
                                      {
                                        "type": "Avg. Elapsed Pace",
                                        "figure": "1.83km",
                                      },
                                    ]) ...[
                                      Container(
                                        width: media.width * 0.45,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              x["type"] as String,
                                              style: TextStyle(
                                                color: TColor.DESCRIPTION,
                                                fontSize: FontSize.SMALL,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: media.height * 0.01,),
                                            Text(
                                              x["figure"] as String,
                                              style: TxtStyle.extraLargeText
                                            )
                                          ],
                                        ),
                                      ),
                                      if(x["type"] == "Elapsed Time") SeparateBar(width: 1, height: media.height * 0.2, color: TColor.BORDER_COLOR,),
                                    ],
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(height: media.height * 0.01,),

                        Container(
                          width: media.width,
                          decoration: BoxDecoration(
                            color: TColor.SECONDARY_BACKGROUND,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 1,
                              color: TColor.BORDER_COLOR
                            )
                          ),
                          child: Column(
                            children: [
                              for(var x in [
                                {
                                  "stats": "Elevation Gain",
                                  "figure": "4m"
                                },
                                {
                                  "stats": "Calories",
                                  "figure": "128 Cal"
                                },
                                {
                                  "stats": "Avg. Cadence",
                                  "figure": "161 spm"
                                },
                              ])...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 12
                                  ),
                                  decoration: BoxDecoration(
                                    border: (x["stats"] != "Avg. Cadence") ? Border(
                                      bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                                    ) : null
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        x["stats"] as String,
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.SMALL,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        x["figure"] as String,
                                        style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.SMALL,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ]
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Social section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "2 comments",
                          style: TxtStyle.normalTextDesc,
                        ),
                        SizedBox(height: media.height * 0.015,),

                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                                bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                            )
                          ),
                          child: Row(
                            mainAxisAlignment:  MainAxisAlignment.spaceAround,
                            children: [
                              for(var x in [
                                {
                                  "icon": Icons.thumb_up_alt_outlined,
                                  "text": "Like",
                                },
                                {
                                  "icon": Icons.mode_comment_outlined,
                                  "text": "Comment",
                                },
                                {
                                  "icon": Icons.ios_share_rounded,
                                  "text": "Share",
                                }
                              ])...[
                                CustomTextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        x["icon"] as IconData,
                                        color: TColor.PRIMARY_TEXT,
                                      ),
                                      SizedBox(width: media.width * 0.02,),
                                      Text(
                                        x["text"] as String,
                                        style: TxtStyle.normalText,
                                      )
                                    ],
                                  ),
                                ),
                                if(x["text"] != "Share") SeparateBar(width: 1, height: 45, color: TColor.BORDER_COLOR,)
                              ]
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // View Analysis
                    CustomTextButton(
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12
                        ),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "View analysis",
                                  style: TxtStyle.headSection,
                                ),
                                SizedBox(height: media.height * 0.01,),
                                Text(
                                  "View your activity detailed analytics",
                                  style: TxtStyle.descSection,
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: TColor.PRIMARY_TEXT,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
