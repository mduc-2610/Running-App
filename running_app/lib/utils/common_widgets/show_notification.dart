import 'package:flutter/material.dart';
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
            onPressed: onPressed ?? () {
              Navigator.pop(context);
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