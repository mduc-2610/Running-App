import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class Menu extends StatefulWidget {
  final String buttonClicked;
  const Menu({
    required this.buttonClicked,
    super.key
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

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
                (icon["url"] != "/activity_record")
                    ? Navigator.pushReplacementNamed(context, icon["url"], arguments: {
                      "menuButtonState": icon["url"]
                    })
                    : Navigator.pushNamed(context, icon["url"]);
              },
              icon: Icon(icon["icon"]),
              color: (widget.buttonClicked == icon["url"]) ? TColor.THIRD : TColor.DESCRIPTION,
              iconSize: 35,
            )
        ],
      ),
    );
  }
}
