import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';

import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ActivityRecordListView extends StatefulWidget {
  const ActivityRecordListView({super.key});

  @override
  State<ActivityRecordListView> createState() => _ActivityRecordListViewState();
}

class _ActivityRecordListViewState extends State<ActivityRecordListView> {
  String token = "";
  DetailUser? user;
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
    });
  }

  void initUserActivity() async {
    final data = await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
    setState(() {
      userActivity = data;
      activityRecords = userActivity?.activityRecords;
    });
  }

  @override
  void didChangeDependencies() {
    initToken();
    initUser();
    initUserActivity();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    List statsList = [
      {
        "icon": "assets/img/activity/timer_icon.svg",
        "figure": '18,3 H',
        "type": "Time"
      },
      {
        "icon": "assets/img/activity/distance_icon.svg",
        "figure": '48,7 KM',
        "type": "Distance"
      },
      {
        "icon": "assets/img/activity/heartbeat_icon.svg",
        "figure": '123 BPM',
        "type": "Heart Beat"
      }
    ];
    return Scaffold(
        appBar: CustomAppBar(
          title: Header(
            title: "Activity",
            iconButtons: [
              {
                "icon": Icons.query_stats_rounded,
                "onPressed": () {
                  Navigator.pushNamed(context, '/activity_record_stats');
                },
              }
            ],
          ),
          backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
        ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: media.height * 0.02,
                        horizontal: media.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xff464c67),
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                              color: const Color(0xff444b5e),
                              width: 2
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for(var stats in statsList)...[
                            Column(
                              children: [
                                SvgPicture.asset(
                                  stats["icon"],
                                  width: media.width * 0.08,
                                  height: media.width * 0.08,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  "${stats["figure"]}",
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  "${stats["type"]}",
                                  style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: FontSize.NORMAL,
                                    fontWeight: FontWeight.w500
                                  )
                                )
                              ],
                            ),
                            if(statsList.indexOf(stats) != 2) SeparateBar(width: 2, height: media.height * 0.07)
                          ]
                        ],
                      ),
                    ),
                    SizedBox(height: media.height * 0.02,),
                    Column(
                      children: [
                        for(var activity in activityRecords ?? [])
                          CustomTextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/activity_record_detail', arguments: {
                                "id": activity?.id,
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
                                      color: const Color(0xff3f4252),
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
                                            activity?.completedAt ?? "",
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
                                                    text: '${activity?.pointsEarned}',
                                                    style: TextStyle(
                                                      color: Color(0xffda477e),
                                                    ),
                                                  ),
                                                  TextSpan(text: "  •  ${activity?.distance} km •  ${activity?.kcal} kcal"),
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
                                                text: '${activity?.steps ?? ""} ',
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
                      ],
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Menu(),
    );
  }
}
