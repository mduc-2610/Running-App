import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/bottom_stick_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class ActivityRecordEditView extends StatefulWidget {
  const ActivityRecordEditView({super.key});

  @override
  State<ActivityRecordEditView> createState() => _ActivityRecordEditViewState();
}

class _ActivityRecordEditViewState extends State<ActivityRecordEditView> {
  String selectedValue = "Anyone";

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
                            const Row(
                              children: [
                                Icon(
                                  Icons.directions_run_rounded,
                                  color: Colors.blue,
                                ),
                                Text(
                                  "Running",
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
                          "Activity Privacy",
                          style: TxtStyle.normalText,
                        ),
                        SizedBox(height: media.height * 0.01,),
                        SizedBox(
                          height: 60,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomStickButton(text: "Save"),
    );
  }
}
