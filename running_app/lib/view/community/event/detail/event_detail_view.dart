import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/athlete_table.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/progress_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/scroll_synchronized.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_leaderboard.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView({super.key});

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  bool isLoading = true;
  bool isLoadingLeaderboard = false;
  String _showLayout = "Information";
  String token = "";
  String eventId = "";
  DetailEvent? event;
  int currentSlide = 0;
  DetailUser? user;
  Activity? userActivity;
  bool showMilestone = false;
  bool showChooseGroup = false;
  bool userInEvent = false;
  String sort_by = "Distance";

  void getData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
      eventId = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?)?["id"];
      userInEvent = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?)?["userInEvent"];
    });
  }

  Future<void> initDetailEvent() async {
    final data = await callRetrieveAPI(
        'activity/event',
        eventId,
        null,
        DetailEvent.fromJson,
        token,
        queryParams: "?limit_user=20&"
            "sort_by=${sort_by}"
    );
    setState(() {
      event = data;
    });
  }

  Future<void> initUserActivity() async {
    final data = await callRetrieveAPI(
        null,
        null,
        user?.activity,
        Activity.fromJson,
        token
    );
    setState(() {
      userActivity = data;
    });
  }

  void delayedInit() async {
    await initUserActivity();
    await initDetailEvent();
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  void delayedDetailEvent() async {
    setState(() {
      isLoadingLeaderboard = true;
    });
    await initDetailEvent();
    await Future.delayed(Duration(milliseconds: 800));
    setState(() {
      isLoadingLeaderboard = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    ScrollController parentScrollController = ScrollController();
    return Scaffold(
      body: SingleChildScrollView(
        controller: parentScrollController,
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              if(isLoading == false)...[
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    "assets/img/community/ptit_background.jpg",
                    width: media.width,
                    height: media.height * 0.26,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: media.height * 0.05,),
                    // Header
                    Header(
                      title: "",
                      iconButtons: [
                        {
                          "icon": Icons.more_vert_rounded,
                          "onPressed": () {
                            showActionList(
                                context,
                                [
                                  {
                                    "text": "Edit event",
                                    "onPressed": () {
                                      // Navigator.pushNamed(
                                      //     context,
                                      //     '/'
                                      // );
                                    }
                                  },
                                  {
                                    "text": "Delete event",
                                    "onPressed": () {

                                    },
                                    "textColor": TColor.WARNING
                                  }
                                ],
                                "Options"
                            );
                          },
                        }
                      ],
                    ),
                    SizedBox(
                      height: media.height * 0.07,
                    ),

                    // Event target section
                    MainWrapper(
                      child: Column(
                        children: [
                          if(userInEvent || showMilestone)...[
                            SizedBox(
                              height: media.height * 0.16,
                              width: media.width,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 100),
                                  initialPage: 0,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentSlide = index;
                                    });
                                  },
                                ),
                      
                                items: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      // right: media.width * 0.03
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
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
                                              color: Color(0xfff3af3d),
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
                                          currentStep: 0,
                                          width: media.width,
                                        ),
                                        SizedBox(
                                          height: media.height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${event?.daysRemain ?? "0"} days left',
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
                                                      text: "0",
                                                      style: TextStyle(
                                                        color: TColor.ACCEPTED,
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
                                  Container(
                                    margin: EdgeInsets.only(left: media.width * 0.03),
                                    decoration: BoxDecoration(
                                      color: TColor.PRIMARY,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                bottomRight: Radius.circular(12),
                                                topLeft: Radius.circular(200),
                                              ),
                                              child: Image.asset(
                                                "assets/img/community/keep_running.jpg",
                                                // width: media.width,
                                                height: media.height * 0.16,
                                                width: media.width * 0.46,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Total event distance:",
                                                  style: TextStyle(
                                                      color: TColor.PRIMARY_TEXT,
                                                      fontSize: FontSize.NORMAL,
                                                      fontWeight: FontWeight.w600
                                                  )
                                              ),
                                              const Text(
                                                  "197,390 km",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: FontSize.TITLE,
                                                    fontWeight: FontWeight.w900,
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: media.width * 0.03),
                                    decoration: BoxDecoration(
                                      color: TColor.PRIMARY,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: media.height * 0.16,
                                              width: media.width * 0.48,
                                              decoration: BoxDecoration(
                                                color: TColor.PRIMARY_TEXT,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight: Radius.circular(12),
                                                  topLeft: Radius.circular(100),
                                                  // bottomLeft: Radius.circular(10),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                child: SvgPicture.asset(
                                                  "assets/img/community/donation.svg",
                                                  // width: media.width,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Donation amount:",
                                                  style: TextStyle(
                                                      color: TColor.PRIMARY_TEXT,
                                                      fontSize: FontSize.NORMAL,
                                                      fontWeight: FontWeight.w600
                                                  )
                                              ),
                                              const Text(
                                                  "3,125 USD",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: FontSize.TITLE,
                                                    fontWeight: FontWeight.w900,
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: media.height * 0.01,),
                            DotsIndicator(
                              dotsCount: 3,
                              position: currentSlide,
                              decorator: DotsDecorator(
                                activeColor: TColor.PRIMARY,
                                spacing: const EdgeInsets.only(left: 8),
                              ),
                            )
                          ]
                          else...[
                            if(event?.competition == "Group" && showChooseGroup)...[
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: TColor.PRIMARY,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for(var x in [
                                      {
                                        "icon": Icons.flag_circle_rounded,
                                        "text1": "Target: ",
                                        "text2": "25000.0 km",
                                        "iconColor": Color(0xfff3af3d)
                                      },
                                      {
                                        "icon": Icons.people_alt,
                                        "text1": "Competition: ",
                                        "text2": "${event?.competition}",
                                        "iconColor": TColor.ACCEPTED
                                      }
                                    ])...[
                      
                                      Row(
                                        children: [
                                          Icon(
                                            x["icon"] as IconData,
                                            color: x["iconColor"] as Color,
                                          ),
                                          SizedBox(width: media.width * 0.02 ,),
                                          Text(
                                            x["text1"] as String,
                                            style: TextStyle(
                                                color: TColor.DESCRIPTION,
                                                fontSize: FontSize.SMALL,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            x["text2"] as String,
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
                                    ],
                                    SizedBox(
                                      width: media.width,
                                      child: CustomMainButton(
                                        background: TColor.WARNING,
                                        horizontalPadding: 0,
                                        verticalPadding: 14,
                                        onPressed: () {
                                          setState(() {
                                            showMilestone = true;
                                          });
                                        },
                                        child: Text(
                                          "Choose group",
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.SMALL,
                                              fontWeight: FontWeight.w900
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.height * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info_rounded,
                                          color: TColor.PRIMARY_TEXT,
                                        ),
                                        SizedBox(width: media.width * 0.02,),
                                        Text(
                                          'Choosing a group to participate this event',
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.SMALL,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]
                            else...[
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: TColor.PRIMARY,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for(var x in [
                                      {
                                        "icon": Icons.flag_circle_rounded,
                                        "text1": "Target: ",
                                        "text2": "25000.0 km",
                                        "iconColor": Color(0xfff3af3d)
                                      },
                                      {
                                        "icon": Icons.people_alt,
                                        "text1": "Competition: ",
                                        "text2": "${event?.competition}",
                                        "iconColor": TColor.ACCEPTED
                                      }
                                    ])...[
                      
                                      Row(
                                        children: [
                                          Icon(
                                            x["icon"] as IconData,
                                            color: x["iconColor"] as Color,
                                          ),
                                          SizedBox(width: media.width * 0.02 ,),
                                          Text(
                                            x["text1"] as String,
                                            style: TextStyle(
                                                color: TColor.DESCRIPTION,
                                                fontSize: FontSize.SMALL,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            x["text2"] as String,
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
                                    ],
                                    SizedBox(
                                      width: media.width,
                                      child: CustomMainButton(
                                        background: TColor.ACCEPTED,
                                        horizontalPadding: 0,
                                        verticalPadding: 14,
                                        onPressed: () {
                                          setState(() {
                                            if(event?.competition  == "Group") {
                                              showChooseGroup = true;
                                            } else {
                                              showMilestone = true;
                                            }
                                          });
                                        },
                                        child: Text(
                                          "Join now",
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.SMALL,
                                              fontWeight: FontWeight.w900
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ]
                        ],
                      ),
                    ),

                    SizedBox(height: media.height * 0.01,),
                    MainWrapper(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var x in ["Information", "Leaderboard"]) ...[
                            SizedBox(
                              width: media.width * 0.46,
                              child: CustomTextButton(
                                onPressed: () {
                                  setState(() {
                                    _showLayout = x;
                                  });
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.all(0)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color?>(
                                          _showLayout == x ? TColor.PRIMARY : null
                                        ),
                                    side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(width: 2, color: TColor.PRIMARY)
                                    ),
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
                    ),
                    // SizedBox(height: media.height * 0.01,),
                    _showLayout == "Information"
                        ? MainWrapper(
                      child: InformationLayout(event: event,),
                    )
                        : (event?.participants?.length == 0)
                        ? EmptyListNotification(
                            title: (event?.competition == "Group") ? "No groups created yet!" : "No users joined yet!",
                            description: (event?.competition == "Group")
                                ? "Please create a new group for joining the group ranking right away"
                                : "Invite your friend for joining the event ranking right away",
                            addButton: (event?.competition == "Group") ? true : false,
                            addButtonText: "Create a group",
                            onPressed: () {
                              Navigator.pushNamed(context, '/group_create');
                            },
                        )
                    : LeaderBoardLayout(
                      event: event,
                      parentScrollController: parentScrollController,
                      distanceOnPressed: () {
                        setState(() {
                          sort_by = "Distance";
                          print(sort_by);
                        });
                        delayedDetailEvent();
                      },
                      timeOnPressed: () {
                        setState(() {
                          sort_by = "Time";
                          print(sort_by);
                        });
                        delayedDetailEvent();
                      },
                      isLoading: isLoadingLeaderboard,
                    )
                  ],
                ),
              ] else...[
                Loading(
                  marginTop: media.height * 0.5,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class InformationLayout extends StatefulWidget {
  final DetailEvent? event;
  const InformationLayout({
    this.event,
    super.key
  });

  @override
  State<InformationLayout> createState() => _InformationLayoutState();
}

class _InformationLayoutState extends State<InformationLayout> {
  String _showLayout = "General information";

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
                      _showLayout = x;
                    });
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(0),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          _showLayout == x ? Colors.transparent : TColor.SECONDARY_BACKGROUND
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      side: MaterialStateProperty.all(
                          _showLayout == x
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
        _showLayout == "General information"
            ? GeneralInformationLayout(event: widget.event,)
            : const PostLayout(),
      ],
    );
  }
}

class LeaderBoardLayout extends StatefulWidget {
  final ScrollController parentScrollController;
  final DetailEvent? event;
  final VoidCallback distanceOnPressed;
  final VoidCallback timeOnPressed;
  final bool isLoading;

  const LeaderBoardLayout({
    required this.parentScrollController,
    required this.event,
    required this.distanceOnPressed,
    required this.timeOnPressed,
    required this. isLoading,
    super.key
  });

  @override
  State<LeaderBoardLayout> createState() => _LeaderBoardLayoutState();
}

class _LeaderBoardLayoutState extends State<LeaderBoardLayout> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    ScrollController childScrollController = ScrollController();

    return ScrollSynchronized(
      parentScrollController: widget.parentScrollController,
      child: Column(
        children: [
          MainWrapper(
            topMargin: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Weekly statistics",
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.NORMAL,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/rank', arguments: {
                        "rankType": "Event",
                        "id": widget.event?.id,
                      });
                    },
                    child: Text(
                        "View more",
                        style: TextStyle(
                          color: TColor.PRIMARY,
                          fontSize: FontSize.NORMAL,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                  )
                ]
            ),
          ),
          EventLeaderboard(
            event: widget.event,
            participants: widget.event?.participants ?? [],
            groups: widget.event?.groups ?? [],
            tableHeight: media.height - media.height * 0.19,
            controller: childScrollController,
            secondColumnName: (widget.event?.competition == "Individual") ? "Athlete name" : "Group name",
            distanceOnPressed: widget.distanceOnPressed,
            timeOnPressed: widget.timeOnPressed,
            isLoading: widget.isLoading,
          )
        ],
      ),
    );
  }
}


class GeneralInformationLayout extends StatelessWidget {
  final DetailEvent? event;
  const GeneralInformationLayout({
    this.event,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List eventInfo = [
      {
        "icon": Icons.calendar_today_rounded,
        "type": "Duration",
        "content": "${formatDateTimeEnUS(DateTime.parse(event?.startedAt ?? ""), shortcut: true)} 00:00 "
            "to ${formatDateTimeEnUS(DateTime.parse(event?.endedAt ?? ""), shortcut: true)} 23:59"
      },
      {
        "icon": Icons.directions_run_rounded,
        "type": "Competition",
        "content": "${event?.competition}",
      },
      {
        "icon": Icons.shield_outlined,
        "type": "Event mode",
        "content": "${event?.privacy}",
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
                  event?.name ?? "",
                  style: TxtStyle.headSection
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
                          padding: const EdgeInsets.all(5),
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
                          "  •  ${event?.numberOfParticipants ?? 0} join",
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
                          padding: const EdgeInsets.symmetric(
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
                                decoration: const BoxDecoration(),
                                child: Icon(
                                  eventInfo[i]["icon"],
                                  color: TColor.PRIMARY_TEXT,
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
                ),
                SizedBox(height: media.height * 0.015,),
                SizedBox(
                  width: media.width,
                  child: CustomMainButton(
                    horizontalPadding: 0,
                    verticalPadding: 14,
                    onPressed: () {
                      showActionList(
                          context,
                        [
                          {
                            "text": "Event member management",
                            "onPressed": () {
                              Navigator.pushNamed(
                                context,
                                '${event?.privacy == "Private"
                                    ? '/member_management_private'
                                    : '/member_management_public'
                                }',
                                arguments: {
                                  "participants": event?.participants ?? []
                                }
                              );
                            }
                          },
                          (event?.competition == "Group") ? {
                            "text": "Event group management",
                            "onPressed": () {
                              Navigator.pushNamed(context, '/group_management');
                            }
                          } : null,
                          {
                            "text": "Delete event",
                            "onPressed": () {

                            },
                            "textColor": TColor.WARNING
                          }
                        ],
                        "Admin privileges"
                      );
                    },
                    prefixIcon: Icon(
                        Icons.shield_outlined,
                        color: TColor.PRIMARY_TEXT,
                    ),
                    borderWidth: 2,
                    borderWidthColor: TColor.PRIMARY,
                    background: Colors.transparent,

                    child: Text(
                      "Event management",
                      style: TxtStyle.headSection,
                    ),                  )
                )
              ],
            ),
            SizedBox(height: media.height * 0.02,),

            if(event?.competition == "Group")...[
              Column(
                children: [
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/group_list', arguments: {
                        "groups": event?.groups ?? [],
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Challenge's group",
                          style: TxtStyle.headSection,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: TColor.PRIMARY_TEXT,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: media.height * 0.02,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(var group in event?.groups ?? [])...[
                          CustomTextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/event_group_detail', arguments: {
                                "id": group?.id,
                                "rank": event?.groups?.indexOf(group),
                              });
                            },
                            child: Container(
                              height: media.height * 0.21,
                              width: media.width * 0.3,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 15
                              ),
                              decoration: BoxDecoration(
                                  color: TColor.SECONDARY_BACKGROUND,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1,
                                      color: TColor.BORDER_COLOR
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          'assets/img/community/ptit_logo.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: media.height * 0.01,),
                                      Text(
                                        '${group?.name ?? ""}',
                                        style: TxtStyle.normalText,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${group?.numberOfParticipants}",
                                        style: TxtStyle.normalText,
                                      ),
                                      Text(
                                        " join",
                                        style: TxtStyle.descSectionNormal,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: media.width * 0.02,),
                        ]
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: media.height * 0.03,),
            ],

            // Rules section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rules for a valid activity",
                    style: TxtStyle.headSection
                ),
                SizedBox(height: media.height * 0.015),
                Column(
                  children: [
                    SizedBox(
                      height: media.height * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var x in [
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Minimum distance",
                              "figure": "${event?.regulations?["min_distance"]}",
                              "border": Border(
                                right: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                                bottom: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                              )
                            },
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Maximum distance",
                              "figure": "${event?.regulations?["max_distance"]}",
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
                    SizedBox(
                      height: media.height * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var x in [
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Slowest Avg Pace",
                              "figure": "${event?.regulations?["min_avg_pace"]}",
                              "border": Border(
                                top: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                                right: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                              )
                            },
                            {
                              "icon": Icons.directions_run_rounded,
                              "type": "Fastest Avg Pace",
                              "figure": "${event?.regulations?["max_avg_pace"]}",
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
                const SizedBox(height: 5,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: TColor.DESCRIPTION,
                      fontSize: FontSize.SMALL,
                      fontWeight: FontWeight.w500,
                    ),
                    children: const [
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
            SizedBox(height: media.height * 0.02,),

            // Description section
            if(event?.description != null)...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Event's description",
                    style: TxtStyle.headSection
                  ),
                  Text(
                    event?.description ?? "",
                    style: TextStyle(
                      color: TColor.DESCRIPTION,
                      fontSize: FontSize.SMALL,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: media.height * 0.02,),
            ],
            // Contact section
            if(event?.contactInformation != null)...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact information",
                    style: TxtStyle.headSection
                  ),
                  Text(
                    event?.contactInformation ?? "",
                    style: TextStyle(
                      color: TColor.DESCRIPTION,
                      fontSize: FontSize.SMALL,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: media.height * 0.02,),

            ]
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

