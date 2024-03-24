import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:provider/provider.dart';

import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/bottom_stick_button.dart';
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
import 'package:running_app/view/community/event/utils/provider/event_advanced_option_create_provider.dart';
import 'package:running_app/view/community/event/utils/provider/event_feature_create_provider.dart';

class EventFeatureCreateView extends StatefulWidget {
  const EventFeatureCreateView({super.key});

  @override
  State<EventFeatureCreateView> createState() => _EventFeatureCreateViewState();
}

class _EventFeatureCreateViewState extends State<EventFeatureCreateView> {
  String sportChoice = "Running";
  String competitionType = "Group";

  void setProvider() {
    Provider.of<EventFeatureCreateProvider>(context, listen: false).setData(sportType: sportChoice, competition: competitionType);
    Navigator.pushNamed(context, '/event_information_create');
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
                          style: TxtStyle.headSection
                        ),
                        SizedBox(height: media.height * 0.02,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var x in [
                              {
                                "competitionType": "Group",
                                "icon": Icons.people_alt_rounded,
                                "desc": "Group in the competition will be ranked based on the total achievements of the group members",
                              },
                              {
                                "competitionType": "Individual",
                                "icon": Icons.person,
                                "desc": "Individual in the competition will be ranked based on their achievements"
                              }
                            ])...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                            x["competitionType"] as String,
                                            style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.NORMAL,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: media.height * 0.005,),
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
                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                    value: x["competitionType"] as String,
                                    groupValue: competitionType,
                                    onChanged: (value) {
                                      setState(() {
                                        competitionType = value!;
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
                          style: TxtStyle.headSection
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
                                  buttonState: (sport["text"] == sportChoice) ? BtnState.buttonStateClicked : BtnState.buttonStateUnClicked,
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
              onPressed: setProvider,
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

class EventInformationCreateView extends StatefulWidget {

  const EventInformationCreateView({super.key});

  @override
  State<EventInformationCreateView> createState() => _EventInformationCreateViewState();
}

class _EventInformationCreateViewState extends State<EventInformationCreateView> {
  DateTime? selectedDate;
  String rankingType = "Distance (km)";
  String competition = "";
  String sportType = "";

  String privacy = "Public";
  Map<String, dynamic>? regulations;
  bool? totalAccumulatedDistance;
  bool? totalMoneyDonated;
  double? donatedMoneyExchange;

  void getProvider() {
    setState(() {
      final advancedOptionProvider = Provider.of<EventAdvancedOptionCreateProvider>(context);
      privacy = advancedOptionProvider.privacy ?? "Public";
      regulations = advancedOptionProvider.regulations;
      totalAccumulatedDistance = advancedOptionProvider.totalAccumulatedDistance;
      totalMoneyDonated = advancedOptionProvider.totalMoneyDonated;
      donatedMoneyExchange = advancedOptionProvider.donatedMoneyExchange;

      final featureProvider = Provider.of<EventFeatureCreateProvider>(context);
      competition = featureProvider.competition ?? "Group" ;
      sportType = featureProvider.sportType ?? "Running";
    });
  }

  @override
  void initState() {
    super.initState();
    rankingType = "Distance (km)";
  }

  @override
  void didChangeDependencies() {
    getProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    print('${regulations}  ${sportType}');
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
                              fontWeight: FontWeight.w900
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
                          style: TxtStyle.headSection
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
                        SizedBox(height: media.height * 0.01,),
                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                            hintText: "Contact information",
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                SizedBox(height: media.height * 0.01,),
                                Container(
                                  alignment: Alignment.center,
                                  width: media.width * 0.65,
                                  // height: 70,
                                  child: DateTimeFormField(
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.SMALL,
                                    ),
                                    decoration: CustomInputDecoration(
                                      suffixIcon: Icon(
                                        Icons.calendar_today_rounded,
                                        color: TColor.DESCRIPTION,
                                      ),
                                    //   hintText: "${DateTime.now().toString().split(' ')[0]} 00:00",
                                    //   hintStyle: TextStyle(
                                    //   color: TColor.DESCRIPTION,
                                    //   fontSize: FontSize.SMALL,
                                    // ),
                                        label: Text(
                                        "${DateTime.now().toString().split(' ')[0]} 00:00",
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.SMALL,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20
                                      ),
                                    ),

                                    materialDatePickerOptions: const MaterialDatePickerOptions(),
                                    firstDate: DateTime.now().add(const Duration(days: 10)),
                                    lastDate: DateTime.now().add(const Duration(days: 365)),
                                    initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                                    onChanged: (DateTime? value) {
                                      selectedDate = value;
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: media.height * 0.01,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End date",
                                  style: TextStyle(
                                      color: TColor.PRIMARY_TEXT,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: media.height * 0.01,),
                                SizedBox(
                                  width: media.width * 0.65,
                                  // height: 50,
                                  child: DateTimeFormField(
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.SMALL,
                                    ),
                                    decoration: CustomInputDecoration(
                                      suffixIcon: Icon(
                                        Icons.calendar_today_rounded,
                                        color: TColor.DESCRIPTION,
                                      ),
                                      label: Text(
                                        "${DateTime.now().add(const Duration(days: 7)).toString().split(' ')[0]} 23:59",
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.SMALL,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20
                                      ),
                                    ),

                                    firstDate: DateTime.now().add(const Duration(days: 10)),
                                    lastDate: DateTime.now().add(const Duration(days: 40)),
                                    initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                                    onChanged: (DateTime? value) {
                                      selectedDate = value;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: media.height * 0.02,),

                        // Ranking section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ranking",
                              style: TxtStyle.headSection
                            ),
                            SizedBox(height: media.height * 0.01,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for(var x in [
                                  {
                                    "rankingType": "Distance (km)",
                                  },
                                  {
                                    "rankingType": "Total time"
                                  }
                                ])...[
                                  Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            x["rankingType"] as String,
                                            style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.NORMAL,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          Radio(
                                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                            value: x["rankingType"] as String,
                                            groupValue: rankingType,
                                            onChanged: (value) {
                                              setState(() {
                                                rankingType = value!;
                                              });
                                            },
                                            fillColor: MaterialStateProperty.all<Color>(
                                                TColor.PRIMARY
                                            ),
                                          ),
                                        ],
                                      ),

                                      if(rankingType == x["rankingType"])...[
                                        SizedBox(height: media.height * 0.01,),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                              horizontal: 12
                                          ),
                                          decoration: BoxDecoration(
                                              color: TColor.SECONDARY_BACKGROUND,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                width: 1,
                                                color: TColor.BORDER_COLOR,
                                              )
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Challenge goal",
                                                style: TextStyle(
                                                    color: TColor.PRIMARY_TEXT,
                                                    fontSize: FontSize.NORMAL,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(height: media.height * 0.01,),
                                              Text(
                                                "Groups/Members hitting the goal will be recognized for completing the challenge",
                                                style: TextStyle(
                                                  color: TColor.DESCRIPTION,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: media.height * 0.01,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Completion goal",
                                                    style: TextStyle(
                                                        color: TColor.PRIMARY_TEXT,
                                                        fontSize: FontSize.NORMAL,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      if(rankingType == "Distance (km)")...[
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: media.width * 0.25,
                                                              height: 30,
                                                              child: CustomTextFormField(
                                                                textAlign: TextAlign.center,
                                                                decoration: CustomInputDecoration(
                                                                    contentPadding: EdgeInsets.zero,
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    counterText: ''
                                                                ),
                                                                keyboardType: TextInputType.number,
                                                                // cursorHeight: 15,
                                                                maxLines: 1,
                                                                maxLength: 7,
                                                              ),
                                                            ),
                                                            SizedBox(width: media.width * 0.01),
                                                            Text(
                                                              "km",
                                                              style: TextStyle(
                                                                color: TColor.DESCRIPTION,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ]
                                                      else...[
                                                        for(x in [
                                                          {
                                                            "unit": "hours"
                                                          },
                                                          {
                                                            "unit": "minutes"
                                                          }
                                                        ])...[
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: media.width * 0.12,
                                                                height: 30,
                                                                child: CustomTextFormField(
                                                                  textAlign: TextAlign.center,
                                                                  decoration: CustomInputDecoration(
                                                                      contentPadding: EdgeInsets.zero,
                                                                      borderRadius: BorderRadius.circular(5),
                                                                      counterText: ''
                                                                  ),
                                                                  keyboardType: TextInputType.number,
                                                                  // cursorHeight: 15,
                                                                  maxLines: 1,
                                                                  maxLength: 7,
                                                                ),
                                                              ),
                                                              SizedBox(width: media.width * 0.01),
                                                              Text(
                                                                x["unit"] as String,
                                                                style: TextStyle(
                                                                  color: TColor.DESCRIPTION,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(width: media.width * 0.01),
                                                            ],
                                                          ),
                                                        ]
                                                      ]
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ]
                                    ],
                                  ),
                                  SizedBox(height: media.height * 0.02,),
                                ]
                              ],
                            )
                          ],
                        ),

                        // Advanced button section
                        CustomTextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/event_advanced_option_create');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
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

class EventAdvancedOptionCreateView extends StatefulWidget {
  const EventAdvancedOptionCreateView({super.key});

  @override
  State<EventAdvancedOptionCreateView> createState() => _EventAdvancedOptionCreateViewState();
}

class _EventAdvancedOptionCreateViewState extends State<EventAdvancedOptionCreateView> {
  String? privacy = "Public";
  TextEditingController minimumDistanceTextController = TextEditingController();
  TextEditingController maximumDistanceTextController = TextEditingController();
  TextEditingController slowestAvgPaceTextController = TextEditingController();
  TextEditingController fastestAvgPaceTextController = TextEditingController();
  TextEditingController donatedMoneyExchangeTextController = TextEditingController();

  bool totalAccumulatedDistance = false;
  bool totalMoneyDonated = false;
  double donatedMoneyExchange = 0.5;

  void setProvider() {
    setState(() {
      Provider.of<EventAdvancedOptionCreateProvider>(context, listen: false).setData(
        privacy: privacy,
        regulations: {
          "min_distance": minimumDistanceTextController.text != "" ? minimumDistanceTextController.text : "Unlimited",
          "max_distance": maximumDistanceTextController.text != "" ? maximumDistanceTextController.text : "Unlimited",
          "max_avg_pace": fastestAvgPaceTextController.text != "" ? fastestAvgPaceTextController.text : "Unlimited",
          "min_avg_pace": slowestAvgPaceTextController.text != "" ? slowestAvgPaceTextController.text : "Unlimited",
        },
        totalAccumulatedDistance: false,
        totalMoneyDonated: false,
        donatedMoneyExchange: (totalMoneyDonated) ? 0.5 : null,
      );
    });
    Navigator.pushNamed(context, '/event_information_create');
  }

  @override
  Widget build(BuildContext context) {
    minimumDistanceTextController.text = "1";
    maximumDistanceTextController.text = "100";
    slowestAvgPaceTextController.text = "15:00";
    fastestAvgPaceTextController.text = "04:00";
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
                              style: TxtStyle.headSection,
                            ),
                            const SwitchButton()
                          ],
                        ),
                        // SizedBox(height: media.height * 0.015,),

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
                            "inp_max_length": 4,
                            "controller": slowestAvgPaceTextController,
                          },
                          {
                            "text": "Fastest Avg. Pace",
                            "unit": "/km",
                            "inp_max_length": 4,
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
                                    const SwitchButton(),
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
                                              // controller: x["controller"] as TextEditingController,
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
                                  ],
                                )
                              ],
                            ),
                          ),
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
                              },
                              {
                                "type": "Display total money donated for the event",
                                "desc": "Displays the total amount of money donated by members/groups based on accumulated distance"
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
                                  const SwitchButton()
                                ],
                              ),
                              SizedBox(height: media.height * 0.01,),

                              if(x["type"] != "Display total accumulated distance")...[
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

