import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:running_app/models/account/leaderboard.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/athlete_table.dart';
import 'package:running_app/utils/common_widgets/layout/background_container.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/button/icon_button.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/menu.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/scroll_synchronized.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_month_year.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  String menuButtonClicked = "/rank";
  bool isLoading = false, reachEnd = false, stopLoading = false;
  List timeList = ["Week", "Month", "Year"];
  String period = "Week";
  String gender = "";
  String sort_by = "Distance";
  ScrollController scrollController = ScrollController();
  ScrollController childScrollController = ScrollController();
  ScrollController parentScrollController = ScrollController();
  int page = 1;
  double previousScrollOffset = 0;

  DateTime? startDateOfWeek;
  DateTime? endDateOfWeek;

  DateTime? startDateOfMonth;
  DateTime? endDateOfMonth;

  DateTime? startDateOfYear;
  DateTime? endDateOfYear;

  String? dateRepresent;

  List<dynamic>? weekList, monthList, yearList;

  List<dynamic> userList = [];
  String token = "";

  String rankType = "";
  String rankTypeId = "";

  void initTime() {
    DateTime now = DateTime.now();
    if(period == "Week") {
      weekList = [];
      startDateOfWeek = startDateOfWeek ?? now.subtract(Duration(days: now.weekday - 1));
      endDateOfWeek = endDateOfWeek ?? startDateOfWeek!.add(Duration(days: 6));
      dateRepresent = "${formatDate(startDateOfWeek).substring(0, formatDate(startDateOfWeek).length - 5)} - ${formatDate(endDateOfWeek)}";
      DateTime? tmpStartDate = startDateOfWeek!;
      DateTime? tmpEndDate = endDateOfWeek!;
      for(int i = 0; i < 240; i++) {
        weekList?.add(
            {
              "dateRepresent": "${formatDate(tmpStartDate).substring(0, formatDate(tmpEndDate).length - 5)} - ${formatDate(tmpEndDate)}",
              "startDate": tmpStartDate,
              "endDate": tmpEndDate
            }
        );;
        tmpStartDate = tmpStartDate?.subtract(Duration(days: 7));
        tmpEndDate = tmpEndDate?.subtract(Duration(days: 7));
      }
    }
    else if (period == "Month") {
      monthList = [];
      startDateOfMonth = startDateOfMonth ?? DateTime(now.year, now.month, 1);
      endDateOfMonth = endDateOfMonth ?? DateTime(now.year, now.month + 1, 0);
      dateRepresent = "${formatMonth(startDateOfMonth)}";
      DateTime? tmpStartDateOfMonth = startDateOfMonth!;
      DateTime? tmpEndDateOfMonth = endDateOfMonth!;
      for(int i = 0; i < 60; i++) {
        monthList?.add(
            {
              "dateRepresent": "${formatMonth(tmpStartDateOfMonth)}",
              "startDate": tmpStartDateOfMonth,
              "endDate": tmpEndDateOfMonth
            }
        );
        tmpStartDateOfMonth = DateTime(tmpStartDateOfMonth!.year, tmpStartDateOfMonth.month - 1, 1);
        tmpEndDateOfMonth = DateTime(tmpEndDateOfMonth!.year, tmpEndDateOfMonth.month, 1).subtract(Duration(days: 1));
      }
    }
    else if(period == "Year") {
      yearList = [];
      startDateOfYear = startDateOfYear ?? DateTime(now.year, 1, 1);
      endDateOfYear = endDateOfYear ?? DateTime(now.year, 12, 31);
      dateRepresent = "${formatYear(startDateOfYear)}";
      DateTime? tmpStartDateOfYear = startDateOfYear!;
      DateTime? tmpEndDateOfYear = endDateOfYear!;
      for(int i = 0; i < 5; i++) {
        yearList?.add(
            {
              "dateRepresent": "${formatYear(tmpStartDateOfYear)}",
              "startDate": tmpStartDateOfYear,
              "endDate": tmpEndDateOfYear
            }
        );
        tmpStartDateOfYear = DateTime(tmpStartDateOfYear!.year - 1, tmpStartDateOfYear.month, startDateOfYear!.day);
        tmpEndDateOfYear = DateTime(tmpEndDateOfYear!.year - 1, tmpEndDateOfYear.month, endDateOfYear!.day);
      }
    }
  }

  DateTime? getStartDate() {
    if(period == "Week") {
      return startDateOfWeek;
    }
    else if (period == "Month") {
      return startDateOfMonth;
    }
    return startDateOfYear;
  }

  DateTime? getEndDate() {
    if(period == "Week") {
      return endDateOfWeek;
    }
    else if (period == "Month") {
      return endDateOfMonth;
    }
    return endDateOfYear;
  }

  void setDateRepresent() {
    if(period == "Week") {
      dateRepresent = "${formatDate(startDateOfWeek).substring(0, formatDate(startDateOfWeek).length - 5)} - ${formatDate(endDateOfWeek)}";
    }
    else if (period == "Month") {
      dateRepresent = "${formatMonth(startDateOfMonth)}";
    }
    else if(period == "Year") {
      dateRepresent = "${formatYear(startDateOfYear)}";
    }
  }

  String formatDate(DateTime? date) {
    return DateFormat('MM/dd/yyyy').format(date!);
  }

  String formatMonth(DateTime? date) {
    return DateFormat('MM/yyyy').format(date!);
  }

  String formatYear(DateTime? date) {
    return DateFormat('yyyy').format(date!);
  }

  void getSideData() {
    setState(() {
      Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      token = Provider.of<TokenProvider>(context).token;
      rankType = arguments?["rankType"] ?? "";
      rankTypeId = arguments?["id"] ?? "";
    });
  }

  Future<void> initUser() async {
    String queryParams = "?gender=${gender}"
        "&sort_by=${sort_by}"
        "&start_date=${formatDateQuery(getStartDate())}"
        "&end_date=${formatDateQuery(getEndDate())}"
        "&page=$page";
    dynamic data;
    try {
      data =
      (rankType == "") ? await callListAPI(
          'account/performance/leaderboard',
          Leaderboard.fromJson,
          token,
          queryParams: queryParams
      ) : (rankType == "Club")
          ?(await callRetrieveAPI(
          'activity/club',
          rankTypeId,
          null,
          DetailClub.fromJson,
          token,
          queryParams: queryParams
      )).participants
          : (await callRetrieveAPI(
          'activity/event',
          rankTypeId,
          null,
          DetailEvent.fromJson,
          token,
          queryParams: queryParams
      )).participants;
    }
    catch(e) {
      setState(() {
        stopLoading = true;
      });
    }
    if(!stopLoading) {
      setState(() {
        userList.addAll(data);
        if(userList.length == 1) {
          userList.insert(0, null);
        }
        else if (userList.length >= 2) {
          dynamic temp = userList[0];
          userList[0] = userList[1];
          userList[1] = temp;
        }
      });
    }
  }

  void scrollListenerOffSet() {
    if (childScrollController.position.pixels ==
        childScrollController.position.maxScrollExtent && !stopLoading) {
      setState(() {
        reachEnd = true;
        page += 1;
      });
      if(!stopLoading) {
        delayedUser(milliseconds: 500);
      }
    }
  }

  @override
  void initState() {
    initTime();
    childScrollController.addListener(scrollListenerOffSet);
    super.initState();
  }

  @override
  void dispose() {
    childScrollController.dispose();
    super.dispose();
  }

  void delayedUser({ bool reload = false, int milliseconds = 500}) async {
    if(reload) {
      setState(() {
        userList = [];
        isLoading = true;
      });
    }
    await initUser();
    await Future.delayed(Duration(milliseconds: milliseconds),);

    setState(() {
      isLoading = false;
      reachEnd = false;
    });
  }

  @override
  void didChangeDependencies() async {
    getSideData();
    delayedUser(reload: true);
    super.didChangeDependencies();
  }

  List topList = [
    {
      "borderColor": const Color(0xffc0c0c0),
      "textColor": const Color(0xff000000),
      "top": "2",
      "trophy": "assets/img/rank/silver_trophy.png",
    },
    {
      "borderColor": const Color(0xfff7cf65),
      "textColor": const Color(0xff000000),
      "top": "1",
      "trophy": "assets/img/rank/gold_trophy.png",
    },
    {
      "borderColor": const Color(0xffb38853),
      "textColor": const Color(0xff000000),
      "top": "3",
      "trophy": "assets/img/rank/bronze_trophy.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
     print('queryParams: ${"?gender=${gender}"
        "&sort_by=${sort_by}"
        "&start_date=${formatDateQuery(getStartDate())}"
        "&end_date=${formatDateQuery(getEndDate())}"}');
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
          title: Header(
              title: "$rankType Rank",
              backButton: (rankType == "") ? false : true,
              noIcon: true
          )
      ),
      body: SingleChildScrollView(
        controller: parentScrollController,
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              const BackgroundContainer(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Time Section
                    MainWrapper(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: TColor.SECONDARY_BACKGROUND,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var time in timeList)
                                  SizedBox(
                                    width: media.width * 0.3,
                                    child: CustomTextButton(
                                      onPressed: () {
                                        setState(() {
                                          period = time;
                                          initTime();
                                          page = 1;
                                          userList = [];
                                          stopLoading = false;
                                          delayedUser(reload: true);
                                        });
                                      },
                                      style: ButtonStyle(
                                          padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                vertical: 5,)),
                                          backgroundColor: MaterialStateProperty.all<Color?>(
                                              time == period ? TColor.PRIMARY : null),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10)))),
                                      child: Text(time,
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          SizedBox(height: media.height * 0.005,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextButton(
                                onPressed: () async {
                                  if(period == "Week") {
                                    dynamic date = await showDate(context, weekList!);
                                    setState(() {
                                      startDateOfWeek = date["startDate"];
                                      endDateOfWeek = date["endDate"];
                                      setDateRepresent();
                                      delayedUser(reload: true);
                                    });
                                  } else if(period == "Month") {
                                    dynamic date = await showDate(context, monthList!);
                                    setState(() {
                                      startDateOfMonth = date["startDate"];
                                      endDateOfMonth = date["endDate"];
                                      setDateRepresent();
                                      delayedUser(reload: true);
                                    });
                                  } else if(period == "Year") {
                                    dynamic date = await showDate(context, yearList!);
                                    setState(() {
                                      startDateOfYear = date["startDate"];
                                      endDateOfYear = date["endDate"];
                                      setDateRepresent();
                                      delayedUser(reload: true);
                                    });
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 8),
                                    height: media.height * 0.051,
                                    width: media.width * 0.78,
                                    decoration: BoxDecoration(
                                        color: TColor.SECONDARY_BACKGROUND,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomIconButton(
                                          onPressed: (
                                              (period == "Week" && !startDateOfWeek!.isAtSameMomentAs(weekList?[weekList!.length - 1]["startDate"])) ||
                                                  (period == "Month" && !startDateOfMonth!.isAtSameMomentAs(monthList?[monthList!.length - 1]["startDate"])) ||
                                                  (period == "Year" && !startDateOfYear!.isAtSameMomentAs(yearList?[yearList!.length - 1]["startDate"]))
                                          ) ? () {
                                            setState(() {
                                              if(period == "Week") {
                                                startDateOfWeek = startDateOfWeek?.subtract(Duration(days: 7));
                                                endDateOfWeek = endDateOfWeek?.subtract(Duration(days: 7));
                                              } else if(period == "Month") {
                                                startDateOfMonth = DateTime(startDateOfMonth!.year, startDateOfMonth!.month - 1, 1);
                                                endDateOfMonth = DateTime(endDateOfMonth!.year, endDateOfMonth!.month, 1).subtract(Duration(days: 1));
                                              } else if(period == "Year") {
                                                startDateOfYear = DateTime(startDateOfYear!.year - 1, startDateOfYear!.month, startDateOfYear!.day);
                                                endDateOfYear = DateTime(endDateOfYear!.year - 1, endDateOfYear!.month, endDateOfYear!.day);
                                              }
                                              setDateRepresent();
                                              delayedUser(reload: true);
                                            });
                                          } : null,
                                          icon: const Icon(
                                              Icons.arrow_back_ios_rounded),
                                          color: TColor.PRIMARY_TEXT,
                                        ),
                                        Text(
                                          dateRepresent ?? "",
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.NORMAL,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        CustomIconButton(
                                          onPressed: (
                                              (DateTime.now().isAfter(endDateOfWeek!) && (period == "Week")) ||
                                                  (endDateOfMonth != null && DateTime.now().isAfter(endDateOfMonth!) && (period == "Month")) ||
                                                  (endDateOfYear != null && DateTime.now().isAfter(endDateOfYear!) && (period == "Year"))
                                          ) ? () {
                                            setState(() {
                                              if(period == "Week") {
                                                startDateOfWeek = startDateOfWeek?.add(Duration(days: 7));
                                                endDateOfWeek = endDateOfWeek?.add(Duration(days: 7));
                                                dateRepresent = "${formatDate(startDateOfWeek).substring(0, formatDate(startDateOfWeek).length - 5)} - ${formatDate(endDateOfWeek)}";
                                              }
                                              else if(period == "Month") {
                                                startDateOfMonth = DateTime(startDateOfMonth!.year, startDateOfMonth!.month + 1, startDateOfMonth!.day);
                                                endDateOfMonth = DateTime(endDateOfMonth!.year, endDateOfMonth!.month + 1, endDateOfMonth!.day);
                                              } else if(period == "Year") {
                                                startDateOfYear = DateTime(startDateOfYear!.year + 1, startDateOfYear!.month, startDateOfYear!.day);
                                                endDateOfYear = DateTime(endDateOfYear!.year + 1, endDateOfYear!.month, endDateOfYear!.day);
                                              }
                                              setDateRepresent();
                                              delayedUser(reload: true);
                                            });
                                          } : null,
                                          icon: const Icon(
                                              Icons.arrow_forward_ios_rounded),
                                          color: TColor.PRIMARY_TEXT,
                                        )
                                      ],
                                    )),
                              ),
                              CustomTextButton(
                                onPressed: () {
                                  showActionList(context, [
                                    {
                                      "text": "All",
                                      "onPressed": () {
                                        setState(() {
                                          gender = "";
                                        });
                                        delayedUser(reload: true);
                                        Navigator.pop(context);
                                      }
                                    },
                                    {
                                      "text": "Male",
                                      "onPressed": () {
                                        setState(() {
                                          gender = "MALE";
                                        });
                                        delayedUser(reload: true);
                                        Navigator.pop(context);
                                      }
                                    },
                                    {
                                      "text": "Female",
                                      "onPressed": () {
                                        setState(() {
                                          gender = "FEMALE";
                                        });
                                        delayedUser(reload: true);
                                        Navigator.pop(context);
                                      }
                                    },
                                  ], "Filters");
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            vertical: 11, horizontal: 0)),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        TColor.SECONDARY_BACKGROUND),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10)))),
                                child: Icon(
                                  Icons.filter_list_rounded,
                                  color: TColor.PRIMARY_TEXT,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    // Top 3 Section
                    Container(
                      height: media.height * 0.29,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int i = 0; i < 3; i++) ...[
                            Container(
                              margin: (i == 0 || i == 2)
                                  ? const EdgeInsets.only(top: 25)
                                  : const EdgeInsets.all(0),
                              // width: media.width * 0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomTextButton(
                                        onPressed: () {
                                          if(i < userList.length && userList[i] != null) {
                                            Navigator.pushNamed(context, '/user', arguments: {
                                              "id": userList[i].userId,
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                width: 3.0,
                                                color: topList[i]["borderColor"],
                                              )),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: Image.asset(
                                              "assets/img/home/avatar.png",
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: media.width * 0.25,
                                        margin: EdgeInsets.only(
                                            bottom: media.height * 0.16),
                                      ),
                                      // Positioned(
                                      //     bottom: 0,
                                      //     left: media.width * 0.089,
                                      //     child: SvgPicture.asset(
                                      //       // topList[i]["trophy"],
                                      //       "assets/img/rank/bronze_trophy.svg",
                                      //       width: 40,
                                      //       height: 40,
                                      //       fit: BoxFit.cover,
                                      //     )),
                                      Positioned(
                                          bottom: 0,
                                          left: media.width * 0.089,
                                          child: Image.asset(
                                            topList[i]["trophy"],
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          )),
                                      Positioned(
                                        bottom: 23,
                                        child: Center(
                                          child: Text(
                                            '${topList[i]["top"]}',
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: topList[i]["textColor"],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.3,
                                    child: Text(
                                      "${(i < userList.length)
                                          ? userList[i]?.name ?? "Unknown"
                                          : "Unknown"}",
                                      style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: TColor.SECONDARY_BACKGROUND,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${(i < userList.length)
                                              ? "${(userList[i] != null) ? "${userList[i]?.totalDistance}km" : "Unknown"}"
                                              : "Unknown"}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${(i < userList.length)
                                              ? (userList[i] != null)
                                              ? formatTimeDuration(userList[i]?.totalDuration ?? "00:00:00", type: 2)
                                              : "Unknown"
                                              : "Unknown"}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                    SizedBox(height: media.height * 0.04,),
                    ScrollSynchronized(
                      parentScrollController: parentScrollController,
                      child: AthleteTable(
                        participants: userList,
                        tableHeight: media.height - media.height * (rankType == "" ? 0.26 : 0.16),
                        controller: childScrollController,
                        startIndex: 4,
                        distanceOnPressed: () {
                          setState(() {
                            sort_by = "Distance";
                            delayedUser(reload: true);
                            print(sort_by);
                          });
                        },
                        timeOnPressed: () {
                          setState(() {
                            sort_by = "Time";
                            delayedUser(reload: true);
                            print(sort_by);
                          });
                        },
                        isLoading: isLoading,
                        reachEnd: (reachEnd && !stopLoading) ? true : false,
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: (rankType == "") ? Menu(
        buttonClicked: menuButtonClicked,
      ) : null,
    );
  }
}