import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/seperate_bar.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class ClubView extends StatefulWidget {
  const ClubView({super.key});

  @override
  State<ClubView> createState() => _ClubViewState();
}

class _ClubViewState extends State<ClubView> {
  List clubStat = [
    {
      "type": "Members",
      "amount": "10",
    },
    {
      "type": "Week activites",
      "amount": "10",
    },
    {
      "type": "Posts",
      "amount": "10",
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      children: [

        SizedBox(height: media.height * 0.005,),
        // View all clubs
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/club_list');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                          "All clubs",
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      SizedBox(height: media.height * 0.005,),
                      Text(
                        "View all Clubs here!!!",
                        style: TextStyle(
                            color: TColor.DESCRIPTION,
                            fontSize: FontSize.SMALL,
                            fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: TColor.PRIMARY_TEXT
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(
              TColor.SECONDARY_BACKGROUND
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20
              )
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              )
            )
          ),
        ),
        SizedBox(height: media.height * 0.01),

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
                    borderSide: 0
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            CustomTextButton(
              onPressed: () {},
              child: Icon(Icons.filter_list_rounded, color: TColor.PRIMARY_TEXT,),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
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
                  width: 1.0, // Set border width here
                )),
              ),
            )
          ],
        ),
        SizedBox(height: media.height * 0.03,),

        // Your clubs
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Clubs joined",
              style: TextStyle(
                color: TColor.PRIMARY_TEXT,
                fontSize: FontSize.LARGE,
                fontWeight: FontWeight.w800
              ),

            ),
            SizedBox(height: media.height * 0.015,),
            for(int i = 0; i < 3; i++)...[

              Column(
                children: [
                  CustomTextButton(
                    onPressed: () {},
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(0),
                          width: media.width,
                          height: media.height * 0.15,
                          decoration: BoxDecoration(
                            color: TColor.PRIMARY,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          height: media.height * 0.15,
                          decoration: BoxDecoration(
                              color: TColor.SECONDARY_BACKGROUND,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(90),
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              border: Border.all(
                                color: TColor.PRIMARY,
                                width: 1.0,
                              )),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      "assets/img/community/ptit_logo.png",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(width: media.width * 0.02,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PTIT Runner",
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.NORMAL,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        "Running",
                                        style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: FontSize.SMALL,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: media.height * 0.02,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int i = 0; i < 3; i++) ...[
                                    Row(
                                      children: [
                                        if (i != 0) ...[
                                          SeparateBar(
                                              width: 2, height: media.height * 0.04),
                                          SizedBox(width: media.width * 0.03)
                                        ],
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              clubStat[i]["type"],
                                              style: TextStyle(
                                                  color: TColor.DESCRIPTION,
                                                  fontSize: FontSize.SMALL,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              clubStat[i]["amount"],
                                              style: TextStyle(
                                                  color: TColor.PRIMARY_TEXT,
                                                  fontSize: FontSize.NORMAL,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ]
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: TColor.PRIMARY_TEXT,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(height: media.height * 0.015,)
            ]
          ],
        )
      ],
    );
  }
}
