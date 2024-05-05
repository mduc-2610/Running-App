import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/button/choice_button.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/view/community/event/utils/provider/event_feature_create_provider.dart';

class EventFeatureCreateView extends StatefulWidget {
  const EventFeatureCreateView({super.key});

  @override
  State<EventFeatureCreateView> createState() => _EventFeatureCreateViewState();
}

class _EventFeatureCreateViewState extends State<EventFeatureCreateView> {
  String sportChoice = "Running";
  String competitionType = "Group";

  void setProvider() {
    Provider.of<EventFeatureCreateProvider>(context, listen: false).setData(sportType: sportChoice, competition: competitionType);
    Navigator.pushNamed(context, '/event_information_create');
  }

  void deleteAllPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privacy');
    await prefs.remove('minimumDistance');
    await prefs.remove('maximumDistance');
    await prefs.remove('slowestAvgPace');
    await prefs.remove('fastestAvgPace');
    await prefs.remove('donatedMoneyExchange');
    await prefs.remove('ruleButtonState');
    await prefs.remove('minimumDistanceButtonState');
    await prefs.remove('maximumDistanceButtonState');
    await prefs.remove('slowestAvgPaceButtonState');
    await prefs.remove('fastestAvgPaceButtonState');
    await prefs.remove('totalAccumulatedDistance');
    await prefs.remove('totalMoneyDonated');
  }

  void backButtonOnPressed() {
    deleteAllPreferences();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List sportType = [
      {
        "icon": Icons.directions_run_rounded,
        "text": "Running"
      },
      {
        "icon": Icons.directions_bike_rounded,
        "text": "Cycling"
      },
      {
        "icon": Icons.pool_rounded,
        "text": "Swimming"
      },
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(title: "Create challenge", noIcon: true, backButtonOnPressed: backButtonOnPressed),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Competition section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Competition",
                          style: TxtStyle.headSection
                      ),
                      SizedBox(height: media.height * 0.02,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for(var x in [
                            {
                              "competitionType": "Group",
                              "icon": Icons.people_alt_rounded,
                              "desc": "Group in the competition will be ranked based on the total achievements of the group members",
                            },
                            {
                              "competitionType": "Individual",
                              "icon": Icons.person,
                              "desc": "Individual in the competition will be ranked based on their achievements"
                            }
                          ])...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          x["icon"] as IconData,
                                          color: TColor.PRIMARY_TEXT,
                                        ),
                                        SizedBox(width: media.width * 0.02,),
                                        Text(
                                          x["competitionType"] as String,
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.NORMAL,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: media.height * 0.005,),
                                    SizedBox(
                                      width: media.width * 0.85,
                                      child: Text(
                                        x["desc"] as String,
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Radio(
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  value: x["competitionType"] as String,
                                  groupValue: competitionType,
                                  onChanged: (value) {
                                    setState(() {
                                      competitionType = value!;
                                    });
                                  },
                                  fillColor: MaterialStateProperty.all<Color>(
                                      TColor.PRIMARY
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: media.height * 0.02,),
                          ]
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: media.height * 0.02,),

                  // Sport type section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Sport type",
                          style: TxtStyle.headSection
                      ),
                      SizedBox(height: media.height * 0.01,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for(var sport in sportType)...[
                              ChoiceButton(
                                text: sport["text"],
                                icon: sport["icon"] as IconData,
                                buttonState: (sport["text"] == sportChoice) ? BtnState.buttonStateClicked : BtnState.buttonStateUnClicked,
                                onPressed: () {
                                  setState(() {
                                    sportChoice = sport["text"];
                                  });
                                  print('$sportChoice ${sport["text"]}');
                                },
                              ),
                              SizedBox(width: media.width * 0.02,),
                            ]
                          ],
                        ),
                      ),
                      SizedBox(height: media.height * 0.015,),
                    ],
                  ),
                  SizedBox(height: media.height * 0.02,),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Wrapper(
          child: Container(
            margin: EdgeInsets.fromLTRB(media.width * 0.025, 15, media.width * 0.025, media.width * 0.025),
            child: CustomMainButton(
              horizontalPadding: 0,
              onPressed: setProvider,
              child: Text(
                "Continue",
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
            ),
          )
      ),
    );
  }
}
