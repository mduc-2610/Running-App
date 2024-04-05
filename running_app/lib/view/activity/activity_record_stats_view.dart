
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/account/performance.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_month_year.dart';
import 'package:running_app/utils/common_widgets/stats_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ActivityRecordStatsView extends StatefulWidget {
  const ActivityRecordStatsView({super.key});

  @override
  State<ActivityRecordStatsView> createState() => _ActivityRecordStatsViewState();
}

class _ActivityRecordStatsViewState extends State<ActivityRecordStatsView> {
  String _showView = "Running";
  DateTime? selectedDate;
  String token = "";
  DetailUser? user;
  Performance? userPerformance;
  // Activity? userActivity;
  Map<String, int> monthYearFilter = {
    'month': DateTime.now().month,
    'year': DateTime.now().year,
  };

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


  void initUserPerformance() async {
    final startDate = DateTime(monthYearFilter['year'] ?? 0, monthYearFilter['month'] ?? 0, 1);
    final endDate = DateTime(monthYearFilter['year'] ?? 0, (monthYearFilter['month'] ?? 0) + 1, 0);

    final formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    final formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
    final data = await callRetrieveAPI(
        null,
        null,
        user?.performance,
        Performance.fromJson,
        token,
        queryParams: "?start_date=${formattedStartDate}"
            "&end_date=${formattedEndDate}"
    );
    setState(() {
      userPerformance = data;
    });
  }

  // void initUserActivity() async {
  //   final data = await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
  //   setState(() {
  //     userActivity = data;
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initUser();
    initToken();
    initUserPerformance();
    // initUserActivity();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Statistics", noIcon: true),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Head section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Statistics",
                        style: TxtStyle.headSectionExtra,
                      ),
                      Text(
                        "Choose your sports",
                        style: TxtStyle.normalTextDesc
                      ),
                      SizedBox(height: media.height * 0.02,),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10
                        ),
                        decoration: BoxDecoration(
                          color: TColor.SECONDARY_BACKGROUND,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: TColor.BORDER_COLOR
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for(var x in [
                              {
                                "type": "Running",
                                "icon": Icons.directions_run_rounded,
                              },
                              {
                                "type": "Walking",
                                "icon": Icons.directions_walk_rounded,
                              },
                              {
                                "type": "Cycling",
                                "icon": Icons.directions_bike_rounded,
                              },
                              {
                                "type": "Swimming",
                                "icon": Icons.pool_rounded,
                              },
                            ])...[
                              CustomTextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showView = x["type"] as String;
                                    });
                                  },
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: media.width * 0.07
                                          )
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color?>(
                                          _showView == x["type"] ? TColor.PRIMARY : null
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          )
                                      )
                                  ),
                                  child: Icon(
                                    x["icon"] as IconData,
                                    color: TColor.PRIMARY_TEXT,
                                  )
                              )
                            ]
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: media.height * 0.02,),

                  // Stats section
                  Column(
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   width: media.width,
                      //   child:
                      //   DateTimeFormField(
                      //     style: TextStyle(
                      //       color: TColor.DESCRIPTION,
                      //       fontSize: FontSize.SMALL,
                      //     ),
                      //     decoration: CustomInputDecoration(
                      //       suffixIcon: Icon(
                      //         Icons.calendar_today_rounded,
                      //         color: TColor.DESCRIPTION,
                      //       ),
                      //       //   hintText: "${DateTime.now().toString().split(' ')[0]} 00:00",
                      //       //   hintStyle: TextStyle(
                      //       //   color: TColor.DESCRIPTION,
                      //       //   fontSize: FontSize.SMALL,
                      //       // ),
                      //       label: Text(
                      //         "${DateTime.now().toString().split(' ')[0]} 00:00",
                      //         style: TextStyle(
                      //           color: TColor.DESCRIPTION,
                      //           fontSize: FontSize.SMALL,
                      //         ),
                      //         textAlign: TextAlign.center,
                      //       ),
                      //       contentPadding: const EdgeInsets.symmetric(
                      //           horizontal: 20
                      //       ),
                      //     ),
                      //
                      //     materialDatePickerOptions: const MaterialDatePickerOptions(),
                      //     firstDate: DateTime.now().add(const Duration(days: 10)),
                      //     lastDate: DateTime.now().add(const Duration(days: 365)),
                      //     initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                      //     onChanged: (DateTime? value) {
                      //       selectedDate = value;
                      //     },
                      //   ),
                      // ),
                      CustomMainButton(
                        borderWidth: 2,
                        borderWidthColor: TColor.BORDER_COLOR,
                        background: Colors.transparent,
                        horizontalPadding: 25,
                        onPressed: () async {
                          int selectedMonth = await showMonth(context);
                          int selectedYear = (await showYear(context)) ?? monthYearFilter['year'] ?? DateTime.now().year;

                          setState(() {
                            monthYearFilter = {
                              'month': selectedMonth,
                              'year': selectedYear,
                            };
                          });

                          print(monthYearFilter);
                          initUserPerformance();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${Month.REVERSED_MONTH_MAP[monthYearFilter['month']]}, ${monthYearFilter['year']}",
                              style: TxtStyle.normalText,
                            ),
                            Icon(
                              Icons.calendar_today_rounded,
                              color: TColor.PRIMARY_TEXT,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: media.height * 0.015,),

                      StatsLayout(
                        totalDistance: "${userPerformance?.periodDistance ?? 0}",
                        totalActiveDays: "${userPerformance?.periodActiveDays ?? 00}",
                        totalAvgPace: "${userPerformance?.periodAvgMovingPace ?? "00:00"}",
                        totalTime: "${userPerformance?.periodDuration ?? "00:00:00"}",
                        totalAvgHeartBeat: "${userPerformance?.periodAvgTotalHeartRate ?? 0}",
                        totalAvgCadence: "${userPerformance?.periodAvgTotalCadence ?? 0}",
                        boxNumber: 6,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
