
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/performance.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/progress_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

import '../../models/account/user.dart';
import '../../utils/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic>? users;
  String token = "";
  DetailUser? user;
  Performance? userPerformance;
  Activity? userActivity;
  List<ActivityRecord>? activityRecords;

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initUser() {
    setState(() {
      user = Provider.of<UserProvider>(context).user;
      userPerformance = Provider.of<UserProvider>(context).userPerformance;
      userActivity = Provider.of<UserProvider>(context).userActivity;
      activityRecords = userActivity?.activityRecords;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    print(userPerformance);
    print(userActivity);
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(username: '${user?.name}' ?? "",),
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              BackgroundContainer(height: media.height * 0.4,),
              MainWrapper(
                child: Column(
                  children: [
                    // Level
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: media.width * 0.78),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "${userPerformance?.stepsDoneThisLevel} / ",
                                        ),
                                        TextSpan(
                                          text: "${userPerformance?.totalStepsThisLevel} ",
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.LARGE,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "steps",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Level ${userPerformance?.level ?? 1}",
                                    style: TextStyle(
                                      color: Color(0xffffc932),
                                      fontSize: FontSize.LARGE,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8
                                    )
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: media.height * 0.005,),
                            ProgressBar(
                              totalSteps: userPerformance?.totalStepsThisLevel ?? 1, // Total steps
                              currentStep: userPerformance?.stepsDoneThisLevel ?? 0, // Current step
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          "assets/img/home/star.svg",
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
        
                    SizedBox(height: media.height * 0.02,),
                    // Today
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: media.height * 0.015,
                        horizontal: media.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff6b60bd),
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: Color(0xff746cb3),
                          width: 2
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/img/home/running_avt.svg",
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: media.width * 0.03 ,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "26 May",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Today",
                                    style: TextStyle(
                                      color: Color(0xff43c465),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "01:09:44",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: 12,
                                    ),
                                  )
        
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/img/home/step_icon.svg",
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: media.width * 0.01,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "2345",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 2),
        
                                  SeparateBar(width: 27, height: 1,),
        
                                  SizedBox(height: 2),
                                  Text(
                                    "5000",
                                    style: TextStyle(
                                      color: Color(0xff43c465),
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
        
                    SizedBox(height: media.height * 0.02,),
        
                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(var x in [
                          {
                            "amount": userPerformance?.periodSteps ?? 0,
                            "iconSvg": "assets/img/home/step_icon.svg",
                            "text": "Steps",
                          },
                          {
                            "amount": userPerformance?.totalPoints ?? 0,
                            "iconSvg": "assets/img/home/coin_icon.svg",
                            "text": "Points",
                          }
                        ])
                          Container(
                            width: media.width * 0.46,
                            height: media.height * 0.18,
                            // padding: EdgeInsets.symmetric(
                            //   vertical: media.height * 0.047,
                            //   horizontal: media.width * 0.075,
                            // ),
        
                            decoration: BoxDecoration(
                                color: Color(0xff6b60bd),
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                    color: Color(0xff746cb3),
                                    width: 2
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  x["amount"].toString(),
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 40,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        x["iconSvg"] as String,
                                        width: 18,
                                        height: 18,
                                    ),
                                    SizedBox(width: media.width * 0.01,),
                                    Text(
                                      x["text"] as String,
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.LARGE,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ]
                            ),
                          )
                      ],
                    ),
        
                    SizedBox(height: media.height * 0.04,),
        
                    // Event
                    CustomTextButton(
                      onPressed: () {
        
                      },
                      child: SvgPicture.asset(
                        'assets/img/home/event_banner.svg',
                        width: media.width * 0.95,
                        fit: BoxFit.contain,
                      ), // Replace 'my_image.png' with your image asset path
                    ),
        
                    // History
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "History",
                              style: TxtStyle.headSection
                            ),
                            CustomTextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/activity_record_list');
                              },
                              child: Text(
                                  "See all",
                                  style: TextStyle(
                                    color: TColor.PRIMARY,
                                    fontSize: FontSize.NORMAL,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                            )
                          ]
                        ),
                        Column(
                          children: [
                            for(int i = 0; i < min(activityRecords?.length ?? 0, 5); i++)...[
                              CustomTextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/activity_record_detail', arguments: {
                                    "id": activityRecords?[i].id,
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, media.height * 0.01),
                                  padding: EdgeInsets.symmetric(
                                    vertical: media.height * 0.015,
                                    horizontal: media.width * 0.05,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          color: Color(0xff3f4252),
                                          width: 2
                                      )
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                activityRecords?[i].completedAt ?? "",
                                                style: TextStyle(
                                                  color: TColor.PRIMARY,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                )
                                            ),
                                            SizedBox(height: media.height * 0.005),
                                            RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: TColor.DESCRIPTION,
                                                      fontSize: 12,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '${activityRecords?[i].pointsEarned}',
                                                        style: TextStyle(
                                                          color: Color(0xffda477e),
                                                        ),
                                                      ),
                                                      TextSpan(text: "  •  ${activityRecords?[i].distance} km •  ${activityRecords?[i].kcal} kcal"),
                                                    ]
                                                )
                                            )
                                          ],
                                        ),

                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: TColor.DESCRIPTION,
                                                  fontSize: FontSize.SMALL,
                                                  fontWeight: FontWeight.w400
                                              ),
                                              children: <TextSpan> [
                                                TextSpan(
                                                    text: '${activityRecords?[i].steps ?? ""} ',
                                                    style: TextStyle(
                                                        color: TColor.DESCRIPTION,
                                                        fontSize: FontSize.NORMAL,
                                                        fontWeight: FontWeight.w900
                                                    )
                                                ),
                                                TextSpan(text: "steps")
                                              ]
                                          ),
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ],
                    )
                  ]
                )
              ),
        
            ],
          ),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }
}
