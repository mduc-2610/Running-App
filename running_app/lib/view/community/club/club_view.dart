import 'package:flutter/material.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:provider/provider.dart';

import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/search_filter.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

String title(String? x) {
  return (x?.substring(0, 1).toUpperCase() ?? "") + (x?.substring(1).toLowerCase() ?? "");
}

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

  Future<void> api() async {
    try {
      user = Provider.of<UserProvider>(context).user;
      print('User: _____________________$user');
      final activity = await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
      setState(() {
        userClubs = activity.clubs;
        userActivity = activity;
      });
    } catch (e) {
      print("Error fetching data: $e");
      // Handle errors here
    }
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
    api();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    print('Club: $token');
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
    return SizedBox(
      child: Column(
        children: [

          SizedBox(height: media.height * 0.005,),
          // View all clubs
          CustomTextButton(
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
          SizedBox(height: media.height * 0.01),

          // Search clubs
          const SearchFilter(hintText: "Search clubs"),
          SizedBox(height: media.height * 0.03,),

          // Your clubs
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Clubs joined",
                style: TextStyle(
                  color: TColor.PRIMARY_TEXT,
                  fontSize: FontSize.LARGE,
                  fontWeight: FontWeight.w800
                ),

              ),
              SizedBox(height: media.height * 0.015,),
              SizedBox(
                height: media.height * 0.48,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for(int i = 0; i < userActivity!.clubs.length; i++)...[
                        Column(
                          children: [
                            CustomTextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    '/club_detail',
                                    arguments: {
                                      "id": userClubs?[i].id,
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
                                                Text(
                                                  userClubs?[i].name ?? "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: TColor.PRIMARY_TEXT,
                                                      fontSize: FontSize.NORMAL,
                                                      fontWeight: FontWeight.w800),
                                                ),
                                                Text(
                                                  title(userClubs?[i].sportType),
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
                                                        clubStat[j]["amount"](i),
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
            ],
          ),
          // SizedBox(height: media.height * 0.1,)
        ],
      ),
    );
  }
}
