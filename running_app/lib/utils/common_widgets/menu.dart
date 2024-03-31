import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class Menu extends StatelessWidget {

  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List menuIcons = [
      {"icon": Icons.home_rounded, "url": "/home"},
      {"icon": Icons.people_alt_rounded, "url": "/community"},
      {"icon": Icons.run_circle_rounded, "url": "/activity_record"},
      {"icon": Icons.emoji_events_rounded, "url": "/rank"},
      {"icon": Icons.shopping_bag_rounded, "url": "/store"},
    ];
    return Container(
      height: media.height * 0.08,
      decoration: const BoxDecoration(
          color: Color(0xff313d54),
          border: Border(top: BorderSide(width: 1, color: Color(0xff746cb3)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var icon in menuIcons)
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, icon["url"]);
              },
              icon: Icon(icon["icon"]),
              color: TColor.DESCRIPTION,
              iconSize: 35,
            )
        ],
      ),
    );
  }
}
