import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomStack(
        children: [
          MainWrapper(
            child: Column(
              children: [
                Header(title: "Notification", noIcon: true),
                SizedBox(height: media.height * 0.015,),

                Column(
                  children: [
                    for(int i = 0; i < 11; i++)...[
                      CustomTextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: TColor.BORDER_COLOR),
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/img/community/ptit_logo.png",
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                              SizedBox(width: media.width * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: media.width * 0.8,
                                    child: Text(
                                      "You 've just completed an activity",
                                      style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.NORMAL,
                                        fontWeight: FontWeight.w800
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "04/03 - 10:00",
                                    style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ]
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
