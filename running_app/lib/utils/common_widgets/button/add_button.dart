import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/layout/wrapper.dart';
import 'package:running_app/utils/constants.dart';

class AddButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  const AddButton({
    required this.text,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return
    //   SizedBox(
    //   width: 65,
    //   height: 65,
    //   child: FloatingActionButton(
    //     backgroundColor: TColor.PRIMARY,
    //     // style: ButtonStyle(
    //     //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //     //     RoundedRectangleBorder(
    //     //       borderRadius: BorderRadius.circular(50),
    //     //     )
    //     //   ),
    //     //   backgroundColor: MaterialStateProperty.all<Color?>(
    //     //     TColor.PRIMARY
    //     //   )
    //     // ),
    //     onPressed: () {
    //       print("clicked");
    //     },
    //     child: Icon(
    //       Icons.add,
    //       color: TColor.PRIMARY_TEXT,
    //     ),
    //   ),
    // );
      Wrapper(
          child: Container(
            width: media.width,
            margin: EdgeInsets.fromLTRB(media.height * 0.01, 15, media.height * 0.01, media.width * 0.025),
            child: CustomMainButton(
              horizontalPadding: 0,
              verticalPadding: 16,
              borderWidth: 2,
              borderWidthColor: TColor.PRIMARY,
              background: Colors.transparent,
              onPressed: onPressed,
              child: Text(
                text ?? "",
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
            ),
          )
      );
  }
}
