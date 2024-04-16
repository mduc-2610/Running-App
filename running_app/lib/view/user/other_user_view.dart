
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/performance.dart';

import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/product/product.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_box.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/search_filter.dart';
import 'package:running_app/utils/common_widgets/stats_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class OtherUserView extends StatefulWidget {
  const OtherUserView({Key? key}) : super(key: key);

  @override
  State<OtherUserView> createState() => _OtherUserViewState();
}

class _OtherUserViewState extends State<OtherUserView> {
  String _showLayout = "Total stats";
  String _showStatsType = "All time";
  String token = "";
  String? userId;
  DetailUser? user;
  Performance? userPerformance;
  Activity? userActivity;
  int? points;

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initUserId() {
    setState(() {
      userId = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)["id"];
    });
  }

  void initUser() async {
    final data = await callRetrieveAPI('account', userId, null, DetailUser.fromJson, token);
    setState(() {
      user = data;
    });
  }

  void initUserPerformance() async {
    final data = await callRetrieveAPI(
        null,
        null,
        user?.performance,
        Performance.fromJson,
        token,
        queryParams: "?period=${_showStatsType.toLowerCase()}ly"
    );
    setState(() {
      userPerformance = data;
    });
  }

  void initUserActivity() async {
    final data = await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
    setState(() {
      userActivity = data;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initToken();
    // initUserId();
    // initUser();
    // initUserPerformance();
    // initUserActivity();
  }

  @override
  Widget build(BuildContext context) {
    if(points == null) {
      points = userPerformance?.periodPoints;
    }
    var media = MediaQuery.of(context).size;
    List<Product>? productList = userActivity?.products;
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(
          title: "",
          iconButtons: [
            {
              "icon": Icons.settings_outlined,
              "onPressed": () {
                Navigator.pushNamed(context, '/setting');
              }
            }
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              BackgroundContainer(
                height: media.height * 0.33,
              ),
              MainWrapper(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/img/home/avatar.png",
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: media.width * 0.49,
                                  child: Text(
                                    '${user?.name ?? ""}',
                                    style: TxtStyle.headSection,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: media.height * 0.005,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${idSubstring(user?.id ?? "")} ',
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.SMALL,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "• ${points} points",
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.SMALL,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: media.width * 0.21,
                          child: CustomMainButton(
                            horizontalPadding: 0,
                            verticalPadding: 10,
                            onPressed: () {},
                            background: TColor.SECONDARY,
                            child: Text(
                              "Follow",
                              style: TxtStyle.normalText,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: media.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: media.width * 0.71,
                          height: media.height * 0.19,
                          padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                          decoration: BoxDecoration(
                            color: TColor.SECONDARY_BACKGROUND,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Seasonal Ranking",
                                style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.LARGE,
                                    fontWeight: FontWeight.w900),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Current",
                                    style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Highest",
                                    style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var x in [
                              {
                                "icon": Icons.local_activity_outlined,
                                "color": const Color(0xff2c50f0),
                                "text": "Activities",
                                "url": "/activity_record_list",
                              },
                              {
                                "icon": Icons.people_outline,
                                "color": const Color(0xfff3b242),
                                "text": "Followers",
                                "url": "/follow",
                              }
                            ]) ...[
                              CustomTextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.all(8)),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        TColor.SECONDARY_BACKGROUND),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12)))),
                                onPressed: () {
                                  Navigator.pushNamed(context, x["url"] as String);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconBox(
                                      icon: x["icon"] as IconData,
                                      iconColor: TColor.PRIMARY_TEXT,
                                      iconBackgroundColor: x["color"] as Color,
                                    ),
                                    SizedBox(height: media.height * 0.01,),
                                    Text(
                                      x["text"] as String,
                                      style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.SMALL,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              if (x["text"] == "Activities")
                                SizedBox(
                                  height: media.height * 0.01,
                                )
                            ],
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: media.height * 0.03,
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var x in ["Total stats", "Inventory"])
                            SizedBox(
                              width: media.width * 0.46,
                              child: CustomTextButton(
                                onPressed: () {
                                  setState(() {
                                    _showLayout = x;
                                  });
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: media.width * 0.07)),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color?>(
                                        _showLayout == x ? TColor.PRIMARY : null),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10)))),
                                child: Text(x,
                                    style: TextStyle(
                                      color: TColor.PRIMARY_TEXT,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            )
                        ],
                      ),
                      if(_showLayout == "Total stats")...[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 8
                            ),
                            decoration: BoxDecoration(
                                color: TColor.SECONDARY_BACKGROUND,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Row(
                              children: [
                                for (var x in ["All time", "Week", "Month", "Year"])...[
                                  SizedBox(
                                    // width: media.width * 0.25,
                                    child: CustomTextButton(
                                      onPressed: () {
                                        setState(() {
                                          _showStatsType = x;
                                          initUserPerformance();
                                        });
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: media.width * 0.07)),
                                          backgroundColor: MaterialStateProperty.all<
                                              Color?>(
                                              _showStatsType == x ? TColor.PRIMARY : null),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10)))),
                                      child: Text(x,
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                      ],
                      SizedBox(height: media.height * 0.01,),
                      // Best performance
                      _showLayout == "Total stats"
                          ?
                      Column(
                        children: [
                          StatsLayout(
                            totalDistance: "${userPerformance?.periodDistance}",
                            totalActiveDays: "${userPerformance?.periodActiveDays}",
                            totalAvgPace: "${userPerformance?.periodAvgMovingPace}",
                            totalTime: "${userPerformance?.periodDuration}",
                            totalAvgHeartBeat: "${userPerformance?.periodAvgTotalHeartRate ?? 0}",
                            totalAvgCadence: "${userPerformance?.periodAvgTotalCadence ?? 0}",
                          ),
                          SizedBox(height: media.height * 0.02,),
                          RichText(
                            text: TextSpan(
                                style: TxtStyle.normalTextDesc,
                                children: [
                                  // TextSpan(
                                  //   text: "Avg. Heartbeat",
                                  //   style: TxtStyle.normalText
                                  // ),
                                  // TextSpan(
                                  //   text: " and ",
                                  // ),
                                  TextSpan(
                                      text: "Avg. Cadence",
                                      style: TxtStyle.normalText
                                  ),
                                  TextSpan(
                                      text: " is calculated based on "
                                  ),
                                  TextSpan(
                                      text: "Running",
                                      style: TxtStyle.normalText
                                  ),
                                  TextSpan(
                                      text: " and "
                                  ),
                                  TextSpan(
                                      text: "Walking",
                                      style: TxtStyle.normalText
                                  ),
                                  TextSpan(
                                    text: " activities",
                                  )
                                ]
                            ),
                          )
                        ],
                      ) : InventoryLayout(productList: productList),

                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InventoryLayout extends StatelessWidget {
  final List<Product>? productList;

  const InventoryLayout({required this.productList, super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      children: [
        // Search bar
        SearchFilter(hintText: "Search items"),
        SizedBox(
          height: media.height * 0.015,
        ),

        // Product
        SingleChildScrollView(
          child: SizedBox(
            height: media.height, // Set a specific height
            child: GridView.count(
              padding: const EdgeInsets.all(0),
              crossAxisCount: 2,
              crossAxisSpacing: media.width * 0.03,
              mainAxisSpacing: media.height * 0.016,
              children: [
                for (var product in productList ?? [])
                  CustomTextButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(media.width * 0.025),
                      // width: media.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: TColor.SECONDARY_BACKGROUND,
                        border: Border.all(
                          color: const Color(0xff495466),
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Image.asset(
                                  "assets/img/store/product/air_force_1.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            media.width * 0.18, 5, 0, 0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: TColor.SECONDARY_BACKGROUND
                                              .withOpacity(0.7),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/img/home/coin_icon.svg",
                                              width: 16,
                                              height: 16,
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              "1200",
                                              style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.NORMAL,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: media.height * 0.01),
                          Text(
                            product.brand.name,
                            style: TextStyle(
                              color: TColor.DESCRIPTION,
                              fontSize: FontSize.SMALL,
                            ),
                          ),
                          // SizedBox(height: media.height * 0.005),
                          Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.SMALL,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

              ],

            ),
          ),
        ),
      ],
    );
  }
}
