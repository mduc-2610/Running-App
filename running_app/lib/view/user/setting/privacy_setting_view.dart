import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/privacy.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/show_notification.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class PrivacySettingView extends StatefulWidget {
  const PrivacySettingView({super.key});

  @override
  State<PrivacySettingView> createState() => _PrivacySettingViewState();
}

class _PrivacySettingViewState extends State<PrivacySettingView> {
  String userPrivacyChoice = "";
  String activityPrivacyChoice = "";
  String token = "";
  DetailUser? user;
  Privacy? userPrivacy;


  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  void initUserPrivacy() async {
    final data = await callRetrieveAPI(null, null, user?.privacy, Privacy.fromJson, token);
    setState(() {
      userPrivacy = data;
      userPrivacyChoice = PrivacyConvert.REVERSED_CONVERT[userPrivacy?.followPrivacy] ?? "";
      activityPrivacyChoice = PrivacyConvert.REVERSED_CONVERT[userPrivacy?.activityPrivacy] ?? "";
    });
  }

  void updateUserPrivacy() {
    final privacy = UpdatePrivacy(
      followPrivacy: PrivacyConvert.CONVERT[userPrivacyChoice],
      activityPrivacy: PrivacyConvert.CONVERT[activityPrivacyChoice],
    );
    print(privacy);

    final data = callUpdateAPI('account/privacy', userPrivacy?.id, privacy.toJson(), token);
    showNotification(context, 'Notice', "Successfully updated",
        onPressed: () {
          Navigator.pop(context);
        }
    );
  }

  @override
  void didChangeDependencies() {
    getProviderData();
    initUserPrivacy();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(userPrivacyChoice);
    print(activityPrivacyChoice);
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Privacy", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              child: SizedBox(
                height: media.height,
                child: Column(
                  children: [            // User privacy
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Privacy",
                          style: TxtStyle.headSection,
                        ),
                        SizedBox(height: media.height * 0.01,),
                        for(var x in [
                          {
                            "type": "Free to follow",
                            "content": "Anyone can search and free to follow you without your approval. They can view your complete profile page and activity summaries"
                          },
                          {
                            "type": "Request to follow",
                            "content": "Anyone can send you follow request, search for an view certain profile information, and you can apporve who follows you"
                          }
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
                              Radio(
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                value: x["type"] as String,
                                groupValue: userPrivacyChoice,
                                onChanged: (value) {
                                  setState(() {
                                    userPrivacyChoice = value!;
                                  });
                                },
                                fillColor: MaterialStateProperty.all<Color>(
                                    TColor.PRIMARY
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: media.height * 0.01,)
                        ],
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Activity Privacy
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Activity Privacy",
                          style: TxtStyle.headSection,
                        ),
                        SizedBox(height: media.height * 0.01,),
                        for(var x in [
                          {
                            "type": "Public",
                            "content": "Anyone can view your activities. Your activities will be visible on App Event leaderboards"
                          },
                          {
                            "type": "Followers Only",
                            "content": "Only your followers can view your activities. Your activities will be visible on App Event leaderboards. User who do not follow you may be able to view your activity summaries depending on you other privacy settings",
                          },
                          {
                            "type": "Only me",
                            "content": "Your activities are private. Only you can view them. No one will see your activity history, and your activities won't show up on App Event leaderboard or anywhere on the App",
                          }
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
                              Radio(
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                value: x["type"] as String,
                                groupValue: activityPrivacyChoice,
                                onChanged: (value) {
                                  setState(() {
                                    activityPrivacyChoice = value!;
                                  });
                                },
                                fillColor: MaterialStateProperty.all<Color>(
                                    TColor.PRIMARY
                                ),
                              )
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
                    onPressed: updateUserPrivacy,
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
    );
  }
}
