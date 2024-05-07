import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/constants.dart';

void showJoinClub(
    BuildContext context,
    String avatar,
    String title,
    String description,
    String agree,
    {
      VoidCallback? agreeOnPressed
    }
    ) {
  var media = MediaQuery.sizeOf(context);
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(12),
        height: 280,
        decoration: BoxDecoration(
            color: TColor.PRIMARY_BACKGROUND,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            border: Border(
                top: BorderSide(width: 1, color: TColor.BORDER_COLOR)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                if(avatar != "")...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      avatar,
                      width: 60,
                      height: 60,
                    )
                  )
                ],
                SizedBox(height: media.height * 0.01,),

                Text(
                  title,
                  style: TxtStyle.headSection,
                ),
                SizedBox(height: media.height * 0.01,),

                Text(
                  description,
                  style: TxtStyle.normalTextDesc,
                )
              ],
            ),
            SizedBox(height: media.height * 0.015,),

            Column(
              children: [
                SizedBox(
                  width: media.width * 0.95,
                  child: CustomMainButton(
                    onPressed: () {
                      agreeOnPressed?.call();
                      Navigator.pop(context);
                    },
                    horizontalPadding: 0,
                    verticalPadding: 16,
                    child: Text(
                      agree,
                      style: TxtStyle.normalText,
                    ),
                  ),
                ),
                SizedBox(
                  width: media.width * 0.95,
                  child: CustomMainButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    horizontalPadding: 0,
                    verticalPadding: 16,
                    background: Colors.transparent,
                    child: Text(
                      "Cancel",
                      style: TxtStyle.normalText,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    },
  );
}


