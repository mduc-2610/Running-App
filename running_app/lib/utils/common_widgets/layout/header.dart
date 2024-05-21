import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/button/back_button.dart';
import 'package:running_app/utils/common_widgets/button/icon_button.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';

import '../../constants.dart';

class Header extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final String? username;
  final String? avatar;
  final List? iconButtons;
  final bool backButton;
  final bool noIcon;
  final VoidCallback? backButtonOnPressed;
  final argumentsOnPressed;

  const Header({
    this.title,
    this.fontSize,
    this.username,
    this.avatar,
    this.iconButtons,
    this.backButton = true,
    this.noIcon = false,
    this.backButtonOnPressed,
    this.argumentsOnPressed,
    Key? key,
  }) : super(key: key);

  List defaultIconButtons() {
    return [
      {
        "icon": Icons.people_outline,
        "color": TColor.PRIMARY_TEXT,
        "url": '/athlete_discovery',
      },
      {
        "icon": Icons.notifications_none,
        "color": TColor.PRIMARY_TEXT,
        "url": '/notification'
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var buttons = iconButtons ?? defaultIconButtons();
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: media.width * 0.025
      ),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/img/home/background_1.png"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: (noIcon == true && backButton == false) ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
        children: [
          if (title != null) ...[
            if(noIcon == false)...[
            Row(
              children: [
                if (backButton)
                  CustomBackButton(
                    context: context,
                    onPressed: () => backButtonOnPressed,
                    argumentsOnPressed: argumentsOnPressed,
                  ),
                SizedBox(width: media.width * 0.02,),
                Text(
                  "$title",
                  style: TxtStyle.headSectionExtra
                ),
              ],
            )]
            else...[
              if(backButton)
                CustomBackButton(
                    context: context,
                    onPressed: backButtonOnPressed,
                    argumentsOnPressed: argumentsOnPressed,
                ),
            Text(
              "$title",
              style: TxtStyle.headSectionExtra
            )],
          ] else ...[
            CustomTextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0)
                )
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      avatar ?? "",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: media.width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello! ",
                        style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.SMALL,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        width: media.width * 0.6,
                        child: Text(
                          '$username',
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
          Row(
            children: [
              if (!noIcon)...[
                for (var button in buttons)
                  Row(
                    children: [
                      CustomIconButton(
                        onPressed: button["onPressed"] ?? () {
                          Navigator.pushNamed(context, button["url"]);
                        },
                        icon: Icon(button["icon"]),
                        color: button["color"] ?? TColor.PRIMARY_TEXT,
                        iconSize: 30,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0),
                          ),
                        ),
                      ),
                      if (buttons.length % 2 == 0 && buttons.indexOf(button) != buttons.length - 1)
                        SizedBox(width: media.width * 0.015)
                    ],
                  ),
              ] else...[
                if(!(noIcon == true && backButton == false)) const Icon(Icons.abc_outlined, color: Colors.transparent,)
              ]
            ],
          ),
        ],
      ),
    );
  }
}
