import 'dart:async';

import 'package:flutter/material.dart';
import 'package:running_app/models/account/like.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';


void showUserList(
    BuildContext context,
    List<Like> userList,
    {
      Widget? title
    }
    ) {
  Completer<String> completer = Completer<String>();
  var media = MediaQuery.of(context).size;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context:
    context,
    builder: (BuildContext context) {
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
                                    "id": userList[index].id
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
                                    Text(
                                      "${userList[index].name}",
                                      style: TxtStyle.normalText,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: media.width * 0.22,
                                child: CustomMainButton(
                                  horizontalPadding: 0,
                                  verticalPadding: 8,
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
    },
  );
}