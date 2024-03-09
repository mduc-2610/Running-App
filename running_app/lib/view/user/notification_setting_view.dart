import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/switch_button.dart';
import 'package:running_app/utils/constants.dart';

class NotificationSettingView extends StatelessWidget {
  const NotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: media.height * 1.15,
          child: CustomStack(
            backgroundHeight: media.height * 1.15,
            children: [
              MainWrapper(
                child: SizedBox(
                  height: media.height,
                  child: Column(
                    children: [
                      // Header
                      Header(title: "Notifications", noIcon: true,),
                      SizedBox(height: media.height * 0.02,),
          
                      // Activities
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Activities",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          SizedBox(height: media.height * 0.01,),
                          for(var x in [
                            {
                              "type": "Finished workout",
                              "content": "Notify me when my activity is ready"
                            },
                            {
                              "type": "Comment",
                              "content": "Notify when someone comments on my activity"
                            },
                            {
                              "type": "Like",
                              "content": "Notify me when a friend likes my activity"
                            },
                            {
                              "type": "Mentions on activities",
                              "content": "Notify me when someone mentions me in an activity comment"
                            },
                            {
                              "type": "Respond to comments",
                              "content": "Notify me when the owner responds to comments"
                            },
                          ])...[
          
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: media.width * 0.75,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        x["type"] as String,
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      Text(
                                        x["content"] as String,
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          // overflow: TextOverflow.ellipsis
                                        ),
                                        // maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SwitchButton()
                              ],
                            ),
                            SizedBox(height: media.height * 0.01,)
                          ],
                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),
          
                      // Followers
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          SizedBox(height: media.height * 0.01,),
                          for(var x in [
                            {
                              "type": "New Follower",
                              "content": "Notify me when someone follows me"
                            },
                            {
                              "type": "Following's activity",
                              "content": "Notify me when my following post activities"
                            },
                            {
                              "type": "Request to follow",
                              "content": "Notify when someone request to follow me"
                            },
                            {
                              "type": "Approved follow request",
                              "content": "Notify me when someone accepts a follow-up request from me"
                            },
                          ])...[
          
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: media.width * 0.75,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        x["type"] as String,
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      Text(
                                        x["content"] as String,
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          // overflow: TextOverflow.ellipsis
                                        ),
                                        // maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SwitchButton()
                              ],
                            ),
                            SizedBox(height: media.height * 0.01,)
                          ],
                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),

                      // Clubs
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Club",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          SizedBox(height: media.height * 0.01,),
                          for(var x in [
                            {
                              "type": "Pending join requests",
                              "content": "Notify me when there is a request to join the club from a new member"
                            },
                            {
                              "type": "Invited to the club",
                              "content": "Notify me I'm invited to a new club"
                            },
                          ])...[

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: media.width * 0.75,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        x["type"] as String,
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      Text(
                                        x["content"] as String,
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          // overflow: TextOverflow.ellipsis
                                        ),
                                        // maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SwitchButton()
                              ],
                            ),
                            SizedBox(height: media.height * 0.01,)
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: media.height * 0.025,
                left: media.width * 0.025,
                right: media.width * 0.025,
                child: SizedBox(
                  width: media.width,
                  child: CustomMainButton(
                      horizontalPadding: 0,
                      onPressed: () {
          
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.BUTTON,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
