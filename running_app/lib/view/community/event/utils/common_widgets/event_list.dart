import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_box.dart';


class EventList extends StatelessWidget {
  final String eventType;
  final List<dynamic>? events;
  const EventList({
    required this.eventType,
    required this.events,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventType,
          style: TextStyle(
              color: TColor.PRIMARY_TEXT,
              fontSize: FontSize.LARGE,
              fontWeight: FontWeight.w800
          ),
        ),
        SizedBox(height: media.height * 0.02,),
        if(events?.length == 0)...[

          Center(child: EmptyListNotification(
            title: "No ${eventType} now",
            description: "Add your own event now ",
            addButton: true,
            addButtonText: "Create an event",
            onPressed: () {},
          )),
        ]
        else...[
          SizedBox(
            height: media.height * 0.67,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(var event in events ?? [])...[
                    EventBox(event: event),
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