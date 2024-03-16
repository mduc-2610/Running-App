import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/appbar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class AthleteDiscoveryView extends StatelessWidget {
  const AthleteDiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Search", noIcon: true,),
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
                      height: 40,
                      child: CustomTextFormField(
                        decoration: CustomInputDecoration(
                          hintText: "Type a name of athlete here",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Suggestion",
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int i = 0; i < 3; i++)...[
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
                                                "Minh Duc",
                                                style: TextStyle(
                                                    color: TColor.PRIMARY_TEXT,
                                                    fontSize: FontSize.SMALL,
                                                    fontWeight: FontWeight.w800
                                                ),
                                              ),
                                              Text(
                                                "Nho Quan - Ninh Binh",
                                                style: TextStyle(
                                                    color: TColor.DESCRIPTION,
                                                    fontSize: FontSize.SMALL,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: CustomTextButton(
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty.all(
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 0
                                                  )
                                                ),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                                backgroundColor: MaterialStateProperty.all(
                                                  TColor.PRIMARY
                                                )
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "Follow",
                                                style: TextStyle(
                                                  color: TColor.PRIMARY_TEXT,
                                                  fontSize: FontSize.NORMAL,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: media.width * 0.02,),
                                          CustomIconButton(
                                            icon: Icon(
                                                Icons.cancel,
                                              color: TColor.PRIMARY_TEXT,
                                              size: 20,
                                            ),
                                            onPressed: () {},
                                          )
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
                        Text(
                          "People on App",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int i = 0; i < 3; i++)...[
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
                                                "Minh Duc",
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
                                            child: CustomTextButton(
                                              style: ButtonStyle(
                                                  padding: MaterialStateProperty.all(
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 0
                                                      )
                                                  ),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                  ),
                                                  backgroundColor: MaterialStateProperty.all(
                                                      TColor.PRIMARY
                                                  )
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "Follow",
                                                style: TextStyle(
                                                    color: TColor.PRIMARY_TEXT,
                                                    fontSize: FontSize.LARGE,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
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
                    )
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
