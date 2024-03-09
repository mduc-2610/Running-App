import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/athlete_table.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class ClubDetailView extends StatelessWidget {
  const ClubDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomStack(
        children: [
          Image.asset(
            "assets/img/community/ptit_background.jpg",
            width: media.width,
            height: media.height * 0.2,
            fit: BoxFit.cover,
          ),
          MainWrapper(
            child: Column(
              children: [
                const Header(title: "", iconButtons: [
                  {
                    "icon": Icons.more_vert_rounded,
                  }
                ],),
                SizedBox(height: media.height * 0.07,),
                // Main section
                Container(
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
                              width: 85,
                              height: 85,
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
                                      TColor.PRIMARY
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)
                                      )
                                    )
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Join",
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
                                    // padding: MaterialStateProperty.all(
                                    //   EdgeInsets.all(0)
                                    // ),
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
                            "PTIT Runner",
                            style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: 24,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                          Row(
                            children: [
                              for(var x in [
                                {
                                  "icon": Icons.directions_run_rounded,
                                  "text": "Running",
                                },
                                {
                                  "icon": Icons.people_alt_outlined,
                                  "text": "Join",
                                },
                                {
                                  "icon": Icons.public_rounded,
                                  "text": "Public",
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
                                      x["text"] as String,
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL
                                      ),
                                    ),
                                  ],
                                ),
                                if(x["text"] == "Running" || x["text"] == "Join")...[
                                  SizedBox(width: media.width * 0.02,)
                                ]
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
                                    print("ok1");
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
                                              "3061",
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
                                  onPressed: () {
                                    print("ok2");
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
                                              "0",
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
                                        Navigator.pushNamed(context, '/rank');
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
                              AthleteTable(),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

