import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/account/leaderboard.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';


class MemberLayout extends StatelessWidget {
  final String layout;
  final List<Leaderboard>? participants;

  const MemberLayout({
    required this.layout,
    required this.participants,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    List sections = [
      {
        "role": "Admin",
        "participants": [],
      },
      {
        "role": "Administrator",
        "participants": [],
      },
      {
        "role": "Members",
        "participants": participants,
      },
    ];
    var media = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          for(var section in sections)...[
            Column(
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
                        section["role"],
                        style: TxtStyle.headSection,
                      ),
                      Text(
                        section["participants"].length.toString(),
                        style: TxtStyle.headSection,
                      ),
                    ],
                  ),
                ),
                if(section["participants"].length == 0)...[
                  SizedBox(height: media.height * 0.01,),
                  Center(
                    child: Text(
                      "Empty list",
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.NORMAL,
                      ),
                    ),
                  )
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(var participant in section["participants"])...[
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      "assets/img/community/ptit_logo.png",
                                      width: 35,
                                      height: 35,
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
                              CustomIconButton(
                                onPressed: () {
                                  showActionList(
                                      context,
                                      [
                                        section["role"] == "Administrator" ? {
                                          "text": "Remove Administrator",
                                          "onPressed": () {

                                          }
                                        } : {
                                          "text": "Set Administrator",
                                          "onPressed": () {

                                          }
                                        },
                                        {
                                          "text": "Follow",
                                          "onPressed": () {

                                          },
                                        },
                                        {
                                          "text": "Block member",
                                          "onPressed": () {

                                          },
                                        },
                                        {
                                          "text": "Remove Member",
                                          "onPressed": () {

                                          }
                                        }
                                      ],
                                      "Options"
                                  );
                                },
                                icon: Icon(
                                  Icons.more_horiz_rounded,
                                  color: TColor.PRIMARY_TEXT,
                                ),
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
            SizedBox(height: media.height * 0.02,),
          ],
        ],
      ),
    );
  }
}
