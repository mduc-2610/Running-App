import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/choice_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/switch_button.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';

class AddEventFeatureView extends StatefulWidget {

  const AddEventFeatureView({super.key});

  @override
  State<AddEventFeatureView> createState() => _AddEventFeatureViewState();
}

class _AddEventFeatureViewState extends State<AddEventFeatureView> {
  String sportChoice = "Running";
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
        title: const Header(title: "Create challenge", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Competition section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Competition",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: media.height * 0.02,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var x in [
                              {
                                "mode": "Group",
                                "icon": Icons.people_alt_rounded,
                                "desc": "Group in the competition will be ranked based on the total achievements of the group members",
                              },
                              {
                                "mode": "Individual",
                                "icon": Icons.person,
                                "desc": "Individual in the competition will be ranked based on their achievements"
                              }
                            ])...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            x["icon"] as IconData,
                                            color: TColor.PRIMARY_TEXT,
                                          ),
                                          SizedBox(width: media.width * 0.02,),
                                          Text(
                                            x["mode"] as String,
                                            style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.NORMAL,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: media.width * 0.85,
                                        child: Text(
                                          x["desc"] as String,
                                          style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                    value: x["mode"] as String,
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
                              SizedBox(height: media.height * 0.02,),
                            ]
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Sport type section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sport type",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
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
                        ),
                        SizedBox(height: media.height * 0.015,),
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),
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
                Navigator.pushNamed(context, '/add_event_information');
              },
              child: Text(
                "Continue",
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

class AddEventInformationView extends StatefulWidget {

  const AddEventInformationView({super.key});

  @override
  State<AddEventInformationView> createState() => _AddEventInformationViewState();
}

class _AddEventInformationViewState extends State<AddEventInformationView> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Create challenge", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        SizedBox(height: media.height * 0.02,),

                        CustomTextButton(
                          onPressed: () {},
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Add cover photo section
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  "assets/img/community/ptit_background.jpg",
                                  height: media.height * 0.2,
                                  width: media.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              CustomTextButton(
                                onPressed: () {},
                                child: Container(
                                    width: media.width * 0.5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 12
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.picture_in_picture_alt_rounded,
                                          color: TColor.PRIMARY_TEXT,
                                        ),
                                        SizedBox(width: media.width * 0.02,),
                                        Text(
                                          "Add Cover",
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.LARGE,
                                              fontWeight: FontWeight.w600
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: media.height * 0.015,),

                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                              label: Text(
                                "Event's name *",
                                style: TextStyle(
                                  color: TColor.DESCRIPTION,
                                  fontSize: FontSize.NORMAL,
                                ),
                              )
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: media.height * 0.015,),
                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                            hintText: "Event's description *",
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
                          "Contact information",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.8,
                              child:
                              Text(
                                "Please leave contact information so that members can contact you when something goes wrong during the event",
                                style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: 14,
                                ),
                              ),
                            ),
                            const SwitchButton()
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start date",
                              style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.NORMAL,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Row(
                              children: [
                                // DateTimeFormField(onChanged: (value){}),
                                // DateTimeFormField(
                                //   decoration: const InputDecoration(
                                //     labelText: 'Enter Date',
                                //   ),
                                //   firstDate: DateTime.now().add(const Duration(days: 10)),
                                //   lastDate: DateTime.now().add(const Duration(days: 40)),
                                //   initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                                //   onChanged: (DateTime? value) {
                                //     selectedDate = value;
                                //   },
                                // ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: media.height * 0.02,),

                        // Advanced button
                        CustomTextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_event_advanced_option');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16
                            ),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                horizontal: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Advanced options",
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.LARGE,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: TColor.PRIMARY_TEXT,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
                "Create challenge",
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

class AddEventAdvancedOption extends StatefulWidget {
  const AddEventAdvancedOption({super.key});

  @override
  State<AddEventAdvancedOption> createState() => _AddEventAdvancedOptionState();
}

class _AddEventAdvancedOptionState extends State<AddEventAdvancedOption> {
  String? privacy = "Public";

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(title: "Create challenge", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
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
                                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
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
                    ),
                    SizedBox(height: media.height * 0.01,),

                    // Rules section
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rules for the valid activity",
                              style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.LARGE,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                            SwitchButton()
                          ],
                        ),
                        // SizedBox(height: media.height * 0.015,),

                        for(var x in [
                          {
                            "text": "Minimum Distance",
                            "unit": "km",
                            "inp_max_length": 3,
                          },
                          {
                            "text": "Maximum Distance",
                            "unit": "km",
                            "inp_max_length": 3,
                          },
                          {
                            "text": "Slowest Avg. Pace",
                            "unit": "/km",
                            "inp_max_length": 4,
                          },
                          {
                            "text": "Fastest Avg. Pace",
                            "unit": "/km",
                            "inp_max_length": 4,
                          }
                        ])...[
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 8
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                              )
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  // width: media.width * 0.8,
                                  child:
                                  Text(
                                    x["text"] as String,
                                    style: TextStyle(
                                      color: TColor.PRIMARY_TEXT,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SwitchButton(),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: media.width * 0.03
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 25,
                                            child: CustomTextFormField(
                                              decoration: CustomInputDecoration(
                                                contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 10
                                                ),
                                                borderRadius: BorderRadius.circular(5),
                                                counterText: ''
                                              ),
                                              keyboardType: TextInputType.text,
                                              // cursorHeight: 15,
                                              maxLines: 1,
                                              maxLength: x["inp_max_length"] as int,
                                            ),
                                          ),
                                          SizedBox(width: media.width * 0.02),
                                          Text(
                                            x["unit"] as String,
                                            style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.NORMAL
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Certificate section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Certificate",
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.LARGE,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Text(
                          "Member complete challenge will receive a certificate as a praise and activity recognition",
                          style: TextStyle(
                              color: TColor.DESCRIPTION,
                              fontSize: 14,
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),

                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: TColor.DESCRIPTION,
                            ),
                            SizedBox(width: media.width * 0.015,),
                            SizedBox(
                              width: media.width * 0.85,
                              child: Text(
                                "Certification will be automatically awarded once the challenge result is confirmed (Up to 24 hours).",
                                style: TextStyle(
                                  color: TColor.DESCRIPTION,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic
                                ),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: media.height * 0.02,),

                        CustomTextButton(
                          onPressed: () {},
                          child: Container(
                            width: media.width * 0.55,
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: TColor.SECONDARY_BACKGROUND,
                              border: Border.all(
                                color: TColor.BORDER_COLOR,
                                width: 2
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  color: TColor.PRIMARY_TEXT,
                                ),
                                SizedBox(width: media.width * 0.015,),
                                Text(
                                  "Create certificate",
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.NORMAL,
                                    fontWeight: FontWeight.w600
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
        ),
      ),
    );
  }
}

