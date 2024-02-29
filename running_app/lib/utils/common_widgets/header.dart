import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/back_button.dart';

import '../constants.dart';

class Header extends StatelessWidget {
  final String? title;
  final String? username;
  const Header({this.title, this.username, super.key});


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title != null ? Row(
          children: [
            CustomBackButton(context: context),
            SizedBox(width: media.width * 0.01,),
            Text(
                "$title",
                style: TextStyle(
                  color: TColor.PRIMARY_TEXT,
                  fontSize: FontSize.LARGE,
                  fontWeight: FontWeight.w900,
                )
            )
          ],
        ) : Row(
          children: [
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.menu),
              color: TColor.PRIMARY_TEXT,
            ),
            Image.asset(
              "assets/img/home/avatar.png",
            ),
            SizedBox(width: media.width * 0.02,),
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
                    )
                )
              ],
            )
          ],
        ),

        Row(
          children: [
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.archive_outlined),
                color: TColor.PRIMARY_TEXT,
                padding: const EdgeInsets.all(0)
            ),
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.notifications_none),
                color: TColor.PRIMARY_TEXT,
                padding: const EdgeInsets.all(0)
            ),
          ],
        )
      ],
    );
  }
}
