import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/button/bottom_stick_button.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/button/switch_button.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/view/community/event/utils/provider/event_advanced_option_create_provider.dart';

class EventAdvancedOptionCreateView extends StatefulWidget {
  const EventAdvancedOptionCreateView({super.key});

  @override
  State<EventAdvancedOptionCreateView> createState() => _EventAdvancedOptionCreateViewState();
}

class _EventAdvancedOptionCreateViewState extends State<EventAdvancedOptionCreateView> {
  String privacy = "Public";
  TextEditingController minimumDistanceTextController = TextEditingController();
  TextEditingController maximumDistanceTextController = TextEditingController();
  TextEditingController slowestAvgPaceTextController = TextEditingController();
  TextEditingController fastestAvgPaceTextController = TextEditingController();
  TextEditingController donatedMoneyExchangeTextController = TextEditingController();

  bool ruleButtonState = true;
  Map<String, bool> statsButtonStates = {
    "Minimum Distance": true,
    "Maximum Distance": true,
    "Slowest Avg. Pace": true,
    "Fastest Avg. Pace": true,
  };

  Map<String, bool> advancedDisplayButtonStates = {
    "Total Accumulated Distance": false,
    "Total Money Donated": false,
  };
  double donatedMoneyExchange = 0.5;

  @override
  void initState() {
    super.initState();
    initValues();
  }

  void initValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      privacy = prefs.getString('privacy') ?? "Public";
      minimumDistanceTextController.text =
          prefs.getString('minimumDistance') ?? "1";
      maximumDistanceTextController.text =
          prefs.getString('maximumDistance') ?? "100";
      slowestAvgPaceTextController.text =
          prefs.getString('slowestAvgPace') ?? "15:00";
      fastestAvgPaceTextController.text =
          prefs.getString('fastestAvgPace') ?? "04:00";
      donatedMoneyExchangeTextController.text =
          prefs.getString('donatedMoneyExchange') ?? "";
      ruleButtonState = prefs.getBool('ruleButtonState') ?? true;

      statsButtonStates["Minimum Distance"] =
          prefs.getBool('minimumDistanceButtonState') ?? true;
      statsButtonStates["Maximum Distance"] =
          prefs.getBool('maximumDistanceButtonState') ?? true;
      statsButtonStates["Slowest Avg. Pace"] =
          prefs.getBool('slowestAvgPaceButtonState') ?? true;
      statsButtonStates["Fastest Avg. Pace"] =
          prefs.getBool('fastestAvgPaceButtonState') ?? true;

      advancedDisplayButtonStates["Total Accumulated Distance"] =
          prefs.getBool('totalAccumulatedDistance') ?? false;
      advancedDisplayButtonStates["Total Money Donated"] =
          prefs.getBool('totalMoneyDonated') ?? false;
      donatedMoneyExchange =
          prefs.getDouble('donatedMoneyExchange') ?? 0.5;
    });
  }

  void setProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('minimumDistance', minimumDistanceTextController.text);
    prefs.setString('maximumDistance', maximumDistanceTextController.text);
    prefs.setString('slowestAvgPace', slowestAvgPaceTextController.text);
    prefs.setString('fastestAvgPace', fastestAvgPaceTextController.text);
    prefs.setBool('ruleButtonState', ruleButtonState);
    prefs.setBool('minimumDistanceButtonState', statsButtonStates["Minimum Distance"] ?? true);
    prefs.setBool('maximumDistanceButtonState', statsButtonStates["Maximum Distance"] ?? true);
    prefs.setBool('slowestAvgPaceButtonState', statsButtonStates["Slowest Avg. Pace"] ?? true);
    prefs.setBool('fastestAvgPaceButtonState', statsButtonStates["Fastest Avg. Pace"] ?? true);

    setState(() {
      Provider.of<EventAdvancedOptionCreateProvider>(context, listen: false).setData(
        privacy: privacy,
        regulations: {
          "min_distance": prefs.getBool('minimumDistanceButtonState') == true ? prefs.getString('minimumDistance') : "Unlimited",
          "max_distance": prefs.getBool('maximumDistanceButtonState') == true ? prefs.getString('maximumDistance') : "Unlimited",
          "max_avg_pace": prefs.getBool('slowestAvgPaceButtonState') == true ? prefs.getString('slowestAvgPace') : "Unlimited",
          "min_avg_pace": prefs.getBool('fastestAvgPaceButtonState') == true ? prefs.getString('fastestAvgPace') : "Unlimited",
        },
        totalAccumulatedDistance: false,
        totalMoneyDonated: false,
        donatedMoneyExchange: (advancedDisplayButtonStates["Total Money Donated"] == true) ? 0.5 : null,
      );
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    donatedMoneyExchangeTextController.text = "0.5";
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
                  children: [
                    // Privacy settings section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Privacy settings",
                          style: TxtStyle.headSection,
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
                                        privacy = value ?? "Public";
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
                              style: TxtStyle.headSection,
                            ),
                            SwitchButton(
                              switchState: ruleButtonState,
                              onChanged: (value) {
                                setState(() {
                                  ruleButtonState = value;
                                });
                              },
                            )
                          ],
                        ),
                        // SizedBox(height: media.height * 0.015,),

                        if(ruleButtonState)...[
                          for(var x in [
                            {
                              "text": "Minimum Distance",
                              "unit": "km",
                              "inp_max_length": 3,
                              "controller": minimumDistanceTextController,
                            },
                            {
                              "text": "Maximum Distance",
                              "unit": "km",
                              "inp_max_length": 3,
                              "controller": maximumDistanceTextController,
                            },
                            {
                              "text": "Slowest Avg. Pace",
                              "unit": "/km",
                              "inp_max_length": 5,
                              "controller": slowestAvgPaceTextController,
                            },
                            {
                              "text": "Fastest Avg. Pace",
                              "unit": "/km",
                              "inp_max_length": 5,
                              "controller": fastestAvgPaceTextController,
                            }
                          ])...[
                            Container(
                              padding: const EdgeInsets.only(
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
                                      SwitchButton(
                                        switchState: statsButtonStates[x["text"] as String],
                                        onChanged: (value) {
                                          setState(() {
                                            statsButtonStates[x["text"] as String] = value;
                                          });
                                        },
                                      ),
                                      if(statsButtonStates[x["text"]] == true)...[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: media.width * 0.03
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: media.width * 0.15,
                                                height: 30,
                                                child: CustomTextFormField(
                                                  clearIcon: false,
                                                  controller: x["controller"] as TextEditingController,
                                                  textAlign: TextAlign.center,
                                                  decoration: CustomInputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      borderRadius: BorderRadius.circular(5),
                                                      counterText: ''
                                                  ),
                                                  keyboardType: TextInputType.number,
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
                                      ]
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]
                        ]
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Advanced display section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Advanced display",
                          style: TxtStyle.headSection,
                        ),
                        SizedBox(height: media.height * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var x in [
                              {
                                "type": "Display total accumulated distance",
                                "desc": "Displays the total distance the members/group have accumulated throughout the event",
                                "button": "Total Accumulated Distance",
                              },
                              {
                                "type": "Display total money donated for the event",
                                "desc": "Displays the total amount of money donated by members/groups based on accumulated distance",
                                "button": "Total Money Donated",
                              }
                            ])...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: media.width * 0.8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          x["type"] as String,
                                          style: TextStyle(
                                              color: TColor.PRIMARY_TEXT,
                                              fontSize: FontSize.NORMAL,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        SizedBox(height: media.height * 0.01,),
                                        Text(
                                          x["desc"] as String,
                                          style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SwitchButton(
                                    switchState: advancedDisplayButtonStates[x["button"]] as bool,
                                    onChanged: (value) {
                                      setState(() {
                                        advancedDisplayButtonStates[x["button"] as String] = value;
                                      });
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: media.height * 0.01,),

                              if(x["type"] != "Display total accumulated distance"
                                  && advancedDisplayButtonStates[x["button"] as String] == true)...[
                                Container(
                                  width: media.width * 0.85,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 10
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: TColor.BORDER_COLOR
                                      )
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Exchange:     1km = ",
                                          style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: FontSize.SMALL,
                                          ),
                                        ),
                                        SizedBox(
                                          width: media.width * 0.3,
                                          height: 35,
                                          child: CustomTextFormField(
                                            textAlign: TextAlign.center,
                                            decoration: CustomInputDecoration(
                                                contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 10
                                                ),
                                                borderRadius: BorderRadius.circular(5),
                                                counterText: ''
                                            ),
                                            keyboardType: TextInputType.number,
                                            maxLength: 5,
                                          ),
                                        ),
                                        Text(
                                          "   USD",
                                          style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: FontSize.SMALL,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],

                            ]
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Certificate section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Certificate",
                          style: TxtStyle.headSection,
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
                            padding: const EdgeInsets.symmetric(
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
      bottomNavigationBar: BottomStickButton(
        text: "Save",
        onPressed: setProvider,
      ),
    );
  }
}