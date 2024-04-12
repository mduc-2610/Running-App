import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/limit_line_text.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';


class ActivityRecordPost extends StatefulWidget {
  final DetailActivityRecord? activityRecord;
  final bool? checkRequestUser;
  final bool socialSection;
  const ActivityRecordPost({
    required this.activityRecord,
    this.checkRequestUser,
    this.socialSection = true,
    super.key
  });

  @override
  State<ActivityRecordPost> createState() => _ActivityRecordPostState();
}

class _ActivityRecordPostState extends State<ActivityRecordPost> {
  bool showFullTitle = false;
  bool showFullDescription = false;
  bool showViewMoreDescriptionButton = false;
  bool showViewMoreTitleButton = false;
  int currentSlide = 0;
  Map<String, dynamic> sportTypeIcon = {
    "Running": Icons.directions_run_rounded,
    "Walking": Icons.directions_walk_rounded,
    "Cycling": Icons.directions_bike_rounded,
    "Swimming": Icons.pool_rounded
  };

  @override
  Widget build(BuildContext context) {
    List statsList = [
      {
        "type": "Distance",
        "figure": "${widget.activityRecord?.distance ?? 0} km",
      },
      {
        "type": "Avg. pace",
        "figure": "${widget.activityRecord?.avgMovingPace ?? "00:00"}/km",
      },
      {
        "type": "Time",
        "figure": "${formatTimeDuration(widget.activityRecord?.duration ?? "", type: 3)}",
      }
    ];
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: media.height * 0.01,),
        //User section
        MainWrapper(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user', arguments: {
                    "id": widget.activityRecord?.user?.id,
                  });
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/img/community/ptit_logo.png",
                        width: 45,
                        height: 45,
                      ),
                    ),
                    SizedBox(width: media.width * 0.02,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: media.width * 0.75,
                          child: Text(
                            '${widget.activityRecord?.user?.name ?? ""}',
                            style: TxtStyle.headSection,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              sportTypeIcon['${widget.activityRecord?.sportType ?? "Running"}'],
                              color: TColor.DESCRIPTION,
                              size: 20,
                            ),
                            SizedBox(width: media.width * 0.02,),
                            Text(
                              '${widget.activityRecord?.completedAt ?? ""}',
                              style: TxtStyle.descSection,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              if(widget.checkRequestUser == true)...[
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
              ]
            ],
          ),
        ),
        SizedBox(height: media.height * 0.01,),

        // Caption section
        MainWrapper(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/activity_record_detail', arguments: {
                "id": widget.activityRecord?.id,
                "checkRequestUser": widget.checkRequestUser
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.activityRecord?.title != "")...[
                  LimitLineText(
                    showFullText: showFullTitle,
                    showViewMoreButton: showViewMoreTitleButton,
                    description: '${widget.activityRecord?.title}',
                    onTap: () {
                      setState(() {
                        showFullTitle = (showFullTitle) ? false : true;
                      });
                    },
                    style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.LARGE,
                        fontWeight: FontWeight.w600
                    ),
                    char_in_line: 35,
                  ),
                  SizedBox(height: media.height * 0.01,),
                ],
                if(widget.activityRecord?.description != "")...[
                  LimitLineText(
                    showFullText: showFullDescription,
                    showViewMoreButton: showViewMoreDescriptionButton,
                    description: "${widget.activityRecord?.description}",
                    onTap: () {
                      setState(() {
                        showFullDescription = (showFullDescription) ? false : true;
                      });
                    },
                  ),
                  SizedBox(height: media.height * 0.01,),
                ]
              ],
            ),
          ),
        ),

        // Stats section
        MainWrapper(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/activity_record_detail', arguments: {
                "id": widget.activityRecord?.id,
                "checkRequestUser": widget.checkRequestUser
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < 3; i++) ...[
                  Row(
                    children: [
                      if (i != 0) ...[
                        SeparateBar(
                            width: 2, height: 40),
                        SizedBox(width: media.width * 0.03)
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statsList[i]["type"],
                            style: TextStyle(
                                color: TColor.DESCRIPTION,
                                fontSize: FontSize.SMALL,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            statsList[i]["figure"],
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
        SizedBox(height: media.height * 0.01,),

        // Image section
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/activity_record_detail', arguments: {
                  "id": widget.activityRecord?.id,
                  "checkRequestUser": widget.checkRequestUser
                });
              },
              child: SizedBox(
                height: media.height * 0.27,
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 1
                  ),
                  items: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/img/community/ptit_background.jpg",
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
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


        // Social section
        if(widget.socialSection)...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MainWrapper(
                topMargin: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/feed_comment', arguments: {
                      "id": widget.activityRecord?.id,
                      "checkRequestUser": widget.checkRequestUser,
                    });
                  },
                  child: Text(
                    "0 comment",
                    style: TxtStyle.normalTextDesc,
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.015,),

              Container(
                padding: const EdgeInsets.symmetric(
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
                      (widget.checkRequestUser == true) ? {
                        "icon": Icons.ios_share_rounded,
                        "text": "Share",
                      } : null,
                    ])...[
                      if(x != null)...[
                        CustomTextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/feed_comment', arguments: {
                              "id": widget.activityRecord?.id,
                              "checkRequestUser": widget.checkRequestUser,
                            });
                          },
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
                        // if(x["text"] != "Share") SeparateBar(width: 1, height: 45, color: TColor.BORDER_COLOR,)
                      ]
                    ]
                  ],
                ),
              )
            ],
          )
        ]
      ],
    );
  }
}


