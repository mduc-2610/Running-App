import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class EventInformationCreateView extends StatefulWidget {

  const EventInformationCreateView({super.key});

  @override
  State<EventInformationCreateView> createState() => _EventInformationCreateViewState();
}

class _EventInformationCreateViewState extends State<EventInformationCreateView> {
  String token = "";
  Color createChallengeButtonState = Color(0xff979797);
  bool eventNameClearButtonState = false;
  bool eventDescriptionClearButtonState = false;

  // Event information data
  DateTime startDate = DateTime.parse("${DateTime.now().toString().split(' ')[0]} 00:00");
  DateTime endDate = DateTime.parse("${DateTime.now().add(const Duration(days: 7)).toString().split(' ')[0]} 23:59");
  String rankingType = "Distance";
  bool contactInformationButtonState = false;
  TextEditingController eventNameTextController = TextEditingController();
  TextEditingController eventDescriptionTextController = TextEditingController();
  TextEditingController contactInformationTextController = TextEditingController();
  TextEditingController distanceCompletionTextController = TextEditingController();
  TextEditingController timeCompletionTextController = TextEditingController();
  TextEditingController hoursTextController = TextEditingController();
  TextEditingController minutesTextController = TextEditingController();
  String completionGoal = "";

  // Event feature data
  String competition = "";
  String sportType = "";

  // Event advanced option data
  String privacy = "Public";
  Map<String, dynamic> regulations = {
    "min_distance": "1",
    "max_distance": "100",
    "max_avg_pace": "15:00",
    "min_avg_pace": "4:00",
  };

  bool totalAccumulatedDistanceButtonState = false;
  bool totalMoneyDonatedButtonState = false;
  double? donatedMoneyExchange;

  void initCompletionGoal() {
    distanceCompletionTextController.text = "30";
    hoursTextController.text = "8";
    minutesTextController.text = "30";

    completionGoal = (rankingType == "Distance")
        ? distanceCompletionTextController.text
        : '${hoursTextController.text}:${minutesTextController.text}';

    print('Completion goal: ${completionGoal}');
  }

  void createChallenge() async {
    completionGoal = (rankingType == "Distance")
        ? int.parse(distanceCompletionTextController.text).toString()
        : '${hoursTextController.text}:${minutesTextController.text}';

    final event = CreateEvent(
      name: eventNameTextController.text,
      description: eventDescriptionTextController.text,
      contactInformation: contactInformationButtonState ? contactInformationTextController.text : null,
      startedAt: startDate.toString(),
      endedAt: endDate.toString(),
      completionGoal: completionGoal,
      competition: convertChoice(competition),
      rankingType: convertChoice(rankingType),
      sportType: convertChoice(sportType),
      privacy: convertChoice(privacy),
      regulations: regulations,
      totalAccumulatedDistance: totalAccumulatedDistanceButtonState,
      totalMoneyDonated: totalMoneyDonatedButtonState,
    );
    print(event);

    final data = await callCreateAPI('activity/event', event.toJson(), token);
    await deleteAllPreferences();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/event_detail', arguments: {
      "id": data["id"]
    });
  }

  void checkFormData() {
    setState(() {
      print('event name text: ${eventNameTextController.text.isNotEmpty}');
      createChallengeButtonState =
        (eventNameTextController.text.isNotEmpty &&
          eventDescriptionTextController.text.isNotEmpty)
          ? TColor.PRIMARY : TColor.BUTTON_DISABLED;
    });
  }

  void getProvider() {
    setState(() {
      final advancedOptionProvider = Provider.of<EventAdvancedOptionCreateProvider>(context);
      privacy = advancedOptionProvider.privacy ?? "Public";
      regulations = advancedOptionProvider.regulations ?? {
        "min_distance": "1",
        "max_distance": "100",
        "max_avg_pace": "15:00",
        "min_avg_pace": "4:00",
      };
      totalAccumulatedDistanceButtonState = advancedOptionProvider.totalAccumulatedDistance ?? false;
      totalMoneyDonatedButtonState = advancedOptionProvider.totalMoneyDonated ?? false;
      donatedMoneyExchange = advancedOptionProvider.donatedMoneyExchange;
      final featureProvider = Provider.of<EventFeatureCreateProvider>(context);
      competition = featureProvider.competition ?? "Group" ;
      sportType = featureProvider.sportType ?? "Running";
    });
  }

  Future<void> deleteAllPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privacy');
    await prefs.remove('minimumDistance');
    await prefs.remove('maximumDistance');
    await prefs.remove('slowestAvgPace');
    await prefs.remove('fastestAvgPace');
    await prefs.remove('donatedMoneyExchange');
    await prefs.remove('ruleButtonState');
    await prefs.remove('minimumDistanceButtonState');
    await prefs.remove('maximumDistanceButtonState');
    await prefs.remove('slowestAvgPaceButtonState');
    await prefs.remove('fastestAvgPaceButtonState');
    await prefs.remove('totalAccumulatedDistance');
    await prefs.remove('totalMoneyDonated');
  }

  @override
  void initState() {
    super.initState();
    initCompletionGoal();
    distanceCompletionTextController.addListener(() {
      if (distanceCompletionTextController.text.isEmpty) {
        distanceCompletionTextController.text = '0';
      }
    });
    hoursTextController.addListener(() {
      if (hoursTextController.text.isEmpty) {
        hoursTextController.text = '0';
      }
    });
    minutesTextController.addListener(() {
      if (minutesTextController.text.isEmpty) {
        minutesTextController.text = '0';
      }
    });

  }

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  @override
  void didChangeDependencies() {
    getProvider();
    initToken();
    super.didChangeDependencies();
  }
  FocusNode distanceFocusNode = FocusNode();
  FocusNode hoursFocusNode = FocusNode();
  FocusNode minutesFocusNode = FocusNode();

  @override
  void dispose() {
    distanceFocusNode.dispose();
    hoursFocusNode.dispose();
    minutesFocusNode.dispose();
    super.dispose();
  }

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
                          onChanged: (_) => checkFormData(),
                          controller: eventNameTextController,
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
                          showClearButton: eventNameClearButtonState,
                          onClearChanged: () {
                              eventNameTextController.clear();
                              setState(() {
                                eventNameClearButtonState = false;
                                createChallengeButtonState = TColor.BUTTON_DISABLED;
                              });
                          },
                        ),
                        SizedBox(height: media.height * 0.015,),
                        CustomTextFormField(
                          onChanged: (_) => checkFormData(),
                          controller: eventDescriptionTextController,
                          decoration: CustomInputDecoration(
                            hintText: "Event's description *",
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: 4,
                          showClearButton: eventDescriptionClearButtonState,
                          onClearChanged: () {
                            print("ok");
                            eventDescriptionTextController.clear();
                            setState(() {
                              eventDescriptionClearButtonState = false;
                              createChallengeButtonState = TColor.BUTTON_DISABLED;
                            });
                          },
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
                            SwitchButton(
                              switchState: contactInformationButtonState,
                              onChanged: (value) {
                                setState(() {
                                  contactInformationButtonState = value;
                                });
                              },
                            )
                          ],
                        ),
                        if(contactInformationButtonState)...[
                          SizedBox(height: media.height * 0.01,),
                          CustomTextFormField(
                            controller: contactInformationTextController,
                            decoration: CustomInputDecoration(
                              hintText: "Contact information",
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                          ),
                        ],
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
                                      startDate = value!;
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
                                      endDate = value!;
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
                                    "text": "Distance (km)",
                                    "rankingType": "Distance"
                                  },
                                  {
                                    "text": "Total time",
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
                                            x["text"] as String,
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
                                                      if(rankingType == "Distance")...[
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: media.width * 0.25,
                                                              height: 30,
                                                              child: CustomTextFormField(
                                                                controller: distanceCompletionTextController,
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
                                                                clearIcon: false,
                                                                focusNode: distanceFocusNode,
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
                                                        for(var x in [
                                                          {
                                                            "unit": "hours",
                                                            "controller": hoursTextController,
                                                            "focusNode": hoursFocusNode,
                                                            "inpLength": 3,
                                                          },
                                                          {
                                                            "unit": "minutes",
                                                            "controller": minutesTextController,
                                                            "focusNode": minutesFocusNode,
                                                            "inpLength": 2
                                                          }
                                                        ])...[
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: media.width * 0.12,
                                                                height: 30,
                                                                child: CustomTextFormField(
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
                                                                  maxLength: x["inpLength"] as int,
                                                                  clearIcon: false,
                                                                  focusNode: x["focusNode"] as FocusNode
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
              onPressed: (createChallengeButtonState == TColor.BUTTON_DISABLED) ? null : createChallenge,
              child: Text(
                "Create challenge",
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
              background: createChallengeButtonState,
            ),
          )
      ),
    );
  }
}


