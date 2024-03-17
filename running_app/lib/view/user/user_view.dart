
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
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/search_filter.dart';
import 'package:running_app/utils/common_widgets/stats_box.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  bool _showTotalStatsLayout = true;
  String token = "";
  DetailUser? user;
  Performance? userPerformance;
  Activity? userActivity;

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
    final data = await callRetrieveAPI(null, null, user?.performance, Performance.fromJson, token);
    print(user?.performance);

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
    initUser();
    initToken();
    initUserPerformance();
    initUserActivity();
  }
  
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    List<Product>? productList = userActivity?.products;
    print(userPerformance);
    // print(userActivity);
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
                            Text(
                              user?.username ?? "",
                              style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.LARGE,
                                  fontWeight: FontWeight.w900),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: media.height * 0.005,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/img/home/coin_icon.svg",
                                      width: 15,
                                      height: 15,
                                    ),
                                    Text(
                                      "1200 points",
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.NORMAL,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Text(
                                  " - Starter 7",
                                  style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.SMALL,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
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
                                "url": "/activity",
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
                                  Navigator.pushReplacementNamed(context, x["url"] as String);
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
                          for (var x in ["Total stats", "Backpack"])
                            SizedBox(
                              width: media.width * 0.46,
                              child: CustomTextButton(
                                onPressed: () {
                                  setState(() {
                                    _showTotalStatsLayout = x == "Total stats";
                                  });
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: media.width * 0.07)),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color?>(
                                      // x == "Total stats" ? TColor.PRIMARY : null

                                        x == "Backpack" && _showTotalStatsLayout == false
                                            || x == "Total stats" && _showTotalStatsLayout == true
                                            ? TColor.PRIMARY : null),
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

                      SizedBox(
                        height: media.height * 0.01,
                      ),
                      // Best performance
                      _showTotalStatsLayout ? StatsLayout() : BackpackLayout(productList: productList),
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

class StatsLayout extends StatelessWidget {
  const StatsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const StatsBoxLayout(
              icon: Icons.social_distance,
              iconColor: Color(0xff000000),
              iconBackgroundColor: Color(0xffffffff),
              backgroundColor: Color(0xff232b35),
              firstText: "0",
              secondText: "Total Distance",
              thirdText: " (km)",
              firstTextColor: Color(0xffffffff),
              secondTextColor: Color(0xffcdcdcd),
              layout: 1,
            ),
            SizedBox(
              height: media.height * 0.01,
            ),
            const StatsBoxLayout(
              icon: Icons.speed_rounded,
              iconColor: Color(0xffffffff),
              iconBackgroundColor: Color(0xff6c6cf2),
              backgroundColor: Color(0xffe1e3fd),
              firstText: "0",
              secondText: "Avg. Pace",
              thirdText: " (min/km)",
              firstTextColor: Color(0xff000000),
              secondTextColor: Color(0xff344152),
              layout: 2,
            ),
            SizedBox(
              height: media.height * 0.01,
            ),
            const StatsBoxLayout(
              icon: Icons.monitor_heart_outlined,
              iconColor: Color(0xffffffff),
              iconBackgroundColor: Color(0xfff3af9b),
              backgroundColor: Color(0xfffcefeb),
              firstText: "0",
              secondText: "Avg. Heartbeat",
              thirdText: " (bpm)",
              firstTextColor: Color(0xff000000),
              secondTextColor: Color(0xff344152),
              layout: 2,
            ),
          ],
        ),
        Column(
          children: [
            const StatsBoxLayout(
              icon: Icons.calendar_today_rounded,
              iconColor: Color(0xffffffff),
              iconBackgroundColor: Color(0xfff5c343),
              backgroundColor: Color(0xfffdf3d3),
              firstText: "00",
              secondText: "Active Days",
              firstTextColor: Color(0xff000000),
              secondTextColor: Color(0xff344152),
              layout: 2,
            ),
            SizedBox(
              height: media.height * 0.01,
            ),
            const StatsBoxLayout(
              icon: Icons.access_time_rounded,
              iconColor: Color(0xffffffff),
              iconBackgroundColor: Color(0xff232b35),
              backgroundColor: Color(0xfff4f6f8),
              firstText: "0",
              secondText: "Total Time",
              firstTextColor: Color(0xff000000),
              secondTextColor: Color(0xff344152),
              layout: 1,
            ),
            SizedBox(
              height: media.height * 0.01,
            ),
            const StatsBoxLayout(
              icon: Icons.directions_run_rounded,
              iconColor: Color(0xffffffff),
              iconBackgroundColor: Color(0xff316ff6),
              backgroundColor: Color(0xff6098f8),
              firstText: "0",
              secondText: "Avg. Cadence",
              thirdText: " (spm)",
              firstTextColor: Color(0xffffffff),
              secondTextColor: Color(0xffffffff),
              layout: 2,
            ),
          ],
        )
      ],
    );
  }
}

class BackpackLayout extends StatelessWidget {
  List<Product>? productList;

  BackpackLayout({required this.productList, super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      children: [
        // Search bar
        const SearchFilter(hintText: "Search items"),
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
