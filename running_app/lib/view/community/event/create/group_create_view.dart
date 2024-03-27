import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/group.dart';
import 'package:running_app/models/activity/user_participation.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class GroupCreateView extends StatefulWidget {
  const GroupCreateView({super.key});

  @override
  State<GroupCreateView> createState() => _GroupCreateViewState();
}

class _GroupCreateViewState extends State<GroupCreateView> {
  String token = "";
  DetailUser? user;
  String? userActivityId;
  String sportChoice = "Running";
  String organizationChoice = "Sport Club";
  String? privacy = "Public";
  Color createGroupButtonState = TColor.BUTTON_DISABLED;
  bool groupNameClearButtonState = false;
  bool groupDescriptionClearButtonState = false;

  TextEditingController groupNameTextController = TextEditingController();
  TextEditingController groupDescriptionTextController = TextEditingController();

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initUser() {
    setState(() {
      user = Provider.of<UserProvider>(context).user;
      userActivityId = getUrlId(user?.activity ?? "");
    });
  }

  void checkFormData() {
    setState(() {
      createGroupButtonState =
      (groupNameTextController.text.isNotEmpty &&
          groupDescriptionTextController.text.isNotEmpty)
          ? TColor.PRIMARY : TColor.BUTTON_DISABLED;
    });
  }

  void createGroup() async {
    final group = CreateGroup(
      name: groupNameTextController.text,
      description: groupDescriptionTextController.text,
      eventId: "1127f7e3-210e-431d-90a7-0788f4070582",
    );
    print(group);
    final data = await callCreateAPI('activity/group', group.toJson(), token);

    final userParticipationGroup = UserParticipationGroup(
      userId: "65146d6d-b3f3-4e8d-a384-407690406021",
      groupId: data["id"],
      isAdmin: true,
    );
    print(userParticipationGroup);

    final data2 = await callCreateAPI(
        'activity/user-participation-group',
        userParticipationGroup.toJson(),
        token
    );
    print(data2);

    // Navigator.pop(context);

  }

  @override void didChangeDependencies() {
    initToken();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List sportType = [
      {
        "icon": Icons.directions_run_rounded,
        "text": "Running"
      },
      {
        "icon": Icons.directions_bike_rounded,
        "text": "Cycling"
      },
      {
        "icon": Icons.pool_rounded,
        "text": "Swimming"
      },
    ];

    List organizationType = [
      {
        "icon": Icons,
        "text": "Sport Club"
      },
      {
        "icon": Icons,
        "text": "Company"
      },
      {
        "icon": Icons,
        "text": "School"
      },
    ];
    Map<String, dynamic> buttonStateClicked = {
      "iconColor": TColor.PRIMARY,
      "backgroundColor": Colors.transparent,
      "borderColor": TColor.PRIMARY,
      "textColor": TColor.PRIMARY,
    };

    Map<String, dynamic> buttonStateUnClicked = {
      "iconColor": TColor.PRIMARY_TEXT,
      "backgroundColor": TColor.SECONDARY_BACKGROUND,
      "borderColor": TColor.BORDER_COLOR,
      "textColor": TColor.PRIMARY_TEXT,
    };

    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Create group", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              CustomTextButton(
                onPressed: () {},
                child: Stack(
                  children: [
                    // Add cover photo section
                    Image.asset(
                      "assets/img/community/ptit_background.jpg",
                      height: media.height * 0.2,
                      width: media.width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: TColor.PRIMARY
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: TColor.PRIMARY_TEXT,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              MainWrapper(
                topMargin: media.height * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add image section
                    CustomTextButton(
                      onPressed: () {},
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/img/community/ptit_logo.png",
                                width: 100,
                                height: 100,
                              )
                          ),
                          const SizedBox(
                            height: 120,
                            width: 100,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: TColor.PRIMARY
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: TColor.PRIMARY_TEXT,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Add general information
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          onChanged: (_) => checkFormData(),
                          controller: groupNameTextController,
                          decoration: CustomInputDecoration(
                              label: Text(
                                "Group name *",
                                style: TextStyle(
                                  color: TColor.DESCRIPTION,
                                  fontSize: FontSize.NORMAL,
                                ),
                              )
                          ),
                          keyboardType: TextInputType.text,
                          showClearButton: groupNameClearButtonState,
                          onClearChanged: () {
                            groupNameTextController.clear();
                            setState(() {
                              groupNameClearButtonState = false;
                              createGroupButtonState = TColor.BUTTON_DISABLED;
                            });
                          },
                        ),
                        SizedBox(height: media.height * 0.01,),
                        CustomTextFormField(
                          onChanged: (_) => checkFormData(),
                          controller: groupDescriptionTextController,
                          decoration: CustomInputDecoration(
                            hintText: "Describe your group here *",
                            // label: Text(
                            //   "Club description *",
                            //   style: TextStyle(
                            //     color: TColor.DESCRIPTION,
                            //     fontSize: FontSize.NORMAL,
                            //   ),
                            // ),
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: 4,
                          showClearButton: groupDescriptionClearButtonState,
                          onClearChanged: () {
                            groupDescriptionTextController.clear();
                            setState(() {
                              groupDescriptionClearButtonState = false;
                              createGroupButtonState = TColor.BUTTON_DISABLED;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: media.height * 0.01,),
                    Text(
                      "(Each account can create only one group)",
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.NORMAL,
                        fontStyle: FontStyle.italic
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrapper(
          child: Container(
            margin: EdgeInsets.fromLTRB(media.width * 0.025, 15, media.width * 0.025, media.width * 0.025),
            child: CustomMainButton(
              horizontalPadding: 0,
              onPressed: (createGroupButtonState == TColor.BUTTON_DISABLED) ? null : createGroup,
              child: Text(
                "Create a group",
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
              background: createGroupButtonState,
            ),
          )
      ),
    );
  }
}