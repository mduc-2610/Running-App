import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/choice_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';

class ClubCreateView extends StatefulWidget {
  const ClubCreateView({super.key});

  @override
  State<ClubCreateView> createState() => _ClubCreateViewState();
}

class _ClubCreateViewState extends State<ClubCreateView> {
  String sportChoice = "Running";
  String organizationChoice = "Sport Club";
  String? privacy = "Public";

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
        title: const Header(title: "Create club", noIcon: true,),
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
                    SizedBox(height: media.height * 0.01,),

                    // Add general information
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "General information",
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                            label: Text(
                              "Club name *",
                              style: TextStyle(
                                color: TColor.DESCRIPTION,
                                fontSize: FontSize.NORMAL,
                              ),
                            )
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: media.height * 0.01,),
                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                            hintText: "Club description *",
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
                        ),
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Club setting section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "General information",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sport type",
                              style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.NORMAL,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: media.height * 0.01,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for(var sport in sportType)...[
                                    ChoiceButton(
                                      text: sport["text"],
                                      icon: sport["icon"] as IconData,
                                      buttonState: (sport["text"] == sportChoice) ? buttonStateClicked : buttonStateUnClicked,
                                      onPressed: () {
                                        setState(() {
                                          sportChoice = sport["text"];
                                        });
                                        print('$sportChoice ${sport["text"]}');
                                      },
                                    ),
                                    SizedBox(width: media.width * 0.02,),
                                  ]
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: media.height * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Organization type",
                              style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.NORMAL,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: media.height * 0.01,),
                            Row(
                              children: [
                                for(var organization in organizationType)...[
                                  ChoiceButton(
                                    text: organization["text"],
                                    buttonState: (organization["text"] == organizationChoice) ? buttonStateClicked : buttonStateUnClicked,
                                    onPressed: () {
                                      setState(() {
                                        organizationChoice = organization["text"];
                                      });
                                      print(organizationChoice);
                                    },
                                  ),
                                  SizedBox(width: media.width * 0.02,),
                                ]
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Privacy settings section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Privacy settings",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var x in [
                              {
                                "mode": "Public",
                                "desc": "Everyone can join the club",
                              },
                              {
                                "mode": "Private",
                                "desc": "Everyone need your approval to join the club"
                              }
                            ])...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        x["mode"] as String,
                                        style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.NORMAL,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Text(
                                        x["desc"] as String,
                                        style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                    value: x["mode"],
                                    groupValue: privacy,
                                    onChanged: (value) {
                                      setState(() {
                                        privacy = value;
                                      });
                                    },
                                    fillColor: MaterialStateProperty.all<Color>(
                                      TColor.PRIMARY
                                    ),
                                  ),
                                ],
                              ),
                              if(x["mode"] == "Public") SizedBox(height: media.height * 0.01,),
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
      bottomNavigationBar: Wrapper(
          child: Container(
            margin: EdgeInsets.fromLTRB(media.width * 0.025, 15, media.width * 0.025, media.width * 0.025),
            child: CustomMainButton(
              horizontalPadding: 0,
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                "Create club",
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
            ),
          )
      ),
    );
  }
}