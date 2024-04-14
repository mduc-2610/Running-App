import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/account/leaderboard.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';


class MemberApprovalLayout extends StatelessWidget {
  final List<Leaderboard>? participants;
  MemberApprovalLayout({
    required this.participants,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Pending join requests",
                  style: TxtStyle.headSection
              ),
              Text(
                  "0",
                  style: TxtStyle.headSection
              ),
            ],
          ),
        ),
        SizedBox(
            height: media.height * 0.69,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for(var participant in participants ?? [])...[
                    CustomTextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: TColor.BORDER_COLOR),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/img/community/ptit_logo.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(width: media.width * 0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${participant?.name ?? ""}',
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.SMALL,
                                          fontWeight: FontWeight.w900
                                      ),
                                    ),
                                    Text(
                                      '${idSubstring(participant?.id) ?? ""}',
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: media.height * 0.01,),
                            Row(
                              children: [
                                SizedBox(
                                    width: media.width * 0.46,
                                    child: CustomMainButton(
                                      horizontalPadding: 0,
                                      verticalPadding: 6,
                                      borderRadius: 10,
                                      onPressed: () {},
                                      background: Colors.transparent,
                                      borderWidth: 2,
                                      borderWidthColor: TColor.PRIMARY,
                                      child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            color: TColor.PRIMARY,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    )
                                ),
                                SizedBox(width: media.width * 0.02,),
                                SizedBox(
                                    width: media.width * 0.46,
                                    child: CustomMainButton(
                                      horizontalPadding: 0,
                                      verticalPadding: 6,
                                      borderRadius: 10,
                                      onPressed: () {},
                                      child: Text(
                                        "Approve",
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]
                ],
              ),
            )
        )
      ],
    );
  }
}

