import 'package:flutter/material.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:provider/provider.dart';

import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/search_filter.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_filter.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ClubView extends StatefulWidget {
  const ClubView({super.key});

  @override
  State<ClubView> createState() => _ClubViewState();
}

class _ClubViewState extends State<ClubView> {
  DetailUser? user;
  List<dynamic>? userClubs;
  Activity? userActivity;
  String token = "";
  bool isLoading = true;
  bool showClearButton = false;
  String sportTypeFilter = "";
  String clubModeFilter = "";
  String organizationTypeFilter = "";


  TextEditingController searchTextController = TextEditingController();

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  Future<void> initUserActivity() async {
    final activity = await callRetrieveAPI(
        null,
        null,
        user?.activity,
        Activity.fromJson,
        token,
        queryParams: "?club_name=${searchTextController.text}&"
            "club_sport_type=${sportTypeFilter}&"
            "club_mode=${clubModeFilter}&"
            "club_org_type=${organizationTypeFilter}"
    );
    setState(() {
      userClubs = activity.clubs;
      userActivity = activity;
    });
  }

  Future<void> delayedInit({bool reload = false}) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    }
    await initUserActivity();
    await Future.delayed(Duration(seconds: 1),);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    getProviderData();
    delayedInit();
    super.didChangeDependencies();
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    print("?club_name=${searchTextController.text}&"
        "club_sport_type=${sportTypeFilter}&"
        "club_mode=${clubModeFilter}&"
        "club_organization_type=${organizationTypeFilter}");

    var media = MediaQuery.sizeOf(context);
    List clubStat = [
      {
        "type": "Members",
        "amount": (i) => userClubs?[i].numberOfParticipants.toString() ?? ""
      },
      {
        "type": "Week activities",
        "amount": (i) => userClubs?[i].weekActivities.toString() ?? "",
      },
      {
        "type": "Posts",
        "amount": (i) => "10",
      }
    ];
    return Column(
      children: [

        SizedBox(height: media.height * 0.005,),
        // View all clubs
        MainWrapper(
          topMargin: 0,
          child: CustomTextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/club_list');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color?>(
                TColor.SECONDARY_BACKGROUND
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20
                )
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/img/community/running_club.jpg",
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: media.width * 0.03,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            "All clubs",
                            style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        SizedBox(height: media.height * 0.005,),
                        Text(
                          "View all Clubs here!!!",
                          style: TextStyle(
                              color: TColor.DESCRIPTION,
                              fontSize: FontSize.SMALL,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: TColor.PRIMARY_TEXT
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: media.height * 0.01),

        // Search clubs
        MainWrapper(
            topMargin: 0,
            child: SearchFilter(
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
            )
        ),
        SizedBox(height: media.height * 0.03,),

        // Your clubs
        RefreshIndicator(
          onRefresh: handleRefresh,
          child: MainWrapper(
            topMargin: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Clubs joined",
                      style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.LARGE,
                          fontWeight: FontWeight.w800
                      ),
                      // textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: media.height * 0.015,),
                if(isLoading == false)...[
                  if(userClubs?.length == 0)...[
                    SizedBox(height: media.height * 0.02,),
                    Center(
                      child: EmptyListNotification(
                        title: "No clubs found",
                        description: "Discover new clubs and compete with other athletes",
                        addButtonText: "Explore now",
                        addButton: true,
                        addButtonWidth: media.width * 0.45,
                        onPressed: () {
                          Navigator.pushNamed(context, '/club_list');
                        },
                      ),
                    )
                  ],
                  SizedBox(
                    height: media.height * 0.48,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for(var club in userClubs ?? [])...[
                            Column(
                              children: [
                                CustomTextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context,
                                        '/club_detail',
                                        arguments: {
                                          "id": club.id,
                                        }
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(0),
                                        width: media.width,
                                        height: media.height * 0.15,
                                        decoration: BoxDecoration(
                                          color: TColor.PRIMARY,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(0),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        height: media.height * 0.15,
                                        decoration: BoxDecoration(
                                            color: TColor.SECONDARY_BACKGROUND,
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(90),
                                              bottomRight: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                            ),
                                            border: Border.all(
                                              color: TColor.PRIMARY,
                                              width: 1.0,
                                            )),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    "assets/img/community/ptit_logo.png",
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                SizedBox(width: media.width * 0.02,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: media.width * 0.7,
                                                      child: Text(
                                                        club.name ?? "",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: TColor.PRIMARY_TEXT,
                                                            fontSize: FontSize.NORMAL,
                                                            fontWeight: FontWeight.w800),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${club.sportType}  •  ${club?.privacy}  •  ${club?.organization}",
                                                      style: TextStyle(
                                                          color: TColor.DESCRIPTION,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: media.height * 0.02,),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                for (int j = 0; j < 3; j++) ...[
                                                  Row(
                                                    children: [
                                                      if (j != 0) ...[
                                                        SeparateBar(
                                                            width: 2, height: media.height * 0.04),
                                                        SizedBox(width: media.width * 0.03)
                                                      ],
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            clubStat[j]["type"],
                                                            style: TextStyle(
                                                                color: TColor.DESCRIPTION,
                                                                fontSize: FontSize.SMALL,
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                          Text(
                                                            clubStat[j]["amount"](userClubs?.indexOf(club)  ?? 0 + 1),
                                                            style: TextStyle(
                                                                color: TColor.PRIMARY_TEXT,
                                                                fontSize: FontSize.NORMAL,
                                                                fontWeight: FontWeight.w800),
                                                          ),
                                                        ],
                                                      ),
                                                      if(j < 2) SizedBox(width: media.width * 0.08,),
                                                    ],
                                                  ),
                                                ]
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Icon(
                                          Icons.arrow_forward_rounded,
                                          color: TColor.PRIMARY_TEXT,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: media.height * 0.015,)
                          ]
                        ],
                      ),
                    ),
                  )
                ]
                else...[
                  Loading(
                    marginTop: media.height * 0.1,
                    backgroundColor: Colors.transparent,
                  )
                ]
              ],
            ),
          ),
        )
      ],
    );
  }
}
