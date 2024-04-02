import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class EventGroupManagementView extends StatefulWidget {
  const EventGroupManagementView({super.key});

  @override
  State<EventGroupManagementView> createState() => EventGroupManagementViewState();
}

class EventGroupManagementViewState extends State<EventGroupManagementView> {
  String _showLayout = "Approval";

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Group management", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: CustomTextFormField(
                        decoration: CustomInputDecoration(
                            hintText: _showLayout == "Approval" ? "Search groups" : "Search athletes",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20
                            ),
                            prefixIcon: Icon(
                                Icons.search_rounded,
                                color: TColor.DESCRIPTION
                            )
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    SizedBox(height: media.height * 0.015,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var x in ["Approval", "Joined"])...[
                          SizedBox(
                            width: media.width * 0.46,
                            child: CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  _showLayout = x;
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: media.width * 0.07)),
                                  backgroundColor: MaterialStateProperty.all<
                                      Color?>(
                                      _showLayout == x ? TColor.PRIMARY : null),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)))),
                              child: Text(x,
                                style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.NORMAL,
                                  fontWeight: FontWeight.w600,
                                )
                                ,textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ],
                    ),
                    SizedBox(height: media.height * 0.015,),
                    (_showLayout == "Approval")
                        ? const GroupApproveLayout()
                        : const GroupLayout(layout: "Joined", amount: [1, 2, 10])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GroupApproveLayout extends StatelessWidget {
  const GroupApproveLayout({super.key});

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
                  "Group requests",
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
            height: media.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for(int i = 0; i < 30; i++)...[
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
                                      "Event name",
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.SMALL,
                                          fontWeight: FontWeight.w800
                                      ),
                                    ),
                                    Text(
                                      "Dang Minh Duc",
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

class GroupLayout extends StatelessWidget {
  final String layout;
  final List amount ;
  const GroupLayout({super.key, required this.layout, required this.amount});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return SizedBox(
      height: media.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for(int i = 0; i < 30; i++)...[
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    "Event name",
                                    style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  Text(
                                    "Dang Minh Duc",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.SMALL,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            // margin: EdgeInsets.only(right: media.width * 0.01),
                            child: CustomIconButton(
                              onPressed: () {
                                showActionList(
                                  context,
                                    [
                                      {
                                        "text": "Member management",
                                        "onPressed": () {
                                          Navigator.pushNamed(context, '/member_management_private');
                                        }
                                      },
                                      {
                                        "text": "Group management",
                                        "onPressed": () {
                                          Navigator.pushNamed(context, '/group_management');
                                        }
                                      }
                                    ],
                                  ""
                                );
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: TColor.PRIMARY_TEXT,
                                // size: 30,
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: media.height * 0.01,),
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
