import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

void showNotification(
    BuildContext context,
    String title,
    String description,
    {VoidCallback? onPressed}
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        backgroundColor: TColor.SECONDARY_BACKGROUND,
        title: Text(
          title,
          style: TxtStyle.headSection,
        ),
        content: Text(
          description,
          style: TxtStyle.normalTextDesc,
        ),
        actions: <Widget>[
          CustomTextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if(onPressed != null) {
                onPressed.call();
              }
            },
            child: Text(
              'OK',
              style: TxtStyle.normalText,
            ),
          ),
        ],
      );
    },
  );
}


void showNotificationDecision(
    BuildContext context,
    String title,
    String description,
    String deny,
    String accept,
    {VoidCallback? onPressed1, onPressed2}
    ) {
  var media = MediaQuery.sizeOf(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        backgroundColor: TColor.SECONDARY_BACKGROUND,
        title: Text(
          title,
          style: TxtStyle.headSection,
          textAlign: TextAlign.center,
        ),
        content: Text(
          description,
          style: TxtStyle.normalTextDesc,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(var x in [
                    {
                      "text": deny,
                      "color": TColor.WARNING,
                      "background": TColor.BACKGROUND_WARNING,
                      "onPressed": () {
                        Navigator.pop(context);
                        onPressed1?.call();
                      },
                    },
                    {
                      "text": accept,
                      "color": TColor.PRIMARY_TEXT,
                      "background": TColor.PRIMARY,
                      "onPressed": () {
                        Navigator.pop(context);
                        onPressed2?.call();
                      },
                    }
                  ])...[
                    SizedBox(
                      width: media.width * 0.3,
                      child: CustomMainButton(
                        verticalPadding: 8,
                        horizontalPadding: 0,
                        borderRadius: 8,
                        onPressed: x["onPressed"] as VoidCallback,
                        child: Text(
                          x["text"] as String,
                          style: TextStyle(
                            color: x["color"] as Color,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        background: x["background"] as Color,
                      ),
                    ),
                    if(x["text"] == deny) SizedBox(width: media.width * 0.03,),
                  ]
                ],
              ),
              SizedBox(height: media.height * 0.01,),
            ],
          ),
        ],
      );
    },
  );
}