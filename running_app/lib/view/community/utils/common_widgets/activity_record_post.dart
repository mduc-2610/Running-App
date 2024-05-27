import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post_like.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/button/icon_button.dart';
import 'package:running_app/utils/common_widgets/layout/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_notification.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_user_list.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';


class ActivityRecordPost extends StatefulWidget {
  final String token;
  final DetailActivityRecord activityRecord;
  final bool? checkRequestUser;
  final bool socialSection;
  final bool detail;
  final bool like;
  final VoidCallback likeOnPressed;
  final VoidCallback? detailOnPressed;
  final VoidCallback? reload;

  ActivityRecordPost({
    required this.token,
    required this.activityRecord,
    required this.like,
    required this.likeOnPressed,
    this.detailOnPressed,
    this.checkRequestUser,
    this.socialSection = true,
    this.detail = false,
    this.reload,
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
  Map<String, dynamic> popArguments = {};

  @override
  Widget build(BuildContext context) {
    bool like = widget.like;
    List statsList = [
      {
        "type": "Distance",
        "figure": "${widget.activityRecord.distance ?? 0} km",
      },
      {
        "type": "Avg. pace",
        "figure": "${widget.activityRecord.avgMovingPace ?? "00:00"}/km",
      },
      {
        "type": "Time",
        "figure": "${formatTimeDuration(widget.activityRecord.duration ?? "", type: 3)}",
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
                    "id": widget.activityRecord.user?.id,
                  });
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.activityRecord.user?.avatar ?? "",
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
                            '${widget.activityRecord.user?.name ?? ""}',
                            style: TxtStyle.headSection,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              ActIcon.sportTypeIcon['${widget.activityRecord.sportType ?? "Running"}'],
                              color: TColor.DESCRIPTION,
                              size: 20,
                            ),
                            SizedBox(width: media.width * 0.02,),
                            Text(
                              '${widget.activityRecord.completedAt ?? ""}',
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
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/activity_record_edit', arguments: {
                                "id": widget.activityRecord.id
                              });
                            }
                          },
                          {
                            "text": "Delete Activity",
                            "textColor": Colors.red,
                            "onPressed": () async {
                              showNotificationDecision(context, 'Notice', "Are you sure to delete this activity", "No", "Yes", onPressed2: () async {
                                await callDestroyAPI(
                                    'activity/activity-record',
                                    widget.activityRecord.id,
                                    widget.token
                                );
                                widget.reload?.call();
                                Navigator.pop(context);
                              });
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
          topMargin: 0,
          child: GestureDetector(
            onTap: (widget.detail == false) ? () {
              widget.detailOnPressed?.call();
            } : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.activityRecord.title != "")...[
                  LimitTextLine(
                    showFullText: showFullTitle,
                    showViewMoreButton: showViewMoreTitleButton,
                    description: '${widget.activityRecord.title}',
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
                    charInLine: 35,
                  ),
                  SizedBox(height: media.height * 0.01,),
                ],
                if(widget.activityRecord.description != "")...[
                  LimitTextLine(
                    showFullText: showFullDescription,
                    showViewMoreButton: showViewMoreDescriptionButton,
                    description: "${widget.activityRecord.description}",
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
          topMargin: 0,
          child: CustomTextButton(
            onPressed: () {
              widget.detailOnPressed?.call();
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
              onTap: (widget.detail == false) ? () {
                widget.detailOnPressed?.call();
              } : null,
              child: SizedBox(
                height: media.height * 0.27,
                child: CarouselSlider(
                  options: CarouselOptions(
                      // autoPlay: true,
                      // autoPlayInterval: const Duration(seconds: 3),
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

        // Social section
        if(widget.socialSection)...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if(widget.detail == false)...[
                MainWrapper(
                  // topMargin: 0,
                  child: Container(
                    width: media.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showUserList(
                              context,
                              widget.activityRecord.likes ?? [] ,
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: TColor.THIRD,
                                  ),
                                  // SizedBox(width: media.width * 0.01,),
                                  if(like == true)...[
                                    Text(
                                      "${widget.activityRecord.totalLikes}",
                                      style: TxtStyle.normalTextDesc,
                                    ),
                                  ]
                                  else...[
                                    Text(
                                      "${widget.activityRecord.totalLikes}",
                                      style: TxtStyle.normalTextDesc,
                                    )
                                  ]
                                ],
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: TColor.THIRD,
                              ),
                              // SizedBox(width: media.width * 0.01,),
                              Text(
                                " ${widget.activityRecord.totalLikes}",
                                style: TxtStyle.normalTextDesc,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Map<String, dynamic> x = await Navigator.pushNamed(context, '/feed_comment', arguments: {
                              "id": widget.activityRecord.id,
                              "checkRequestUser": widget.checkRequestUser,
                            }) as Map<String, dynamic>;
                            setState(() {
                              popArguments = x;
                              widget.activityRecord.totalComments = popArguments["totalComments"];
                            });
                          },
                          child: Text(
                            "${widget.activityRecord.totalComments} comment",
                            style: TxtStyle.normalTextDesc,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: media.height * 0.015,),

              if(widget.detail == false)...[
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
                          "icon": (like)
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          "text": "Like",
                          "onPressed": widget.likeOnPressed
                        },
                        {
                          "icon": Icons.mode_comment_outlined,
                          "text": "Comment",
                          "onPressed": () async {
                            if(widget.detail == false) {
                              Map<String, dynamic> x = await Navigator.pushNamed(context, '/feed_comment', arguments: {
                                "id": widget.activityRecord.id,
                                "checkRequestUser": widget.checkRequestUser,
                              }) as Map<String, dynamic>;
                              setState(() {
                                popArguments = x;
                                widget.activityRecord.totalComments = popArguments["totalComments"];
                              });
                            }
                          }
                        },
                        (widget.checkRequestUser == true) ? {
                          "icon": Icons.ios_share_rounded,
                          "text": "Share",
                          "onPressed": () {}
                        } : null,
                      ])...[
                        if(x != null)...[
                          CustomTextButton(
                            onPressed: x["onPressed"] as VoidCallback,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    x["icon"] as IconData,
                                    color: (like && x["text"] == "Like")
                                        ? TColor.THIRD
                                        : TColor.PRIMARY_TEXT,
                                  ),
                                  SizedBox(width: media.width * 0.02,),
                                  Text(
                                    x["text"] as String,
                                    style: TextStyle(
                                      color: (like && x["text"] == "Like")
                                          ? TColor.THIRD
                                          : TColor.PRIMARY_TEXT,
                                      fontSize: FontSize. NORMAL,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // if(x["text"] != "Share") SeparateBar(width: 1, height: 45, color: TColor.BORDER_COLOR,)
                        ]
                      ]
                    ],
                  ),
                ),
              ]

              // if(widget.detail == true)...[
              //   MainWrapper(
              //     topMargin: 0,
              //     child: CustomTextButton(
              //       style: ButtonStyle(
              //           padding: MaterialStateProperty.all(EdgeInsets.all(0))
              //       ),
              //       onPressed: (widget.detail == false) ? () {
              //         Navigator.pushNamed(context, '/activity_record_detail', arguments: {
              //           "id": widget.activityRecord.id,
              //           "checkRequestUser": widget.checkRequestUser,
              //         });
              //       } : null,
              //       child: Container(
              //         width: media.width,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             GestureDetector(
              //               onTap: () {
              //                 showUserList(
              //                   context,
              //                   widget.activityRecord.likes ?? [] ,
              //                   title: Row(
              //                     children: [
              //                       Icon(
              //                         Icons.thumb_up,
              //                         color: TColor.THIRD,
              //                       ),
              //                       SizedBox(width: media.width * 0.01,),
              //                       if(like == true)...[
              //                         Text(
              //                           "${widget.activityRecord.totalLikes}",
              //                           style: TxtStyle.normalTextDesc,
              //                         ),
              //                       ]
              //                       else...[
              //                         Text(
              //                           "${widget.activityRecord.totalLikes}",
              //                           style: TxtStyle.normalTextDesc,
              //                         )
              //                       ]
              //                     ],
              //                   ),
              //                 );
              //               },
              //               child: Row(
              //                 children: [
              //                   Icon(
              //                     Icons.thumb_up,
              //                     color: TColor.THIRD,
              //                   ),
              //                   SizedBox(width: media.width * 0.01,),
              //                   if(like == true)...[
              //                     Text(
              //                       "${widget.activityRecord.totalLikes}",
              //                       style: TxtStyle.normalTextDesc,
              //                     ),
              //                   ]
              //                   else...[
              //                     Text(
              //                       "${widget.activityRecord.totalLikes}",
              //                       style: TxtStyle.normalTextDesc,
              //                     )
              //                   ]
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ]
            ],
          )
        ]
      ],
    );
  }
}


