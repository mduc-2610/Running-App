import 'package:flutter/material.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/layout/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';

class ClubDetailInformationView extends StatefulWidget {
  const ClubDetailInformationView({super.key});

  @override
  State<ClubDetailInformationView> createState() => _ClubDetailInformationViewState();
}

class _ClubDetailInformationViewState extends State<ClubDetailInformationView> {
  DetailClub? club;
  bool showFullText = false;
  bool showViewMoreButton = false;
  bool? joinButtonState;
  void getArguments() {
    setState(() {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      club = arguments["club"];
      joinButtonState = arguments["joinButtonState"];
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getArguments();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    print(club);
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
                Column(
                  children: [
                    SizedBox(height: media.height * 0.05,),
                    const Header(title: "", iconButtons: [
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
                                        "text": "${club?.totalParticipants ?? 0} Join",
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
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Icon(
                                            Icons.shield_outlined,
                                            color: TColor.DESCRIPTION,
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Icon(
                                              Icons.star_border_outlined,
                                              color: TColor.DESCRIPTION,
                                              size: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: media.width * 0.01,),
                                    Text(
                                      '${club?.participants?[0].name}  •  ${club?.organization}',
                                      style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.SMALL
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: media.height * 0.01,),
                                LimitTextLine(
                                    description: club?.description ?? "",
                                    onTap: () {
                                      setState(() {
                                        showFullText = (showFullText) ? false : true;
                                      });
                                    },
                                    showFullText: showFullText,
                                    showViewMoreButton: showViewMoreButton,
                                    maxLines: 3,
                                ),
                                SizedBox(height: media.height * 0.015,),
                      
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Members",
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w600,
                                          )
                                      ),
                                      CustomTextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/member_management_public', arguments: {
                                            "participants": club?.participants ?? []
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for(var participant in club?.participants ?? [])...[
                                      CustomTextButton(
                                        onPressed: () {},
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(width: 2, color: TColor.BORDER_COLOR),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Image.asset(
                                                      "assets/img/community/ptit_logo.png",
                                                      width: 35,
                                                      height: 35,
                                                    ),
                                                  ),
                                                  SizedBox(width: media.width * 0.025,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        participant?.name ?? "",
                                                        style: TextStyle(
                                                            color: TColor.PRIMARY_TEXT,
                                                            fontSize: FontSize.SMALL,
                                                            fontWeight: FontWeight.w800
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   "Nho Quan - Ninh Binh",
                                                      //   style: TextStyle(
                                                      //       color: TColor.DESCRIPTION,
                                                      //       fontSize: FontSize.SMALL,
                                                      //       fontWeight: FontWeight.w500
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    child: CustomTextButton(
                                                      style: ButtonStyle(
                                                          padding: MaterialStateProperty.all(
                                                              const EdgeInsets.symmetric(
                                                                  horizontal: 20,
                                                                  vertical: 0
                                                              )
                                                          ),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                          ),
                                                          backgroundColor: MaterialStateProperty.all(
                                                              TColor.PRIMARY
                                                          )
                                                      ),
                                                      onPressed: () {},
                                                      child: Text(
                                                        "Follow",
                                                        style: TextStyle(
                                                            color: TColor.PRIMARY_TEXT,
                                                            fontSize: FontSize.NORMAL,
                                                            fontWeight: FontWeight.w700
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ]
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
          ),
        ),
      ),
    );
  }
}
