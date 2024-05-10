import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/activity/user_participation.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/form/search_filter.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_filter.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_join_club.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ClubListView extends StatefulWidget {
  const ClubListView({super.key});

  @override
  State<ClubListView> createState() => _ClubListViewState();
}

class _ClubListViewState extends State<ClubListView> {
  bool isLoading = true, isLoading2=  false;
  List<dynamic> clubs = [];
  DetailUser? user;
  String token = "";
  bool showClearButton = false;
  String sportTypeFilter = "";
  String clubModeFilter = "";
  String organizationTypeFilter = "";
  TextEditingController searchTextController = TextEditingController();
  bool checkJoin = false;

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  Future<void> initClubs() async {
    final data = await callListAPI(
        "activity/club",
        Club.fromJson,
        token,
        queryParams: "?name=${searchTextController.text}&"
            "sport_type=${sportTypeFilter}&"
            "mode=${clubModeFilter}&"
            "org_type=${organizationTypeFilter}"
    );
    setState(() {
      // clubs.addAll(data.map((e) => {
      //   "club": e,
      //   "joinButtonState": {
      //     "text": (e.checkUserJoin == null) ? "Join" : "Joined",
      //     "backgroundColor": (e.checkUserJoin == null) ? TColor.PRIMARY : TColor.BUTTON_DISABLED,
      //   }
      // }));
      clubs = data.map((e) => {
        "club": e,
        "joinButtonState": {
          "text": (e.checkUserJoin == null) ? "Join" : "Joined",
          "backgroundColor": (e.checkUserJoin == null) ? TColor.PRIMARY : TColor.BUTTON_DISABLED,
        }
      }).toList();
    });
  }

  void delayedInit({bool reload = false, bool reload2 = false, int? milliseconds}) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    }
    if(reload2) {
      setState(() {
        isLoading2 = true;
      });
    }
    await initClubs();
    await Future.delayed(Duration(milliseconds: milliseconds ?? 1000));

    setState(() {
      isLoading = false;
      isLoading2 = false;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    getProviderData();
    delayedInit();
  }

  Future<void> handleRefresh() async {
    setState(() {
      isLoading2 = true;
    });
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    print("?name=${searchTextController.text}&"
        "sport_type=${sportTypeFilter}&"
        "mode=${clubModeFilter}&"
        "org_type=${organizationTypeFilter}");
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Club", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    // Search clubs
                    SearchFilter(
                        hintText: "Search clubs",
                        controller: searchTextController,
                        showClearButton: showClearButton,
                        onClearChanged: () {
                          searchTextController.clear();
                          setState(() {
                            showClearButton = false;
                          });
                          delayedInit(reload: true);
                        },
                        onFieldSubmitted: (String x) {
                          delayedInit(reload: true);
                        },
                        onPrefixPressed: () {
                          delayedInit(reload: true);
                        },
                        filterOnPressed:() async {
                          Map<String, String?> result =await showFilter(
                              context,
                              [
                                {
                                  "title": "Sport type",
                                  "list": ["Running", "Cycling", "Swimming"]
                                },
                                {
                                  "title": "Club mode",
                                  "list": ["Public", "Private"]
                                },
                                {
                                  "title": "Organization type",
                                  "list": ["Company", "Sport club", "School"]
                                },
                              ],
                              buttonClicked: [sportTypeFilter, clubModeFilter, organizationTypeFilter]
                          );

                          setState(() {
                            sportTypeFilter = result["Sport type"] ?? "";
                            clubModeFilter = result["Club mode"] ?? "";
                            organizationTypeFilter = result["Organization type"] ?? "";
                            delayedInit(reload: true);
                          });
                        }
                    ),

                    SizedBox(height: media.height * 0.01,),
                    // All clubs
                    if(isLoading == false)...[
                      if(clubs.length == 0)...[
                        SizedBox(height: media.height * 0.25,),
                        EmptyListNotification(
                          title: "No clubs found",
                          description: "",
                        )
                      ]
                      else...[
                        SizedBox(
                          height: media.height * 0.83,
                          child: GridView.count(
                              padding: const EdgeInsets.all(0),
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,

                              crossAxisSpacing: media.width * 0.035,
                              mainAxisSpacing: media.height * 0.01,
                              children: [
                                for(int i = 0; i < clubs.length; i++)
                                  CustomTextButton(
                                    onPressed: () async {
                                      Map<String, dynamic> result = await Navigator.pushNamed(context, '/club_detail', arguments: {
                                        "id": clubs[i]["club"].id
                                      }) as Map<String, dynamic>;
                                      setState(() {
                                        checkJoin = result["checkJoin"];
                                      });
                                      if(checkJoin) {
                                        print("CHECK JOIN $checkJoin");
                                        delayedInit(reload2: true);
                                      }
                                    },
                                    child: IntrinsicHeight(
                                      child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                color: TColor.SECONDARY_BACKGROUND,
                                                border: Border.all(
                                                  color: const Color(0xff495466),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: Image.asset(
                                                        "assets/img/community/ptit_logo.png",
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: media.height * 0.015,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        clubs[i]["club"].name ?? "",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: TColor.PRIMARY_TEXT,
                                                            fontSize: FontSize.LARGE,
                                                            fontWeight: FontWeight.w800
                                                        ),
                                                      ),
                                                      // SizedBox(height: media.height * 0.01),
                                                      Text(
                                                        clubs[i]["club"].sportType ?? "",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: TColor.DESCRIPTION,
                                                          fontSize: FontSize.SMALL,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      // SizedBox(height: media.height * 0.005,),
                                                      Text(
                                                        "Member: ${clubs[i]["club"].totalParticipants}",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: TColor.DESCRIPTION,
                                                          fontSize: FontSize.SMALL,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: media.height * 0.01,),

                                                  Center(
                                                    child: SizedBox(
                                                      width: media.width * 0.4, // Set width of the TextButton
                                                      height: 35,
                                                      child: CustomMainButton(
                                                        horizontalPadding: 0,
                                                        verticalPadding: 0,
                                                        borderRadius: 8,
                                                        onPressed: () {
                                                          if(clubs[i]["joinButtonState"]["text"] == "Join") {
                                                            showJoinClub(
                                                                context,
                                                                "assets/img/community/ptit_logo.png",
                                                                "Join ${clubs[i]["club"].name.substring(0, min(clubs[i]["club"].name.length as int, 6)).trim()}... club",
                                                                "Are you sure you want to join?",
                                                                "Join",
                                                                agreeOnPressed: () async {
                                                                  UserParticipationClub userParticipationClub = UserParticipationClub(
                                                                      userId: getUrlId(user?.activity ?? ""),
                                                                      clubId: clubs[i]["club"].id
                                                                  );
                                                                  final data = await callCreateAPI(
                                                                      'activity/user-participation-club',
                                                                      userParticipationClub.toJson(),
                                                                      token
                                                                  );
                                                                  delayedInit(reload2: true, milliseconds: 0);
                                                                  clubs[i]["club"].checkUserJoin = data["id"];
                                                                  setState(() {
                                                                    if(clubs[i]["joinButtonState"]["text"] == "Join") {
                                                                      clubs[i]["joinButtonState"] = {
                                                                        "text": "Joined",
                                                                        "backgroundColor": TColor.BUTTON_DISABLED
                                                                      };
                                                                    }
                                                                  });
                                                                }
                                                            );
                                                          }
                                                          else {
                                                            showJoinClub(
                                                                context,
                                                                "assets/img/community/ptit_logo.png",
                                                                "Leave ${clubs[i]["club"].name.substring(0, min(clubs[i]["club"].name.length as int, 6)).trim()}... club",
                                                                "Are you sure you want to leave this club?",
                                                                "Leave this club",
                                                                agreeOnPressed: () async {
                                                                  await callDestroyAPI(
                                                                      'activity/user-participation-club',
                                                                      clubs[i]["club"].checkUserJoin,
                                                                      token
                                                                  );
                                                                  delayedInit(reload2: true, milliseconds: 0);
                                                                  setState(() {
                                                                    if(clubs[i]["joinButtonState"]["text"] == "Join") {
                                                                      clubs[i]["joinButtonState"] = {
                                                                        "text": "Join",
                                                                        "backgroundColor": TColor.PRIMARY
                                                                      };
                                                                    }
                                                                  });
                                                                }
                                                            );
                                                          }
                                                        },
                                                        background: clubs[i]["joinButtonState"]["backgroundColor"],
                                                        child: Text(
                                                          clubs[i]["joinButtonState"]["text"],
                                                          style: TextStyle(
                                                              color: TColor.PRIMARY_TEXT,
                                                              fontSize: FontSize.LARGE,
                                                              fontWeight: FontWeight.w800
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]

                                      ),
                                    ),
                                  ),
                              ]
                          ),
                        ),
                      ]
                    ]
                    else...[
                      Loading(
                        marginTop: media.height * 0.3,
                        backgroundColor: Colors.transparent,
                      )
                    ]

                  ],
                )
              ),
              if(isLoading2)...[
                Loading(
                  marginTop: media.height * 0.4,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
