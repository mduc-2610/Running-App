import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class EventBox extends StatelessWidget {
  final EdgeInsets? buttonMargin;
  final double? width;
  final String? buttonText;
  const EventBox({
    this.buttonMargin,
    this.width,
    this.buttonText,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return CustomTextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/event_detail');
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: TColor.SECONDARY_BACKGROUND,
          boxShadow: [
            BShadow.customBoxShadow
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)
                  ),
                  child: Image.asset(
                    "assets/img/community/ptit_background.jpg",
                    width: media.width,
                    height: media.height * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: media.height * 0.01,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    "On-Energize your Dreams",
                    style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.NORMAL,
                        fontWeight: FontWeight.w700
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  // vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: media.height * 0.01,),
                    for(var x in [
                      {
                        "icon": Icons.calendar_today_rounded,
                        "text": "Ends in: 7 days",
                      },
                      {
                        "icon": Icons.people_alt_outlined,
                        "text": "1,812",
                      }
                    ])...[
                      Row(
                        children: [
                          Icon(
                            x["icon"] as IconData,
                            color: TColor.DESCRIPTION,
                          ),
                          SizedBox(width: media.width * 0.02,),
                          Text(
                            x["text"] as String,
                            style: TextStyle(
                              color: TColor.DESCRIPTION,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: media.height * 0.01,),
                    ],
                  ],
                )
            ),
            Container(
              width: media.width,
              margin: buttonMargin ?? const EdgeInsets.fromLTRB(12, 0, 12, 20),
              child: CustomMainButton(
                horizontalPadding: 0,
                verticalPadding: 12,
                onPressed: () {},
                child: Text(
                  buttonText ?? "Join now",
                  style: TextStyle(
                      color: TColor.PRIMARY_TEXT,
                      fontSize: FontSize.LARGE,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
