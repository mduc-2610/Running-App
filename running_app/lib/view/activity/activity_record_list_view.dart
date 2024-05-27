
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/account/performance.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';

import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/menu.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/separate_bar.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ActivityRecordListView extends StatefulWidget {
  const ActivityRecordListView({super.key});

  @override
  State<ActivityRecordListView> createState() => _ActivityRecordListViewState();
}

class _ActivityRecordListViewState extends State<ActivityRecordListView> {
  bool isLoading = true, isLoading2 = false;
  String token = "";
  DetailUser? user;
  String? requestUserId;
  Activity? userActivity;
  Performance? userPerformance;
  List<ActivityRecord> activityRecords = [];
  ScrollController scrollController = ScrollController();
  double previousScrollOffset = 0;
  int page = 1;
  bool stopLoadingPage = false;
  bool checkReload = false;

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
      requestUserId = user?.id;
    });
  }

  Future<void> initUser() async {
    Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    print(arguments?["id"]);
    String? userId = arguments?["id"];
    print(userId);
    if(userId != null) {
      final data = await callRetrieveAPI('account/user', userId, null, DetailUser.fromJson, token);
      setState(() {
        user = data;
      });
    }
  }

  Future<void> initUserActivity() async {
    dynamic data;
    try {
      data = await callRetrieveAPI(
          null, null,
          user?.activity,
          Activity.fromJson,
          token,
          queryParams: "?fields=activity_records&"
              "act_rec_page=$page&"
              "act_rec_page_size=15"
      );
    }
    catch(e) {
      setState(() {
        stopLoadingPage = true;
      });
    }
    setState(() {
      userActivity = data;
      activityRecords.addAll(userActivity?.activityRecords ?? []);
    });
  }

  Future<void> initUserPerformance() async {
    final data = await callRetrieveAPI(null, null, user?.performance, Performance.fromJson, token);
    setState(() {
      userPerformance = data;
    });
  }


  Future<void> delayedInit({ bool reload = false, reload2 = false, bool initSide = false }) async {
    if(reload) {
      setState(() {
        activityRecords = [];
        page = 1;
        isLoading = true;
      });
    }

    if(reload2) {
      setState(() {
        activityRecords = [];
        page = 1;
        isLoading2 = true;
      });
    }

    if(initSide) {
      await initUser();
      await initUserPerformance();
    }
    await initUserActivity();
    // await Future.delayed(Duration(seconds: 1),);
    setState(() {
      isLoading = false;
      isLoading2 = false;
    });
  }

  void scrollListenerOffSet() {
    double currentScrollOffset = scrollController.offset;
    if ((currentScrollOffset - previousScrollOffset).abs() > 500) {
      print("Loading page $page");
      previousScrollOffset = currentScrollOffset;
      setState(() {
        page += 1;
      });
      if(!stopLoadingPage) {
        delayedInit();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListenerOffSet);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    getProviderData();
    delayedInit(initSide: true);
    super.didChangeDependencies();
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List statsList = [
      {
        "icon": "assets/img/activity/timer_icon.svg",
        "figure": '${formatTimeDuration('${userPerformance?.periodDuration ?? "00:00:00"}')}',
        "type": "Time"
      },
      {
        "icon": "assets/img/activity/distance_icon.svg",
        "figure": '${userPerformance?.periodDistance?.toStringAsFixed(1)} KM',
        "type": "Distance"
      },
      {
        "icon": "assets/img/activity/heartbeat_icon.svg",
        "figure": '${userPerformance?.periodAvgTotalHeartRate ?? 0} BPM',
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
                  Navigator.pushNamed(
                    context,
                    '/activity_record_stats',
                    arguments: requestUserId == user?.id ? null : {"id": user?.id},
                  );
                },
              }
            ],
            argumentsOnPressed: {
              "reload": checkReload,
            },
          ),
          backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
        ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              if(isLoading == false)...[
                MainWrapper(
                    child: SingleChildScrollView(
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
                                if(activityRecords?.length == 0)...[
                                  SizedBox(height: media.height * 0.2,),
                                  EmptyListNotification(
                                    title: "No activities ",
                                  )
                                ],
                                for(var activity in activityRecords ?? [])
                                  CustomTextButton(
                                    onPressed: () async {
                                      Map<String, dynamic>? result = await Navigator.pushNamed(context, '/activity_record_detail', arguments: {
                                        "id": activity?.id,
                                        "checkRequestUser": true,
                                      }) as Map<String, dynamic>?;
                                      if(result != null) {
                                        delayedInit(reload: result["reload"]);
                                        setState(() {
                                          checkReload = result["reload"];
                                        });
                                      }
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
                                                            text: '${activity?.points}',
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
                      ),
                    )
                ),
              ]
              else...[
                Loading(marginTop: media.height * 0.05,)
              ],
              if(isLoading2)...[
                Loading()
              ]
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const Menu(),
    );
  }
}
