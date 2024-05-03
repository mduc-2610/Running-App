
import 'package:flutter/material.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/services/api_service.dart';
import 'package:provider/provider.dart';

import 'package:running_app/utils/common_widgets/athlete_table.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/scroll_synchronized.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class ClubDetailView extends StatefulWidget {
  const ClubDetailView({super.key});

  @override
  State<ClubDetailView> createState() => _ClubDetailViewState();
}

class _ClubDetailViewState extends State<ClubDetailView> {
  bool isLoading = true;
  DetailClub? club;
  String clubId = "";
  String token = "";
  bool? joinButtonState = false;
  Map<String, dynamic> popArguments = {};

  void getSideData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      clubId = arguments?["id"] as String;
    });
  }

  Future<void>initClub() async {
    final data = await callRetrieveAPI(
        'activity/club',
        clubId,
        null,
        DetailClub.fromJson,
        token,
        queryParams: "?limit_user=20&"
            "exclude=posts"
    );
    setState(() {
      club = data;
    });
  }

  Future<void> delayedInit({bool reload = false}) async {
    if(reload) {
      setState(() {
        isLoading = false;
      });
    }
    await initClub();
    await Future.delayed(Duration(seconds: 1),);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  @override
  void didChangeDependencies() {
    getSideData();
    delayedInit();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    ScrollController childScrollController = ScrollController();
    ScrollController parentScrollController = ScrollController();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
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
                        height: media.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: media.height * 0.05,),
                        Header(title: "", iconButtons: [
                          {
                            "icon": Icons.more_vert_rounded,
                          }
                        ],),
                        SizedBox(height: media.height * 0.05,),
                        // Main section
                        MainWrapper(
                          child: Container(
                            child: Column(
                              children: [
                                // Head section
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        "assets/img/community/ptit_logo.png",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: media.width * 0.3,
                                          child: CustomTextButton(
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color?>(
                                                    (joinButtonState!) ? Colors.transparent : TColor.PRIMARY
                                                ),
                                                side: MaterialStateProperty.all(
                                                  BorderSide(width: 2, color: TColor.PRIMARY)
                                                ),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12)
                                                    )
                                                )
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                joinButtonState = (joinButtonState!) ? false : true;
                                              });
                                            },
                                            child: Text(
                                              "${(joinButtonState!) ? "Joined" : "Join"}",
                                              style: TextStyle(
                                                  color: TColor.PRIMARY_TEXT,
                                                  fontSize: FontSize.LARGE,
                                                  fontWeight: FontWeight.w800
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: media.width * 0.015,),
                                        SizedBox(
                                          width: 50,
                                          child: CustomTextButton(
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color?>(
                                                      TColor.PRIMARY
                                                  ),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12)
                                                      )
                                                  )
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(context, '/club_detail_information', arguments: {
                                                  "club": club as DetailClub,
                                                  "joinButtonState": joinButtonState,
                                                });
                                              },
                                              child: Icon(
                                                Icons.info_outline_rounded,
                                                color: TColor.PRIMARY_TEXT,
                                              )
                                          ),
                                        ),
                                        SizedBox(width: media.width * 0.015,),
                                        SizedBox(
                                          width: 50,
                                          child: CustomTextButton(
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color?>(
                                                      TColor.PRIMARY
                                                  ),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12)
                                                      )
                                                  )
                                              ),
                                              onPressed: () {},
                                              child: Icon(
                                                Icons.share_outlined,
                                                color: TColor.PRIMARY_TEXT,
                                              )
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: media.height * 0.02,),
                                // Info section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      club?.name ?? "",
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        for(var x in [
                                          {
                                            "icon": Icons.directions_run_rounded,
                                            "text": club?.sportType ?? "",
                                          },
                                          {
                                            "icon": Icons.people_alt_outlined,
                                            "text": "${club?.numberOfParticipants ?? 0} Join",
                                          },
                                          {
                                            "icon": Icons.public_rounded,
                                            "text": club?.privacy ?? "",
                                          }
                                        ])...[
                                          Row(
                                            children: [
                                              Icon(
                                                  x["icon"] as IconData,
                                                  color: TColor.DESCRIPTION
                                              ),
                                              SizedBox(width: media.width * 0.01,),
                                              Text(
                                                '${x["text"] as String} ${x["icon"] != Icons.public_rounded ? " •  " : ""}',
                                                style: TextStyle(
                                                    color: TColor.DESCRIPTION,
                                                    fontSize: FontSize.SMALL
                                                ),
                                              ),
                                              // SizedBox(width: media.width * 0.03,)
                                            ],
                                          ),
                                        ]
                                      ],
                                    ),
                                    SizedBox(height: media.height * 0.015,),
                                    // Activity stats
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: CustomTextButton(
                                            onPressed: () {

                                            },
                                            child: Stack(
                                              children: [
                                                Transform(
                                                  transform: Matrix4.skewX(0.4),
                                                  child: Container(
                                                      width: media.width * 0.4,
                                                      height: media.height * 0.1,
                                                      decoration: BoxDecoration(
                                                          color: TColor.PRIMARY,
                                                          borderRadius: BorderRadius.circular(10)
                                                      )
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(left: 25),
                                                  width: media.width * 0.4,
                                                  height: media.height * 0.1,
                                                  decoration: BoxDecoration(
                                                      color: TColor.PRIMARY,
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "0",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: TColor.PRIMARY_TEXT,
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Activities per week",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: TColor.PRIMARY_TEXT,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: media.width * 0.043,),
                                        SizedBox(
                                          child: CustomTextButton(
                                            onPressed: () async {
                                              Map<String, dynamic>? result = await Navigator.pushNamed(context, '/club_post', arguments: {
                                                "id": club?.id,
                                              }) as Map<String, dynamic>?;
                                              setState(() {
                                                popArguments = result ?? {};
                                                delayedInit(reload: true);
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Transform(
                                                  transform: Matrix4.skewX(0.4),
                                                  child: Container(
                                                      width: media.width * 0.4,
                                                      height: media.height * 0.1,
                                                      decoration: BoxDecoration(
                                                          color: TColor.PRIMARY,
                                                          borderRadius: BorderRadius.circular(10)
                                                      )
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(right: 25),
                                                  margin: const EdgeInsets.only(left: 40),
                                                  width: media.width * 0.4,
                                                  height: media.height * 0.1,
                                                  decoration: BoxDecoration(
                                                      color: TColor.PRIMARY,
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Posts per week",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: TColor.PRIMARY_TEXT,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${popArguments["totalPosts"] ?? club?.totalPosts}",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: TColor.PRIMARY_TEXT,
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: media.height * 0.015,),

                                    // Table section
                                    Column(
                                      children: [
                                        Row(
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
                                                    "rankType": "Club",
                                                    "id": club?.id,
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
                                        // SizedBox(height: media.height * 0.01,),
                                        (club?.numberOfParticipants != 0)
                                            ? ScrollSynchronized(
                                          parentScrollController: parentScrollController,
                                          child: AthleteTable(
                                            participants: club?.participants,
                                            tableHeight: media.height - media.height * 0.15,
                                            controller: childScrollController,
                                            startIndex: 1,
                                            isLoading: isLoading
                                          ),
                                        )
                                            : const EmptyListNotification(
                                          title: "No users joined yet!",
                                          description: "Invite your friend for joining the club ranking right away",
                                        )
                                      ],
                                    )

                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ]
                  else...[
                    Loading(),
                  ]
                ]
            ),
          ),
        ),
      ),
    );
  }
}
