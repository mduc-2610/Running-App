import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/choice_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ActivityRecordCreateView extends StatefulWidget {
  const ActivityRecordCreateView({super.key});

  @override
  State<ActivityRecordCreateView> createState() => _ActivityRecordCreateViewState();
}

class _ActivityRecordCreateViewState extends State<ActivityRecordCreateView> {
  late double totalDistance;
  late int totalTime;
  late Uint8List image;
  late String pace;
  String token = "";
  DetailUser? user;
  Activity? userActivity;

  String privacy = "Anyone";
  String sportChoice = "Running";

  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  List sportType = [
    {
      "icon": Icons.directions_run_rounded,
      "text": "Running"
    },
    {
      "icon": Icons.directions_walk_rounded,
      "text": "Walking"
    },
    {
      "icon": Icons.directions_bike_rounded,
      "text": "Cycling"
    },
  ];

  List<String> imageAssets = [
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
    'assets/img/community/ptit_background.jpg',
  ];

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
      // userActivity = Provider.of<UserProvider>(context).userActivity;
    });
  }

  void initUserActivity() async {
    final data = await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
    setState(() {
      userActivity = data;
    });
  }

  void getArguments() {
    setState(() {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      totalDistance = arguments["totalDistance"] / 1000;
      totalTime = arguments["totalTime"];
      image = arguments["mapImage"];
      pace = arguments["pace"];
    });
  }

  void saveActivityRecord() async {
    final activity = CreateActivityRecord(
        privacy: convertChoice(privacy),
        distance: double.parse(totalDistance.toStringAsFixed(3)),
        duration: totalTime.toString(),
        sportType: convertChoice(sportChoice),
        title: titleTextController.text,
        description: descriptionTextController.text,
        userId: userActivity?.id,
        completedAt: DateTime.now().toString(),
    );

    print(activity);

    final data = await callCreateAPI(
        'activity/activity-record',
        activity.toJson(),
        token
    );

    Navigator.pushReplacementNamed(context, '/home');

    print("Success: $data");
  }

  @override
  void initState() {
    // getArguments();
    titleTextController.text = '${sportChoice} activity';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getArguments();
    getProviderData();
    initUserActivity();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Save activity", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              Image.memory(
                image,
                width: media.width,
                height: media.height * 0.4,
                fit: BoxFit.cover,
              ),
              MainWrapper(
                topMargin: media.height * 0.02,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Activity type
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: media.height * 0.4,),
                            Text(
                                "Sport",
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5
                          ),
                          width: media.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: TColor.BORDER_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          totalDistance.toStringAsFixed(2),
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.LARGE,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          "Distance (km)",
                                          style: TxtStyle.descSection,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    for(var x in [
                                      {
                                        "figure": durationRepresentation(totalTime),
                                        "type": "Total time"
                                      },
                                      {
                                        "figure": pace,
                                        "type": "Avg. Pace(/km)",
                                      }
                                    ])...[
                                      SizedBox(
                                        width: media.width * 0.45,
                                        child: Column(
                                          children: [
                                            Text(
                                              x["figure"] as String,
                                              style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.LARGE,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              x["type"] as String,
                                              style: TxtStyle.descSection,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(x["type"] == "Total time") SeparateBar(width: 2, height: media.width * 0.1, color: TColor.BORDER_COLOR,)
                                    ]
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    for(var x in [
                                      {
                                        "figure": "-:--",
                                        "type": "Mov. time"
                                      },
                                      {
                                        "figure": "-:--",
                                        "type": "Avg. Mov. Pace(/km)",
                                      }
                                    ])...[
                                      SizedBox(
                                        width: media.width * 0.45,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              x["figure"] as String,
                                              style: TextStyle(
                                                color: TColor.PRIMARY_TEXT,
                                                fontSize: FontSize.LARGE,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              x["type"] as String,
                                              style: TxtStyle.descSection,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(x["type"] == "Mov. time") SeparateBar(width: 2, height: media.width * 0.1, color: TColor.BORDER_COLOR,)
                                    ]
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Activity details section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title:",
                              style: TxtStyle.normalText,
                            ),
                            SizedBox(height: media.height * 0.01,),
                            CustomTextFormField(
                              controller: titleTextController,
                              decoration: CustomInputDecoration(
                                  label: Text(
                                    "A cool title for an excellent activity :\">",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.NORMAL,
                                    ),
                                  )
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                        SizedBox(height: media.height * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TxtStyle.normalText,
                            ),
                            SizedBox(height: media.height * 0.01,),
                            CustomTextFormField(
                              controller: descriptionTextController,
                              decoration: CustomInputDecoration(
                                hintText: "How are your feeling right now? Tell your friend about it",
                              ),
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Activity Privacy section
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Activity Privacy",
                            style: TxtStyle.headSection,
                          ),
                          SizedBox(height: media.height * 0.01,),
                          Text(
                            "Who can see your activity",
                            style: TxtStyle.normalText,
                          ),
                          SizedBox(height: media.height * 0.01,),
                          SizedBox(
                            height: 60,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  privacy = newValue!;
                                });
                              },
                              items: [
                                for(var x in ["Anyone", "Followers", "Only Me"])
                                  DropdownMenuItem(
                                    value: x,
                                    child: Text(
                                      x,
                                      style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.SMALL,
                                      ),
                                    ),
                                  ),
                              ],
                              decoration: CustomInputDecoration(
                                  hintText: "Anyone"
                              ),
                              dropdownColor: Colors.black,

                            ),
                          ),
                        ]
                    ),
                    SizedBox(height: media.height * 0.02,),

                    // Activity Images
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Activity Images",
                          style: TxtStyle.headSection,
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Text(
                          "Add your images to activity (${imageAssets.length}/10)",
                          style: TxtStyle.normalText,
                        ),
                        SizedBox(height: media.height * 0.02,),

                        if(imageAssets.length < 10)...[
                          CustomIconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_a_photo_outlined,
                              color: TColor.PRIMARY,
                              size: 35,
                            ),
                          ),
                          SizedBox(height: media.height * 0.023,),
                        ],

                        if(imageAssets.isNotEmpty)...[
                          SingleChildScrollView(
                            child: SizedBox(
                              height: media.height * ((imageAssets.length > 3) ? 0.33 : 0.17),
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of columns in the grid
                                  crossAxisSpacing: 12.0, // Spacing between columns
                                  mainAxisSpacing: 12.0, // Spacing between rows
                                  // childAspectRatio: 16 / 14
                                ),
                                itemCount: imageAssets.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      // Image widget
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          imageAssets[index],
                                          width: media.width,
                                          height:  media.height * 0.4,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              imageAssets.removeAt(index);
                                              print(imageAssets.length);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ]
                        ]
                    ),
                    SizedBox(height: media.height * 0.07,)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      bottomSheet: Wrapper(
          child: Container(
            margin: EdgeInsets.fromLTRB(media.width * 0.025, 15, media.width * 0.025, media.width * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: media.width * 0.46,
                  child: CustomMainButton(
                    horizontalPadding: 0,
                    verticalPadding: 14,
                    borderRadius: 10,
                    onPressed: () {
                      showActionList(
                        context,
                        [
                          {
                            "text": "Yes",
                            "onPressed": () {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          {
                            "text": "No",
                            "textColor": TColor.WARNING,
                            "onPressed": () {
                              Navigator.pop(context);
                            }
                          }
                        ],
                        "Are you sure to delete this activity ?"
                      );
                    },
                    background: const Color(0xffFDF2F0),
                    child: Text(
                        "Discard activity",
                        style: TxtStyle.headSectionWarning,
                    ),
                  ),
                ),
                SizedBox(
                  width: media.width * 0.46,
                  child: CustomMainButton(
                    horizontalPadding: 0,
                    verticalPadding: 14,
                    borderRadius: 10,
                    onPressed: () {
                      showActionList(
                          context,
                          [
                            {
                              "text": "Save",
                              "onPressed": () {
                                saveActivityRecord();
                              },
                            },
                            {
                              "text": "Close",
                              "onPressed": () {},
                              "textColor": TColor.WARNING,
                            }
                          ],
                          "Are you sure to save this activity ?"
                      );
                    },
                    child: Text(
                        "Save",
                        style: TxtStyle.headSection
                    ),
                  ),
                ),
              ],
            )
          )
      ),
    );
  }
}
