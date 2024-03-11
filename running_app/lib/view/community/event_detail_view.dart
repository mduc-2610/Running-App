import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/athlete_table.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/progress_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView({super.key});

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  bool _showLeaderBoard = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  "assets/img/community/ptit_background.jpg",
                  width: media.width,
                  height: media.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              MainWrapper(
                child: Column(
                  children: [
                    // Header
                    Positioned(
                      top: 0,
                      child: Header(
                        title: "",
                        iconButtons: [
                          {
                            "icon": Icons.more_vert_rounded,
                          }
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.height * 0.07,
                    ),

                    // Event target
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                      decoration: BoxDecoration(
                        color: TColor.PRIMARY,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.flag_circle_rounded,
                                color: TColor.PRIMARY_TEXT,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Target: ",
                                style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: FontSize.SMALL,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "25000.0 km",
                                style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.LARGE,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                          SizedBox(
                            height: media.height * 0.01,
                          ),
                          ProgressBar(
                            totalSteps: 10,
                            currentStep: 8,
                            width: media.width,
                          ),
                          SizedBox(
                            height: media.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "153 days left",
                                style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: FontSize.SMALL,
                                    fontWeight: FontWeight.w500),
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                        text: "208416.86",
                                        style: TextStyle(
                                          color: Color(0xff6cb64f),
                                        ),
                                      ),
                                      TextSpan(text: "/25000.0km")
                                    ]),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var x in ["Information", "Leaderboard"]) ...[
                          SizedBox(
                            width: media.width * 0.46,
                            child: CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  _showLeaderBoard = x == "Leaderboard";
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(0)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color?>(
                                          // x == "Total stats" ? TColor.PRIMARY : null

                                          x == "Information" &&
                                                      _showLeaderBoard == false ||
                                                  x == "Leaderboard" &&
                                                      _showLeaderBoard == true
                                              ? TColor.PRIMARY
                                              : null),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)))),
                              child: Text(x,
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(
                      height: media.height * 0.01,
                    ),
                    _showLeaderBoard == false ? InformationLayout() : AthleteTable()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationLayout extends StatefulWidget {
  const InformationLayout({super.key});

  @override
  State<InformationLayout> createState() => _InformationLayoutState();
}

class _InformationLayoutState extends State<InformationLayout> {
  bool _showPost = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var x in ["General information", "Post"]) ...[
              SizedBox(
                width: media.width * 0.46,
                child: CustomTextButton(
                  onPressed: () {
                    setState(() {
                      _showPost = x == "Post";
                    });
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(0),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          x == "General information" && _showPost == false ||
                                  x == "Post" && _showPost == true
                              ? Colors.transparent
                              : TColor.SECONDARY_BACKGROUND),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      side: MaterialStateProperty.all(
                          x == "General information" && _showPost == false ||
                                  x == "Post" && _showPost == true
                              ? BorderSide(
                                  color: TColor.PRIMARY,
                                  width: 2.0,
                                )
                              : BorderSide.none)),
                  child: Text(x,
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          ],
        ),
        SizedBox(
          height: media.height * 0.015,
        ),
        _showPost == false ? GeneralInformationLayout() : PostLayout(),
      ],
    );
  }
}

class GeneralInformationLayout extends StatelessWidget {
  const GeneralInformationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List eventInfo = [
      {
        "icon": Icons.calendar_today_rounded,
        "type": "Duration",
        "content": "00:00 - 22/02/2024 to 23:59 - 17/03/2024"
      },
      {
        "icon": Icons.directions_run_rounded,
        "type": "Competition",
        "content": "Individual",
      },
      {
        "icon": Icons.shield_outlined,
        "type": "Event mode",
        "content": "Public",
      }
    ];
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event info section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ptit event",
                  style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: media.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: TColor.PRIMARY,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "Challenge",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.SMALL,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          " - 4,577 join",
                          style: TextStyle(
                            color: TColor.DESCRIPTION,
                            fontSize: FontSize.SMALL,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                    CustomIconButton(
                      icon: Icon(
                        Icons.share_outlined,
                        color: TColor.PRIMARY_TEXT,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: media.height * 0.015,
                ),
                Column(
                  children: [
                    for (int i = 0; i < 3; i++) ...[
                      Container(
                        // onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                            bottom:
                                BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                          )),
                          child: Row(
                            children: [
                              Container(
                                // padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(),
                                child: Icon(
                                  eventInfo[i]["icon"],
                                  color: Colors.green,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: media.width * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eventInfo[i]["type"],
                                    style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    eventInfo[i]["content"],
                                    style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                )
              ],
            ),
            SizedBox(
              height: media.height * 0.015,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rules for a valid activity",
                    style: TextStyle(
                      color: TColor.PRIMARY_TEXT,
                      fontSize: FontSize.LARGE,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(height: media.height * 0.015),
                Column(
                  children: [
                    Container(
                      height: media.height * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var x in [
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Minimum distance",
                              "figure": "1km",
                              "border": Border(
                                right: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                                bottom: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                              )
                            },
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Maximum distance",
                              "figure": "100km",
                              "border": Border(
                                left: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                                bottom: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                              )
                            },
                          ]) ...[
                            Container(
                              width: (media.width - media.width * 0.05) / 2,
                              decoration: BoxDecoration(
                                  // color: TColor.SECONDARY_BACKGROUND,
                                  border: x["border"] as Border
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    x["icon"] as IconData,
                                    color: TColor.PRIMARY_TEXT,
                                  ),
                                  SizedBox(height: media.height * 0.01,),
                                  Text(
                                    x["type"] as String,
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
                                      fontSize: FontSize.LARGE,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                    Container(
                      height: media.height * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var x in [
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Minimum distance",
                              "figure": "1km",
                              "border": Border(
                                top: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                                right: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                              )
                            },
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Maximum distance",
                              "figure": "100km",
                              "border": Border(
                                left: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                                top: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                              )
                            },
                          ]) ...[
                            Container(
                              width: (media.width - media.width * 0.05) / 2,
                              decoration: BoxDecoration(
                                  // color: TColor.SECONDARY_BACKGROUND,
                                  border: x["border"] as Border
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    x["icon"] as IconData,
                                    color: TColor.PRIMARY_TEXT,
                                  ),
                                  SizedBox(height: media.height * 0.01,),
                                  Text(
                                    x["type"] as String,
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
                                      fontSize: FontSize.LARGE,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: TColor.DESCRIPTION,
                      fontSize: FontSize.SMALL,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "* ",
                        style: TextStyle(
                          color: Colors.green
                        )
                      ),
                      TextSpan(
                          text: "Recorded as completed and displayed on the runner's Running account within 72 hours from the activity's start time and no later than the last day of the event",
                      )
                    ],
                  )
                )
              ],
            ),
            SizedBox(height: media.height * 0.015,),
            // Description section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Event's description",
                  style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Thử thách số Km tối đa năm 2024 bạn chạy được bao nhiêu",
                  style: TextStyle(
                    color: TColor.DESCRIPTION,
                    fontSize: FontSize.SMALL,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(height: media.height * 0.015,),
            // Contact section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact information",
                  style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Liên hệ Mr: Lê Hữu Tài - 0986663579",
                  style: TextStyle(
                    color: TColor.DESCRIPTION,
                    fontSize: FontSize.SMALL,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PostLayout extends StatelessWidget {
  const PostLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/img/community/post.png",
            width: media.width * 0.4,
            height: media.height * 0.2,
          ),
          Text(
            "There's no blog yet",
            style: TextStyle(
                color: TColor.PRIMARY_TEXT,
                fontSize: FontSize.LARGE,
                fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}

