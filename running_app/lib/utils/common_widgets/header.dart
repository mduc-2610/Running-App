import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/back_button.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';

import '../constants.dart';

class Header extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final String? username;
  final List? iconButtons;
  final bool backButton;
  final bool noIcon;

  const Header({
    this.title,
    this.fontSize,
    this.username,
    this.iconButtons,
    this.backButton = true,
    this.noIcon = false,
    Key? key, // Adding key parameter
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
                  CustomBackButton(context: context),
                SizedBox(width: media.width * 0.02,),
                Text(
                  "$title",
                  style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: fontSize ?? FontSize.LARGE,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            )]
            else...[
              if(backButton)
                CustomBackButton(context: context, paddingRight: 0,),
            Text(
              "$title",
              style: TextStyle(
                color: TColor.PRIMARY_TEXT,
                fontSize: fontSize ?? 22,
                fontWeight: FontWeight.w900,
              ),
            )],
          ] else ...[
            CustomTextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(0)
                )
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/img/home/avatar.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
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
                      Text(
                        '$username',
                        style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.LARGE,
                          fontWeight: FontWeight.w900,
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
