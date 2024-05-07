import 'package:flutter/material.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/user_participation.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_box.dart';


class EventList extends StatefulWidget {
  final String eventType;
  final List<dynamic>? events;
  final double? scrollHeight;
  final String token;
  final DetailUser? user;
  final bool checkJoin;
  final ValueChanged<bool> checkJoinChange;
  final VoidCallback reload;

  const EventList({
    required this.eventType,
    required this.events,
    required this.scrollHeight,
    required this.token,
    required this.user,
    required this.checkJoin,
    required this.checkJoinChange,
    required this.reload,
    super.key
  });

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.eventType} (${widget.events?.length ?? 0})",
          style: TextStyle(
              color: TColor.PRIMARY_TEXT,
              fontSize: FontSize.LARGE,
              fontWeight: FontWeight.w800
          ),
        ),
        SizedBox(height: media.height * 0.02,),
        if(widget.events?.length == 0)...[
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
            height: widget.scrollHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(var event in widget.events ?? [])...[
                    EventBox(
                      eventDetailOnPressed: () async {
                        Map<String, dynamic> result = await Navigator.pushNamed(context, '/event_detail', arguments: {
                          "id": event["event"]?.id,
                          "userInEvent": event["joinButtonState"],
                        }) as Map<String, dynamic>;
                        widget.checkJoinChange(result["checkJoin"]);
                        if(widget.checkJoin) {
                          print("CHECK JOIN $widget.checkJoin");
                          // delayedInit(reload: true);
                          widget.reload();
                        }
                      },
                      event: event["event"],
                      joined: event["joinButtonState"],
                      joinOnPressed: (value) async {
                        if(!event["joinButtonState"]) {
                          UserParticipationEvent userParticipationClub = UserParticipationEvent(
                            userId: getUrlId(widget.user?.activity ?? ""),
                            eventId: event["event"].id,
                          );
                          final data = await callCreateAPI(
                              'activity/user-participation-event',
                              userParticipationClub.toJson(),
                              widget.token
                          );
                          widget.reload();
                          // delayedInit(milliseconds: 0);
                          event["event"].checkUserJoin = data["id"];
                        }
                        else {
                          // await callDestroyAPI(
                          //     'activity/user-participation-event',
                          //     event["event"].checkUserJoin,
                          //     token
                          // );
                          // delayedInit(milliseconds: 0);
                          Map<String, dynamic> result = await Navigator.pushNamed(context, '/event_detail', arguments: {
                            "id": event["event"]?.id,
                            "userInEvent": event["joinButtonState"],
                          }) as Map<String, dynamic>;
                          widget.checkJoinChange(result["checkJoin"]);
                          if(widget.checkJoin) {
                            print("CHECK JOIN $widget.checkJoin");
                            widget.reload();
                            // delayedInit(reload: true);
                          }
                        }
                        setState(() {
                          event["joinButtonState"] = value;
                          print("CHANGE: ${event["event"].name} 2 ${event["joinButtonState"]}");
                        });
                      },
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