import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/button/bottom_stick_button.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/button/icon_button.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_month_year.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_notification.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class ActivityRecordEditView extends StatefulWidget {
  const ActivityRecordEditView({super.key});

  @override
  State<ActivityRecordEditView> createState() => _ActivityRecordEditViewState();
}

class _ActivityRecordEditViewState extends State<ActivityRecordEditView> {
  bool isLoading = true;
  String selectedValue = "Anyone";
  String token = "";
  String? activityRecordId;
  DetailActivityRecord? activityRecord;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  String? activityPrivacy;
  String? sportType;

  void getData() {
    setState(() {
      Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      token = Provider.of<TokenProvider>(context).token;
      activityRecordId = arguments["id"];
    });
  }

  void initFields() {
    titleTextController.text = activityRecord?.title ?? "";
    descriptionTextController.text = activityRecord?.description ?? "";
    activityPrivacy = activityRecord?.privacy ?? "Anyone";
    sportType = activityRecord?.sportType ?? "Running";
  }

  Future<void> initActivityRecord() async {
    final data = await callRetrieveAPI(
        'activity/activity-record',
        activityRecordId,
        null,
        DetailActivityRecord.fromJson,
        token
    );
    setState(() {
      activityRecord = data;
    });
  }

  void delayedInit() async {
    await initActivityRecord();
    initFields();
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isLoading = false;
    });
  }

  void saveActivity() async {
    final actRecord = UpdateActivityRecord(
      title: titleTextController.text,
      description: descriptionTextController.text,
      privacy: convertChoice(activityPrivacy!)
    );

    print(actRecord);

    final data = await callUpdateAPI(
        'activity/activity-record',
        activityRecord?.id,
        actRecord.toJson(),
        token
    );

    if(data["title"].runtimeType == List<dynamic>) {
      showNotification(context, 'Error', "Title is required");
    }
    else {
      showNotification(context, 'Notice', "Successfully updated activity",
          onPressed: () {
            Navigator.pop(context);
          }
      );
    }
  }

  @override
  void didChangeDependencies() {
    getData();
    delayedInit();
    super.didChangeDependencies();
  }
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
    // 'assets/img/community/ptit_background.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    print(activityRecord);
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Edit Activity", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              if(isLoading == false)...[
                MainWrapper(
                  topMargin: media.height * 0.02,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Activity details section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Activity Details",
                            style: TxtStyle.headSection,
                          ),
                          SizedBox(height: media.height * 0.02,),
                          Row(
                            children: [
                              Text(
                                "Sport",
                                style: TxtStyle.normalText,
                              ),
                              SizedBox(width: media.width * 0.02,),
                              Row(
                                children: [
                                  Icon(
                                    ActIcon.sportTypeIcon[sportType!],
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "${sportType}",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: media.height * 0.01,),

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
                                      "Event's name *",
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
                                "Description:",
                                style: TxtStyle.normalText,
                              ),
                              SizedBox(height: media.height * 0.01,),
                              CustomTextFormField(
                                controller: descriptionTextController,
                                decoration: CustomInputDecoration(
                                  hintText: "Event's description *",
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
                            "Privacy",
                            style: TxtStyle.normalText,
                          ),
                          SizedBox(height: media.height * 0.01,),
                          CustomMainButton(
                            borderWidth: 2,
                            borderWidthColor: TColor.BORDER_COLOR,
                            background: Colors.transparent,
                            horizontalPadding: 25,
                            onPressed: () async {
                              String result = await showChoiceList(context, [
                                "Anyone", "Followers", "Only me"
                              ], title: "Privacy");
                              setState(() {
                                activityPrivacy = result;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$activityPrivacy",
                                  style: TxtStyle.largeTextDesc,
                                ),
                                Transform.rotate(
                                  angle: 90 * 3.14 / 180,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: TColor.DESCRIPTION,
                                    size: 20,
                                  ),
                                )
                              ],
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
                                  height: media.height * ((imageAssets.length > 3) ? 0.42 : 0.17),
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
                      // SizedBox(height: media.height * 0.07,)

                    ],
                  ),
                )
              ]
              else...[
                Loading(
                  backgroundColor: Colors.transparent,
                )
              ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomStickButton(text: "Save", onPressed: saveActivity),
    );
  }
}
