import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class ClubListView extends StatefulWidget {
  const ClubListView({super.key});

  @override
  State<ClubListView> createState() => _ClubListViewState();
}

class _ClubListViewState extends State<ClubListView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomStack(
        children: [
          MainWrapper(
            child: Column(
              children: [
                // Header
                const Header(title: "Club", noIcon: true,),
                SizedBox(height: media.height * 0.01,),
                // Search clubs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: media.width * 0.78,
                      height: media.height * 0.05,
                      decoration: BoxDecoration(
                          color: TColor.SECONDARY_BACKGROUND,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: CustomTextFormField(
                        decoration: CustomInputDecoration(
                            hintText: "Search clubs",
                            prefixIcon: Icon(Icons.search, color: TColor.DESCRIPTION),
                            borderSide: 2
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    CustomTextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                vertical: 11,
                                horizontal: 0
                            )
                        ),
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            TColor.SECONDARY_BACKGROUND
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        side: MaterialStateProperty.all(BorderSide(
                          color: TColor.BORDER_COLOR, // Set border color here
                          width: 2.0, // Set border width here
                        )),
                      ),
                      child: Icon(Icons.filter_list_rounded, color: TColor.PRIMARY_TEXT,),
                    )
                  ],
                ),
                SizedBox(height: media.height * 0.01,),
                // All clubs
                SizedBox(
                  height: media.height - media.height * 0.1,
                  child: GridView.count(
                      padding: const EdgeInsets.all(0),
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,

                      crossAxisSpacing: media.width * 0.035,
                      mainAxisSpacing: media.height * 0.01,
                      children: [
                        for(int i = 0; i < 4; i++)
                          CustomTextButton(
                            onPressed: () {},
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: TColor.SECONDARY_BACKGROUND,
                                      border: Border.all(
                                        color: const Color(0xff495466),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: Image.asset(
                                              "assets/img/community/ptit_logo.png",
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: media.height * 0.015,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "PTIT",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: TColor.PRIMARY_TEXT,
                                                  fontSize: FontSize.LARGE,
                                                  fontWeight: FontWeight.w800
                                              ),
                                            ),
                                            // SizedBox(height: media.height * 0.01),
                                            Text(
                                              "Running",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: TColor.DESCRIPTION,
                                                fontSize: FontSize.SMALL,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            // SizedBox(height: media.height * 0.005,),
                                            Text(
                                              "Member: 123123",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: TColor.DESCRIPTION,
                                                fontSize: FontSize.SMALL,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: media.height * 0.01,),
                              
                                        Center(
                                          child: SizedBox(
                                            width: media.width * 0.4, // Set width of the TextButton
                                            height: 35,
                                            child: CustomMainButton(
                                              horizontalPadding: 0,
                                              verticalPadding: 0,
                                              onPressed: () {},
                                              child: Text(
                                                "Join",
                                                style: TextStyle(
                                                    color: TColor.PRIMARY_TEXT,
                                                    fontSize: FontSize.LARGE,
                                                    fontWeight: FontWeight.w800
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                              
                              ),
                            ),
                          ),
                      ]
                  ),
                ),

              ],
            )
          )
        ],
      ),
    );
  }
}
