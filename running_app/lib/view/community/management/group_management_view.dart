import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class GroupManagementView extends StatefulWidget {
  const GroupManagementView({super.key});

  @override
  State<GroupManagementView> createState() => GroupManagementViewState();
}

class GroupManagementViewState extends State<GroupManagementView> {
  String _showLayout = "Waiting for approval";

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
                            hintText: _showLayout == "Waiting for approval" ? "Search groups" : "Search athletes",
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
                        for (var x in ["Waiting for approval", "Joined"])...[
                          SizedBox(
                            width: media.width * 0.46,
                            height: media.height * 0.07,
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
                    (_showLayout == "Waiting for approval")
                        ? const MemberApproveLayout()
                        : const MemberLayout(layout: "Joined", amount: [1, 2, 10])
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

class MemberApproveLayout extends StatelessWidget {
  const MemberApproveLayout({super.key});

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
                                      child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            color: TColor.PRIMARY,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      borderWidth: 2,
                                      borderWidthColor: TColor.PRIMARY,
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

class MemberLayout extends StatelessWidget {
  final String layout;
  final List amount ;
  const MemberLayout({super.key, required this.layout, required this.amount});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return SizedBox(
      height: media.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                        "Admin",
                        style: TxtStyle.headSection,
                      ),
                      Text(
                        amount[0].toString(),
                        style: TxtStyle.headSection,
                      ),
                    ],
                  ),
                ),
                if(amount[0] == 0)...[
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
                    for(int i = 0; i < amount[0]; i++)...[
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
                                        layout == "Following" ? "Minh Duc" : "Dang Minh Duc",
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.SMALL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomIconButton(
                                  icon: Icon(
                                    Icons.more_horiz_rounded,
                                    color: TColor.PRIMARY_TEXT,
                                  ),
                                  onPressed: () {}
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
                          "Administrator",
                          style: TxtStyle.headSection
                      ),
                      Text(
                          amount[1].toString(),
                          style: TxtStyle.headSection
                      ),
                    ],
                  ),
                ),
                if(amount[1] == 0)...[
                  SizedBox(height: media.height * 0.01,),
                  Center(
                    child: Text(
                      "Empty list",
                      style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.NORMAL,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(int i = 0; i < amount[1]; i++)...[
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
                                        layout == "Following" ? "Minh Duc" : "Dang Minh Duc",
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.SMALL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      child: CustomIconButton(
                                          icon: Icon(
                                            Icons.more_horiz_rounded,
                                            color: TColor.PRIMARY_TEXT,
                                          ),
                                          onPressed: () {}
                                      )
                                  ),
                                ],
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
                          "Members",
                          style: TxtStyle.headSection
                      ),
                      Text(
                          amount[2].toString(),
                          style: TxtStyle.headSection
                      ),
                    ],
                  ),
                ),
                if(amount[2] == 0)...[
                  SizedBox(height: media.height * 0.01,),
                  Center(
                    child: Text(
                      "Empty list",
                      style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.NORMAL,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(int i = 0; i < amount[2]; i++)...[
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
                                        layout == "Following" ? "Minh Duc" : "Dang Minh Duc",
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.SMALL,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      child: CustomIconButton(
                                          icon: Icon(
                                            Icons.more_horiz_rounded,
                                            color: TColor.PRIMARY_TEXT,
                                          ),
                                          onPressed: () {}
                                      )
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
