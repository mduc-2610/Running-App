import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/constants.dart';

class PrivacySettingView extends StatefulWidget {
  const PrivacySettingView({super.key});

  @override
  State<PrivacySettingView> createState() => _PrivacySettingViewState();
}

class _PrivacySettingViewState extends State<PrivacySettingView> {
  String userPrivacy = "Free to follow";
  String activityPrivacy = "Public";
  @override
  Widget build(BuildContext context) {
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
                                groupValue: userPrivacy,
                                onChanged: (value) {
                                  setState(() {
                                    userPrivacy = value!;
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
                                groupValue: activityPrivacy,
                                onChanged: (value) {
                                  setState(() {
                                    activityPrivacy = value!;
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
    );
  }
}
