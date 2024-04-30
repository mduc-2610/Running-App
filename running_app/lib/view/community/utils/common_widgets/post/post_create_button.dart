import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class PostCreateButton extends StatelessWidget {
  final Map<String, dynamic> argumentsOnPressed;

  const PostCreateButton({
    required this.argumentsOnPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return CustomTextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/post_create', arguments: argumentsOnPressed);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12
        ),
        decoration: BoxDecoration(
          // color: TColor.SECONDARY_BACKGROUND,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),

          ]
        ),
        child: Column(
          children: [
            MainWrapper(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/img/community/ptit_logo.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: media.width * 0.02,),
                  Text(
                    "Write a new post?",
                    style: TxtStyle.largeTextDesc,
                  )
                ],
              )
            ),
            SizedBox(height: media.height * 0.02,),

            SeparateBar(width: media.width, height: 1, color: TColor.DESCRIPTION,),

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
                )
            ),
            // SeparateBar(width: media.width, height: 1, color: TColor.SECONDARY_BACKGROUND,),
          ],
        ),
      ),
    );
  }
}
