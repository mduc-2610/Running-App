import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/bottom_stick_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController contentTextController = TextEditingController();

  Color postButtonState = TColor.BUTTON_DISABLED;
  bool titleClearButton = false;
  bool contentClearButton = false;

  void checkFormData() {
    setState(() {
      postButtonState =
      (titleTextController.text.isNotEmpty)
          ? TColor.PRIMARY : TColor.BUTTON_DISABLED;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(title: "Create a post", noIcon: true),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              // Author section
              Column(
                children: [
                  MainWrapper(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/img/community/ptit_logo.png",
                            width: 45,
                            height: 45,
                          ),
                        ),
                        SizedBox(width: media.width * 0.02,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: media.width * 0.75,
                              child: Text(
                                'Dang Minh Duc',
                                style: TxtStyle.headSection,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Member',
                                  style: TxtStyle.normalTextDesc,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // Create post section
                  Column(
                    children: [
                      Container(
                        width: media.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                          )
                        ),
                        child: MainWrapper(
                          topMargin: 0,
                          child: Row(
                            children: [
                              Text(
                                "Title: ",
                                style: TxtStyle.normalText,
                              ),
                              SizedBox(
                                width: media.width * 0.8,
                                child: CustomTextFormField(
                                  onChanged: (_) => checkFormData(),
                                  controller: titleTextController,
                                  decoration: CustomInputDecoration(
                                    borderSide: 0,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  keyboardType: TextInputType.text,
                                  showClearButton: titleClearButton,
                                  onClearChanged: () {
                                    titleTextController.clear();
                                    setState(() {
                                      titleClearButton = false;
                                      postButtonState = TColor.BUTTON_DISABLED;
                                    });
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: media.width,
                        height: media.height * 0.5,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                            )
                        ),
                        child: CustomTextFormField(
                          controller: contentTextController,
                          decoration: CustomInputDecoration(
                            hintText: "What do you want to post?",
                            borderSide: 0,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: 100,
                          showClearButton: contentClearButton,
                          onClearChanged: () {
                            contentTextController.clear();
                            setState(() {
                              contentClearButton = false;
                            });
                          }
                        ),
                      ),
                      SizedBox(height: media.height * 0.01,),
                      MainWrapper(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choose an image",
                              style: TxtStyle.largeTextDesc,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.picture_in_picture_alt,
                                  color: TColor.SECONDARY,
                                ),
                                SizedBox(width: media.width * 0.02,),
                                Text(
                                  "Images",
                                  style: TextStyle(
                                      color: TColor.SECONDARY,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Wrapper(
          child: Container(
            width: media.width,
            margin: EdgeInsets.fromLTRB(media.width * 0.025, 15, media.width * 0.025, media.width * 0.025),
            child: CustomMainButton(
              horizontalPadding: 0,
              onPressed: (postButtonState == TColor.BUTTON_DISABLED) ? null : () {},
              background: postButtonState,
              child: Text(
                "Post",
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
