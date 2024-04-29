import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_notification.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class ActivityRecordDetailView extends StatefulWidget {
  const ActivityRecordDetailView({super.key});

  @override
  State<ActivityRecordDetailView> createState() => _ActivityRecordDetailViewState();
}

class _ActivityRecordDetailViewState extends State<ActivityRecordDetailView> {
  int currentSlide = 0;
  bool isLoading = true;
  String token = "";
  String? activityRecordId;
  DetailActivityRecord? activityRecord;
  bool showFullTitle = false;
  bool showFullDescription = false;
  bool showViewMoreDescriptionButton = false;
  bool showViewMoreTitleButton = false;
  bool checkRequestUser = false;

  void getSideData() {
    setState(() {
      Map<String, dynamic> arguments = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
      token = Provider.of<TokenProvider>(context).token;
      activityRecordId = arguments["id"];
      checkRequestUser = arguments["checkRequestUser"] ?? true;
    });
  }

  Future<void> initActivityRecord() async {
    final data = await callRetrieveAPI(
        'activity/activity-record',
        activityRecordId,
        null,
        DetailActivityRecord.fromJson,
        token);

    setState(() {
      activityRecord = data;
    });
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  Future<void> delayedInit() async {
    await initActivityRecord();
    await Future.delayed(Duration(milliseconds: 500),);

    setState(() {
      isLoading = false;
    });
  }

  Map<String, dynamic> sportTypeIcon = {
    "Running": Icons.directions_run_rounded,
    "Walking": Icons.directions_walk_rounded,
    "Cycling": Icons.directions_bike_rounded,
    "Swimming": Icons.pool_rounded
  };

  @override
  void didChangeDependencies() {
    getSideData();
    delayedInit();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Activity", noIcon: true),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          child: DefaultBackgroundLayout(
            child: Stack(
              children: [
                if(isLoading == false)...[
                  Column(
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
                                  "id": activityRecord?.user?.id,
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
                                          '${activityRecord?.user?.name ?? ""}',
                                          style: TxtStyle.headSection,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            sportTypeIcon['${activityRecord?.sportType ?? "Running"}'],
                                            color: TColor.DESCRIPTION,
                                            size: 20,
                                          ),
                                          SizedBox(width: media.width * 0.02,),
                                          Text(
                                            '${activityRecord?.completedAt ?? ""}',
                                            style: TxtStyle.descSection,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if(checkRequestUser)...[
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
                                              "id": activityRecordId
                                            });
                                          }
                                        },
                                        {
                                          "text": "Delete Activity",
                                          "textColor": Colors.red,
                                          "onPressed": () async {
                                            Navigator.pop(context);
                                            showNotificationDecision(context, 'Notice', "Are you sure to delete this activity", "No", "Yes", onPressed2: () async {
                                              await callDestroyAPI(
                                                  'activity/activity-record',
                                                  activityRecord?.id,
                                                  token
                                              );
                                              Navigator.pop(context);
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(activityRecord?.title != "")...[
                              LimitTextLine(
                                showFullText: showFullTitle,
                                showViewMoreButton: showViewMoreTitleButton,
                                description: '${activityRecord?.title}',
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
                            if(activityRecord?.description != "")...[
                              LimitTextLine(
                                showFullText: showFullDescription,
                                showViewMoreButton: showViewMoreDescriptionButton,
                                description: "${activityRecord?.description}",
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
                      MainWrapper(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10
                              ),
                              width: media.width,
                              decoration: BoxDecoration(
                                  color: TColor.SECONDARY_BACKGROUND,
                                  borderRadius: const BorderRadius.only(
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
                                    '${activityRecord?.distance} km',
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
                                            "figure": '${activityRecord?.duration}',
                                          },
                                          {
                                            "type": "Avg. Moving Pace",
                                            "figure": "${activityRecord?.avgMovingPace}/km",
                                          },
                                        ]) ...[
                                          SizedBox(
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
                                            "figure": '${activityRecord?.duration}',
                                          },
                                          {
                                            "type": "Avg. Elapsed Pace",
                                            "figure": "${activityRecord?.avgMovingPace}/km",
                                          },
                                        ]) ...[
                                          SizedBox(
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
                                  borderRadius: const BorderRadius.only(
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
                                      "figure": "___"
                                    },
                                    {
                                      "stats": "Calories",
                                      "figure": "${activityRecord?.kcal}"
                                    },
                                    {
                                      "stats": "Avg. Cadence",
                                      "figure": "___"
                                    },
                                  ])...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
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
                      ),

                      // // Social section
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     MainWrapper(
                      //       topMargin: 0,
                      //       child: CustomTextButton(
                      //         onPressed: () {
                      //           Navigator.pushNamed(context, '/feed_comment', arguments: {
                      //             "id": activityRecord?.id,
                      //             "checkRequestUser": checkRequestUser,
                      //           });
                      //         },
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 Icon(
                      //                   Icons.thumb_up,
                      //                   color: TColor.THIRD,
                      //                 ),
                      //                 SizedBox(width: media.width * 0.01,),
                      //                 Text(
                      //                   "${activityRecord?.totalLikes}",
                      //                   style: TxtStyle.normalTextDesc,
                      //                 ),
                      //               ],
                      //             ),
                      //             Text(
                      //               "${activityRecord?.totalComments} comment",
                      //               style: TxtStyle.normalTextDesc,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 0
                      //       ),
                      //       decoration: BoxDecoration(
                      //           border: Border(
                      //               top: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                      //               bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                      //           )
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment:  MainAxisAlignment.spaceAround,
                      //         children: [
                      //           for(var x in [
                      //             {
                      //               "icon": Icons.thumb_up_alt_outlined,
                      //               "text": "Like",
                      //               "onPressed": () {}
                      //             },
                      //             {
                      //               "icon": Icons.mode_comment_outlined,
                      //               "text": "Comment",
                      //               "onPressed": () {
                      //                 Navigator.pushNamed(context, '/feed_comment', arguments: {
                      //                   "id": activityRecord?.id,
                      //                   "checkRequestUser": checkRequestUser,
                      //                 });
                      //               }
                      //             },
                      //             (checkRequestUser == true) ? {
                      //               "icon": Icons.ios_share_rounded,
                      //               "text": "Share",
                      //               "onPressed": () {}
                      //             } : null,
                      //           ])...[
                      //             if(x != null)...[
                      //               CustomTextButton(
                      //                 onPressed: x["onPressed"] as VoidCallback,
                      //                 child: Row(
                      //                   children: [
                      //                     Icon(
                      //                       x["icon"] as IconData,
                      //                       color: TColor.PRIMARY_TEXT,
                      //                     ),
                      //                     SizedBox(width: media.width * 0.02,),
                      //                     Text(
                      //                       x["text"] as String,
                      //                       style: TxtStyle.normalText,
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //               // if(x["text"] != "Share") SeparateBar(width: 1, height: 45, color: TColor.BORDER_COLOR,)
                      //             ]
                      //           ]
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(height: media.height * 0.02,),

                      // View Analysis
                      CustomTextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
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
                      ),
                      SizedBox(height: media.height * 0.02,),
                    ],
                  )
                ]
                else...[
                  Loading()
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
