import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/social/follow.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';


void showUserList(
    BuildContext context,
    List<UserAbbr> userList_,
    {
      Widget? title,
    }
    ) {
  Completer<String> completer = Completer<String>();
  var media = MediaQuery.of(context).size;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      String token = Provider.of<TokenProvider>(context).token;
      DetailUser? user = Provider.of<UserProvider>(context).user;
      List<Map<String, dynamic>> userList = [];
      userList.addAll(userList_.map((e) => {
        "follow": e,
        "followButtonState": {
          "text": (e.checkUserFollow == null) ? "Follow" : "Unfollow",
          "backgroundColor": (e.checkUserFollow == null) ? TColor.SECONDARY : Colors.transparent,
        }
      }));
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            // height: media.height * 0.7,
            decoration: BoxDecoration(
                color: TColor.PRIMARY_BACKGROUND,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                border:
                Border(top: BorderSide(width: 1, color: TColor.BORDER_COLOR))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(width: 1, color: TColor.BORDER_COLOR))),
                  child: ListTile(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      title: title
                  ),
                ),
                Container(
                  height: media.height * 0.48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MainWrapper(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/user', arguments: {
                                        "id": userList[index]["follow"].id
                                      });
                                    },
                                    child: Row(
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
                                        SizedBox(
                                          width: media.width * 0.55,
                                          child: Text(
                                            " ${userList[index]["follow"].name}",
                                            style: TxtStyle.normalText,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if(user?.id != userList[index]["follow"].id)...[
                                    SizedBox(
                                      width: media.width * 0.25,
                                      child: CustomMainButton(
                                        horizontalPadding: 0,
                                        verticalPadding: 8,
                                        borderWidth: 2,
                                        borderWidthColor: TColor.SECONDARY,
                                        onPressed: () async {
                                          if(userList[index]["followButtonState"]["text"] == "Unfollow") {
                                            print("Check user follow: ${userList[index]["follow"].checkUserFollow}");
                                            await callDestroyAPI(
                                              'social/follow',
                                              userList[index]["follow"].checkUserFollow,
                                              token
                                            );
                                          } else {
                                            Follow follow = Follow(
                                                followerId: getUrlId(user?.activity ?? ""),
                                                followeeId: userList[index]["follow"].actId
                                            );
                                            print(follow.toJson());
                                            final data = await callCreateAPI(
                                                'social/follow',
                                                follow.toJson(),
                                                token
                                            );
                                            userList[index]["follow"].checkUserFollow = data["id"];
                                          }
                                          setState(() {
                                            if(userList[index]["followButtonState"]["text"] == "Unfollow") {
                                              userList[index]["followButtonState"] = {
                                                "text": "Follow",
                                                "backgroundColor": TColor.SECONDARY
                                              };
                                            }
                                            else {
                                              userList[index]["followButtonState"] = {
                                                "text": "Unfollow",
                                                "backgroundColor": Colors.transparent
                                              };
                                            }
                                          });
                                        },
                                        background: userList[index]["followButtonState"]["backgroundColor"],
                                        child: Text(
                                          userList[index]["followButtonState"]["text"],
                                          style: TxtStyle.normalText,
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      );
    },
  );
}