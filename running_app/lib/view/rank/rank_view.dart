import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:running_app/models/account/leaderboard.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/athlete_table.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/scroll_synchronized.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_month_year.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  List timeList = ["Week", "Month", "Year"];
  String period = "Week";
  String gender = "";

  DateTime? startDate;
  DateTime? endDate;

  DateTime? startDateOfMonth;
  DateTime? endDateOfMonth;

  DateTime? startDateOfYear;
  DateTime? endDateOfYear;

  String? dateRepresent;

  List<dynamic>? weekList, monthList, yearList;

  List<dynamic>? userList;
  String token = "";

  void initTime() {
    DateTime now = DateTime.now();
    if(period == "Week") {
      weekList = [];
      startDate = startDate ?? now.subtract(Duration(days: now.weekday - 1));
      endDate = endDate ?? startDate!.add(Duration(days: 6));
      dateRepresent = "${formatDate(startDate).substring(0, formatDate(startDate).length - 5)} - ${formatDate(endDate)}";
      DateTime? tmpStartDate = startDate!;
      DateTime? tmpEndDate = endDate!;
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
      return startDate;
    }
    else if (period == "Month") {
      return startDateOfMonth;
    }
    return startDateOfYear;
  }

  DateTime? getEndDate() {
    if(period == "Week") {
      return endDate;
    }
    else if (period == "Month") {
      return endDateOfMonth;
    }
    return endDateOfYear;
  }

  void setDateRepresent() {
    if(period == "Week") {
      dateRepresent = "${formatDate(startDate).substring(0, formatDate(startDate).length - 5)} - ${formatDate(endDate)}";
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

  String formatQuery(DateTime? date) {
    return DateFormat('yyyy-MM-dd').format(date!);
  }

  void initToken() {
    token = Provider.of<TokenProvider>(context).token;
  }

  Future<void> initUser() async {
    _isLoading = true;
    final data = await callListAPI(
        'account/performance/leaderboard',
        Leaderboard.fromJson,
        token,
        queryParams: "?gender=${gender}"
            "&start_date=${formatQuery(getStartDate())}"
            "&end_date=${formatQuery(getEndDate())}"
    );
    setState(() {
      userList = data;
      if (userList!.length >= 2) {
        dynamic temp = userList?[0];
        userList?[0] = userList?[1];
        userList?[1] = temp;

      }
    });
  }
  @override
  void initState() {
    initTime();
    super.initState();
  }
  bool _isLoading = true;

  void loadUser() async {
    setState(() {
      _isLoading = true;
    });
    await initUser();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() async {
    initToken();
    loadUser();
    super.didChangeDependencies();
  }

  List topList = [
    {
      "borderColor": const Color(0xffc0c0c0),
      "textColor": const Color(0xff000000),
      "top": "2",
      "trophy": "assets/img/rank/silver_trophy.svg",
    },
    {
      "borderColor": const Color(0xfff7cf65),
      "textColor": const Color(0xff000000),
      "top": "1",
      "trophy": "assets/img/rank/gold_trophy.svg",
    },
    {
      "borderColor": const Color(0xffb38853),
      "textColor": const Color(0xff000000),
      "top": "3",
      "trophy": "assets/img/rank/bronze_trophy.svg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    print(yearList);
    print('Start date: ${getStartDate()}');
    print('End date: ${getEndDate()}');
    // print(userList?[0].userId);
    // print('Week list: $weekList}');
    // print('Month list: $monthList}');
    // print('Year list: $yearList}');
    var media = MediaQuery.sizeOf(context);
    ScrollController childScrollController = ScrollController();
    ScrollController parentScrollController = ScrollController();

    return Scaffold(
      appBar: const CustomAppBar(
          title: Header(title: "Rank", backButton: false, noIcon: true)
      ),
      body: SingleChildScrollView(
        controller: parentScrollController,
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              const BackgroundContainer(),
              MainWrapper(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Time Section
                    Column(
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
                                        loadUser();
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
                                    startDate = date["startDate"];
                                    endDate = date["endDate"];
                                    setDateRepresent();
                                    loadUser();
                                  });
                                } else if(period == "Month") {
                                  dynamic date = await showDate(context, monthList!);
                                  setState(() {
                                    startDateOfMonth = date["startDate"];
                                    endDateOfMonth = date["endDate"];
                                    setDateRepresent();
                                    loadUser();
                                  });
                                } else if(period == "Year") {
                                  dynamic date = await showDate(context, yearList!);
                                  setState(() {
                                    startDateOfYear = date["startDate"];
                                    endDateOfYear = date["endDate"];
                                    setDateRepresent();
                                    loadUser();
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
                                        onPressed: () {
                                          setState(() async {
                                            if(period == "Week") {
                                              startDate = startDate?.subtract(Duration(days: 7));
                                              endDate = endDate?.subtract(Duration(days: 7));
                                            } else if(period == "Month") {
                                              startDateOfMonth = DateTime(startDateOfMonth!.year, startDateOfMonth!.month - 1, 1);
                                              endDateOfMonth = DateTime(endDateOfMonth!.year, endDateOfMonth!.month, 1).subtract(Duration(days: 1));
                                            } else if(period == "Year") {
                                              startDateOfYear = DateTime(startDateOfYear!.year - 1, startDateOfYear!.month, startDateOfYear!.day);
                                              endDateOfYear = DateTime(endDateOfYear!.year - 1, endDateOfYear!.month, endDateOfYear!.day);
                                            }
                                            setDateRepresent();
                                            loadUser();
                                          });
                                        },
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
                                            (DateTime.now().isAfter(endDate!) && (period == "Week")) ||
                                            (endDateOfMonth != null && DateTime.now().isAfter(endDateOfMonth!) && (period == "Month")) ||
                                            (endDateOfYear != null && DateTime.now().isAfter(endDateOfYear!) && (period == "Year"))
                                        ) ? () {
                                          setState(() async {
                                            if(period == "Week") {
                                              startDate = startDate?.add(Duration(days: 7));
                                              endDate = endDate?.add(Duration(days: 7));
                                              dateRepresent = "${formatDate(startDate).substring(0, formatDate(startDate).length - 5)} - ${formatDate(endDate)}";
                                            }
                                            else if(period == "Month") {
                                              startDateOfMonth = DateTime(startDateOfMonth!.year, startDateOfMonth!.month + 1, startDateOfMonth!.day);
                                              endDateOfMonth = DateTime(endDateOfMonth!.year, endDateOfMonth!.month + 1, endDateOfMonth!.day);
                                            } else if(period == "Year") {
                                              startDateOfYear = DateTime(startDateOfYear!.year + 1, startDateOfYear!.month, startDateOfYear!.day);
                                              endDateOfYear = DateTime(endDateOfYear!.year + 1, endDateOfYear!.month, endDateOfYear!.day);
                                            }
                                            setDateRepresent();
                                            loadUser();
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
                                    "onPressed": () async {
                                      setState(() {
                                        gender = "";
                                      });
                                      loadUser();
                                      Navigator.pop(context);
                                    }
                                  },
                                  {
                                    "text": "Male",
                                    "onPressed": () async {
                                      setState(() {
                                        gender = "MALE";
                                      });
                                      loadUser();
                                      Navigator.pop(context);
                                    }
                                  },
                                  {
                                    "text": "Female",
                                    "onPressed": () async {
                                      setState(() {
                                        gender = "FEMALE";
                                      });
                                      loadUser();
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
                    if(_isLoading)...[
                    ]
                    else...[
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
                                            Navigator.pushNamed(context, '/user', arguments: {
                                              "id": userList?[i].userId,
                                            });
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
                                        Positioned(
                                            bottom: 0,
                                            left: media.width * 0.089,
                                            child: (i == 4)
                                                ? Container(
                                              width: 30,
                                              height: 30,
                                              padding:
                                              const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: topList[i]
                                                ["borderColor"],
                                                borderRadius:
                                                BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${topList[i]["top"]}',
                                                  // textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: topList[i]
                                                      ["textColor"],
                                                      fontSize:
                                                      FontSize.NORMAL,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                              ),
                                            )
                                                : SvgPicture.asset(
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
                                        "${userList?[i]?.name}",
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
                                            "${userList?[i].totalDistance ?? 0}km",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${formatTimeDuration(userList?[i].totalDuration ?? "00:00:00", type: 2)}',
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
                        child: AthleteTable(participants: userList?.sublist(3) ?? [], tableHeight: media.height - media.height * 0.26, controller: childScrollController),
                      )
                    ]
                  ],
                ),
              ),
              if(_isLoading)...[
                Container(
                  width: media.width,
                  height: media.height,
                  // width: media.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        colors: const [Colors.white],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.black,
                      ),
                    ),
                  ),
                )

              ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Menu(),
    );
  }
}
