import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    List text = ["About to start: 0", "Ended: 7"];
    return Column(
      children: [
        // Search events section
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
                    hintText: "Search events",
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
              ),
            )
          ],
        ),
        SizedBox(height: media.height * 0.01,),
        // Your event section
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
              color: TColor.SECONDARY_BACKGROUND,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Transform.rotate(
                angle: 270,
                child: SvgPicture.asset(
                  "assets/img/community/calendar.svg",
                  width: media.width * 0.1,
                  height: media.height *  0.1,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: media.width * 0.01,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your events",
                    style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.NORMAL,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    "View your events here",
                    style: TextStyle(
                        color: TColor.DESCRIPTION,
                        fontSize: FontSize.SMALL,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: media.height * 0.01,),
                  Row(
                    children: [
                      for(var x in text)...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                              color: TColor.PRIMARY.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Text(
                            x,
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.SMALL,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        SizedBox(width: media.width * 0.015,),
                      ]
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );

  }
}
