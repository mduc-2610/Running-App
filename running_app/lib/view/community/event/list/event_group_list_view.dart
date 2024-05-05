import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/group.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/button/icon_button.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class EventGroupListView extends StatefulWidget {
  const EventGroupListView({super.key});

  @override
  State<EventGroupListView> createState() => _EventGroupListViewState();
}

class _EventGroupListViewState extends State<EventGroupListView> {
  String token = "";
  List<Group>? groups;

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void getGroups() {
    setState(() {
      Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      groups = arguments["groups"];
    });
  }

  @override
  void didChangeDependencies() {
    initToken();
    getGroups();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(title: "Group list", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              topMargin: media.height * 0.02,
              bottomMargin: 0,
              child: Column(
                children: [
                  // Notification section
                  if(true)...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: media.width * 0.95,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: TColor.PRIMARY,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    "assets/img/community/athlete_on_fire.png",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 30,
                                        top: 10
                                    ),
                                    child: Image.asset(
                                      "assets/img/community/athlete_trophy.png",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: media.width * 0.02,),
                              SizedBox(
                                width: media.width * 0.6,
                                child: Text(
                                  "Join a group or create a new group to join the event",
                                  style: TxtStyle.normalText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: media.height * 0.02,),

                  // Group in event section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Groups in event",
                        style: TxtStyle.headSection,
                      ),
                      SizedBox(height: media.height * 0.02,),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: media.width * 0.78,
                            height: 45,
                            // height: media.height * 0.05,
                            decoration: BoxDecoration(
                                color: TColor.SECONDARY_BACKGROUND,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: CustomTextFormField(
                              decoration: CustomInputDecoration(
                                  hintText: "Search",
                                  prefixIcon: Icon(Icons.search, color: TColor.DESCRIPTION),
                                  borderSide: 1,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20
                                  )
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          if(true)...[
                            CustomTextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/group_create');
                              },
                              child: Container(
                                  width: 55,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: TColor.PRIMARY,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(
                                    Icons.add_circle,
                                    color: TColor.PRIMARY_TEXT,
                                  )
                              ),
                            )
                          ]
                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),
                      SizedBox(
                        height:  media.height * ((true) ? 0.6 : 0.71),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for(var group in groups ?? [])
                              CustomTextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/event_group_detail', arguments: {
                                    "id": group?.id,
                                    "rank": groups?.indexOf(group) ?? 0
                                  });
                                },
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
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                          SizedBox(width: media.width * 0.03,),
                                          SizedBox(
                                            width: media.width * 0.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${group?.name ?? ""}',
                                                  style: TextStyle(
                                                      color: TColor.PRIMARY_TEXT,
                                                      fontSize: FontSize.SMALL,
                                                      fontWeight: FontWeight.w900
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shield_moon_rounded,
                                                      color: TColor.DESCRIPTION,
                                                    ),
                                                    SizedBox(width: media.width * 0.01,),
                                                    Text(
                                                      // "${group?.name}",
                                                      "Dang Minh Duc",
                                                      style: TxtStyle.descSectionNormal,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.directions_run_rounded,
                                                      color: TColor.DESCRIPTION,
                                                    ),
                                                    SizedBox(width: media.width * 0.01,),
                                                    Text(
                                                      "${group?.numberOfParticipants} ${group?.numberOfParticipants > 1 ? 'members' : 'member'}",
                                                      style: TxtStyle.descSectionNormal,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if(true)...[
                                        CustomTextButton(
                                          onPressed: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 16
                                            ),
                                            decoration: BoxDecoration(
                                              color: TColor.PRIMARY,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              "Choose",
                                              style: TxtStyle.normalText,
                                            ),
                                          ),
                                        )
                                      ]
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
