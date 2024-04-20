import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';

class EmptyListNotification extends StatelessWidget {
  final String? title;
  final String? description;
  final bool? addButton;
  final String? addButtonText;
  final VoidCallback? onPressed;
  final double? addButtonWidth;
  final String? image;
  final double? marginTop;
  final Widget? imageWidget;

  const EmptyListNotification({
    this.marginTop,
    this.title,
    this.description,
    this.addButton,
    this.addButtonText,
    this.addButtonWidth,
    this.onPressed,
    this.image,
    this.imageWidget,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
        top: marginTop ?? 0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              if(image == null && imageWidget == null)...[
                Image.asset(
                  "assets/img/community/athlete_on_fire.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 50,
                      top: 25
                  ),
                  child: Image.asset(
                    "assets/img/community/athlete_trophy.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              ]
              else...[
                if(imageWidget == null)...[
                  Image.asset(
                    image!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ] else...[
                  imageWidget!
                ]
              ]
            ],
          ),
          SizedBox(height: media.height * 0.01,),
          if(title != null) ...[
            Text(
              title ?? "",
              style: TxtStyle.headSection,
            ),
            SizedBox(height: media.height * 0.01,),
          ],
          if(description != null)...[
            SizedBox(
              width: media.width * 0.75,
              child: Text(
                description ?? "",
                style: TextStyle(
                  color: TColor.DESCRIPTION,
                  fontSize: FontSize.NORMAL,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: media.height * 0.015,),
          ],
          if(addButton == true)...[
            CustomTextButton(
              onPressed: onPressed ?? () {},
              child: Container(
                width: addButtonWidth ?? media.width * 0.55,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TColor.PRIMARY,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle,
                      color: TColor.PRIMARY_TEXT,
                    ),
                    SizedBox(width: media.width * 0.02,),
                    Text(
                      addButtonText ?? "",
                      style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.NORMAL,
                          fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
