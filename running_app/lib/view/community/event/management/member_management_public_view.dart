import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class MemberManagementPublicView extends StatefulWidget {
  const MemberManagementPublicView({super.key});

  @override
  State<MemberManagementPublicView> createState() => MemberManagementPublicViewState();
}

class MemberManagementPublicViewState extends State<MemberManagementPublicView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Member management", noIcon: true,),
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
                            hintText: "Search athletes",
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
                    const MemberLayout(layout: "Joined", amount: [1, 0, 0])
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
                                    ),
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
                                    ),
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

