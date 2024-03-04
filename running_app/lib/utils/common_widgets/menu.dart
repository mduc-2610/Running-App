import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List menuIcons = [
      {
        "icon": Icons.home_rounded,
        "url": "/home"
      },
      {
        "icon": Icons.people_alt_rounded,
        "url": "/community"
      },
      {
        "icon": Icons.run_circle_rounded,
        "url": "/running"
      },
      {
        "icon": Icons.emoji_events_rounded,
        "url": "/rank"
      },
      {
        "icon": Icons.shopping_bag_rounded,
        "url": "/store"
      },
    ];
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, media.height * 0.02),
                width: media.width * 0.75,
                height: media.height * 0.08,
                decoration: BoxDecoration(
                    color: const Color(0xff313d54),
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                        color: const Color(0xff746cb3),
                        width: 2
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(var icon in menuIcons)
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
              ),
            ],
          ),
        ],
      );
  }
}
