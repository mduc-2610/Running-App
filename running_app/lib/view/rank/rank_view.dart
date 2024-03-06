import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/constants.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  List timeList = ["Day", "Week", "Year"];
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomStack(
        children: [
          BackgroundContainer(),
          MainWrapper(
            child: Column(
              children: [
                Header(title: "Rank", backButton: false, noIcon: true),
                SizedBox(height: media.height * 0.02,),
                // Time Section
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 8
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: TColor.SECONDARY_BACKGROUND,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for(var time in timeList)
                          CustomTextButton(
                            onPressed: () {},
                            child: Text(
                              time,
                              style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.NORMAL,
                                fontWeight: FontWeight.w600,
                              )
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: media.width * 0.1
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all<Color?>(
                                  time == "Day" ? TColor.PRIMARY : null
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              )
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 8
                          ),
                          height: media.height * 0.051,
                          width: media.width * 0.78,
                          decoration: BoxDecoration(
                            color: TColor.SECONDARY_BACKGROUND,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomIconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_back_ios_rounded),
                                color: TColor.PRIMARY_TEXT,
                              ),
                              Text(
                                "4/3 - 10/3/2024",
                                style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.NORMAL,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              CustomIconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                color: TColor.PRIMARY_TEXT,
                              )
                            ],
                          )
                        ),
                        CustomTextButton(
                          onPressed: () {},
                          child: Icon(Icons.filter_list_rounded, color: TColor.PRIMARY_TEXT,),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 11,
                                      horizontal: 0
                                  )
                              ),
                              backgroundColor: MaterialStateProperty.all<Color?>(
                                TColor.SECONDARY_BACKGROUND
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              )
                          ),
                        )
                      ],
                    )
                  ],
                )

                // Top 3 Section

              ],
            )
          ),
          Menu(),
        ],
      )
    );
  }
}
