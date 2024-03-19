import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:running_app/utils/common_widgets/event_box.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/services/api_service.dart';

import 'package:running_app/utils/common_widgets/search_filter.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/constants.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  List<dynamic>? popularEvents;
  List<dynamic>? allEvents;
  String token = "";

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initEvents() async{
    final data1 = await callListAPI('activity/event', Event.fromJson, token, queryParams: "?sort=participants&limit=10");
    final data2 = await callListAPI('activity/event', Event.fromJson, token, queryParams: "?limit=20");
    setState(() {
      popularEvents = data1;
      allEvents = data2;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    initEvents();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    // print('Popular events: $popularEvents');
    // print('All events: $allEvents');
    List text = ["About to start: 0", "Ended: 7"];
    return Column(
      children: [
        // Search events section
        const SearchFilter(hintText: "Search events"),
        SizedBox(height: media.height * 0.01,),

        // Your event section
        CustomTextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/your_event_list');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
                color: TColor.SECONDARY_BACKGROUND,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Transform.rotate(
                  angle: 270,
                  child: SvgPicture.asset(
                    "assets/img/community/calendar.svg",
                    width: media.width * 0.1,
                    height: media.height *  0.1,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: media.width * 0.01,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your events",
                      style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.NORMAL,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    Text(
                      "View your events here",
                      style: TextStyle(
                          color: TColor.DESCRIPTION,
                          fontSize: FontSize.SMALL,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: media.height * 0.01,),
                    Row(
                      children: [
                        for(var x in text)...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                                color: TColor.PRIMARY.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Text(
                              x,
                              style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.SMALL,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          SizedBox(width: media.width * 0.015,),
                        ]
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: media.height * 0.03,),

        // Popular Events
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular events",
              style: TextStyle(
                color: TColor.PRIMARY_TEXT,
                fontSize: 22,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: media.height * 0.01,),
            SizedBox(
              height: media.height * 0.43,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  autoPlayAnimationDuration: const Duration(milliseconds: 100),
                  initialPage: 0,
                  aspectRatio: 1.2,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.16,
                  enableInfiniteScroll: false
                ),

                items: [
                  for(var event in popularEvents ?? [])...[
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: EventBox(event: event,)
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: media.height * 0.02,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "All events",
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/event_list');
                    },
                    child: Text(
                        "See all",
                        style: TextStyle(
                          color: TColor.PRIMARY,
                          fontSize: FontSize.NORMAL,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                  )
                ]
            ),
            // SizedBox(height: media.height * 0.01,),
            SizedBox(
              height: media.height * 0.37,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 10),

                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(var event in allEvents ?? [])...[
                      IntrinsicHeight(
                        child: EventBox(event: event, width: 200,
                        buttonMargin: const EdgeInsets.fromLTRB(12, 0, 12, 12),)
                      ),
                      SizedBox(width: 10,)
                    ]
                  ],
                ),
              ),
            ),
            SizedBox(height: media.height * 0.02,),
          ],
        ),
      ],
    );

  }
}
