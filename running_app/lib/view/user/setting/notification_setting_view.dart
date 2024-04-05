import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:running_app/models/account/notification_setting.dart";
import "package:running_app/models/account/user.dart";
import "package:running_app/services/api_service.dart";
import "package:running_app/utils/common_widgets/app_bar.dart";
import "package:running_app/utils/common_widgets/checkbox.dart";
import "package:running_app/utils/common_widgets/header.dart";
import "package:running_app/utils/common_widgets/main_button.dart";
import "package:running_app/utils/common_widgets/main_wrapper.dart";
import "package:running_app/utils/common_widgets/default_background_layout.dart";
import "package:running_app/utils/common_widgets/wrapper.dart";
import "package:running_app/utils/constants.dart";
import "package:running_app/utils/providers/token_provider.dart";
import "package:running_app/utils/providers/user_provider.dart";

class NotificationSettingView extends StatefulWidget {
  const NotificationSettingView({super.key});

  @override
  State<NotificationSettingView> createState() => _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<NotificationSettingView> {
  String token = "";
  DetailUser? user;
  NotificationSetting? userNotificationSetting;

  Map<String, bool?> notifySetting = {};

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  void initUserNotificationSetting() async {
    final data = await callRetrieveAPI(null, null, user?.notificationSetting, NotificationSetting.fromJson, token);
    setState(() {
      userNotificationSetting = data;
      notifySetting = {
        "Finished workout": userNotificationSetting?.finishedWorkout ?? true,
        "Comment": userNotificationSetting?.comment ?? true,
        "Like": userNotificationSetting?.like ?? true,
        "Mentions on activities": userNotificationSetting?.mentionsOnActivities ?? true,
        "Respond to comments": userNotificationSetting?.respondToComments ?? true,
        "New follower": userNotificationSetting?.newFollower ?? true,
        "Following's activity": userNotificationSetting?.followingActivity ?? true,
        "Request to follow": userNotificationSetting?.requestToFollow ?? true,
        "Approved follow request": userNotificationSetting?.approvedFollowRequest ?? true,
        "Pending join requests": userNotificationSetting?.pendingJoinRequests ?? true,
        "Invited to the club": userNotificationSetting?.invitedToClub ?? true,
      };
    });
  }

  @override
  void didChangeDependencies() {
    getProviderData();
    initUserNotificationSetting();
    super.didChangeDependencies();
  }

  void updateNotificationSetting() async {
    final notificationSetting = NotificationSetting(
      finishedWorkout: notifySetting["Finished workout"],
      comment: notifySetting["Comment"],
      like: notifySetting["Like"],
      mentionsOnActivities: notifySetting["Mentions on activities"],
      respondToComments: notifySetting["Respond to comments"],
      newFollower: notifySetting["New follower"],
      followingActivity: notifySetting["Following's activity"],
      requestToFollow: notifySetting["Request to follow"],
      approvedFollowRequest: notifySetting["Approved follow request"],
      pendingJoinRequests: notifySetting["Pending join requests"],
      invitedToClub: notifySetting["Invited to the club"],
    );

    // print(notificationSetting);

    final data = await callUpdateAPI("account/notification-setting", userNotificationSetting?.id, notificationSetting.toJson(), token);
    Navigator.pop(context);
  }

  List settingSection = [
    {
      "name": "Activities",
      "settingList": [
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
        }
      ]
    },
    {
      "name": "Followers",
      "settingList": [
        {
          "type": "New follower",
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
      ]
    },
    {
      "name": "Club",
      "settingList": [
        {
          "type": "Pending join requests",
          "content": "Notify me when there is a request to join the club from a new member"
        },
        {
          "type": "Invited to the club",
          "content": "Notify me I'm invited to a new club"
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Notifications", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: DefaultBackgroundLayout(
            child: Stack(
              children: [
                MainWrapper(
                  child: SizedBox(
                    height: media.height,
                    child: Column(
                      children: [
                        // Activities
                        for(var section in settingSection)...[
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
                              for(var setting in section["settingList"])...[
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
                                            setting["type"] as String,
                                            style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.NORMAL,
                                                fontWeight: FontWeight.w800
                                            ),
                                          ),
                                          Text(
                                            setting["content"] as String,
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
                                    CustomCheckbox(
                                        value: notifySetting[setting["type"]] ?? false,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            notifySetting[setting["type"] ?? ""] = newValue ?? false;
                                          });
                                        }
                                    ),
                                  ],
                                ),
                                SizedBox(height: media.height * 0.01,)
                              ],
                            ],
                          ),
                          SizedBox(height: media.height * 0.02,),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar: Wrapper(
        child: Container(
          margin: EdgeInsets.fromLTRB(media.width * 0.025, 0, media.width * 0.025, media.width * 0.025),
          child: CustomMainButton(
            horizontalPadding: 0,
            onPressed: updateNotificationSetting,
            child: Text(
              "Save",
              style: TextStyle(
                  color: TColor.PRIMARY_TEXT,
                  fontSize: FontSize.LARGE,
                  fontWeight: FontWeight.w800
              ),
            ),
          ),
        )
    )
    );
  }
}
