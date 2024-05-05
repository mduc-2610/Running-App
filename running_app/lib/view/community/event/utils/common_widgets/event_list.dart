import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_box.dart';


class EventList extends StatelessWidget {
  final String eventType;
  final List<dynamic>? events;
  final double? scrollHeight;

  const EventList({
    required this.eventType,
    required this.events,
    required this.scrollHeight,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${eventType} (${events?.length ?? 0})",
          style: TextStyle(
              color: TColor.PRIMARY_TEXT,
              fontSize: FontSize.LARGE,
              fontWeight: FontWeight.w800
          ),
        ),
        SizedBox(height: media.height * 0.02,),
        if(events?.length == 0)...[
          SizedBox(height: media.height * 0.15,),
          Center(child: EmptyListNotification(
            title: "No events found",
            description: "Add your own event now ",
            addButton: true,
            addButtonText: "Create an event",
            onPressed: () {},
          )),
        ]
        else...[
          SizedBox(
            height: scrollHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(var event in events ?? [])...[
                    EventBox(
                      event: event["event"],
                      joined: event["joined"],
                    ),
                    SizedBox(height: media.height * 0.025,),
                  ]
                ],
              ),
            ),
          )
        ]
      ],
    );
  }
}