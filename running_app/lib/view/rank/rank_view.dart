import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/appbar.dart';
import 'package:running_app/utils/common_widgets/athlete_table.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  List timeList = ["Day", "Week", "Year"];
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
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: Header(title: "Rank", backButton: false, noIcon: true)
        ),
        body: DefaultBackgroundLayout(
          child: Stack(
            children: [
              const BackgroundContainer(borderRadius: 0,),
              MainWrapper(
                  child: Column(
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
                              CustomTextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: media.width * 0.1)),
                                    backgroundColor: MaterialStateProperty.all<Color?>(
                                        time == "Day" ? TColor.PRIMARY : null),
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
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
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
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.arrow_back_ios_rounded),
                                    color: TColor.PRIMARY_TEXT,
                                  ),
                                  Text(
                                    "4/3 - 10/3/2024",
                                    style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.NORMAL,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  CustomIconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    color: TColor.PRIMARY_TEXT,
                                  )
                                ],
                              )),
                          CustomTextButton(
                            onPressed: () {},
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
                  // Top 3 Section
                  SizedBox(
                    height: media.height * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < 3; i++) ...[
                          Container(
                            margin: (i == 0 || i == 2)
                                ? const EdgeInsets.only(top: 20)
                                : const EdgeInsets.all(0),
                            width: media.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
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
                                Text(
                                  "Minh Duc",
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.SMALL,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Pro 1",
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: TColor.SECONDARY_BACKGROUND,
                                  ),
                                  child: Text(
                                    "139.04km   14h20m",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: TColor.PRIMARY_TEXT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]
                      ],
                    ),
                  )
                ],
              )),
              MainWrapper(
                leftMargin: 0,
                rightMargin: 0,
                topMargin: media.height * 0.45,
                child: AthleteTable(),
              ),
            ],
          ),
        ),
      bottomNavigationBar: const Menu(),
    );
  }
}
