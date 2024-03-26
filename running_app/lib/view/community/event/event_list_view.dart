import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_list.dart';

class EventListView extends StatefulWidget {
  const EventListView({super.key});

  @override
  State<EventListView> createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  String eventType = "Ongoing";
  List<dynamic>? events;
  String token = "";

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initEvents() async{
    try {
      final data = await callListAPI(
          'activity/event',
          Event.fromJson,
          token,
          queryParams: "?state=${eventType.toLowerCase()}"
      );
      print("ok");
      print(data);
      setState(() {
        events = data;
      });
    } catch(e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    initEvents();
  }

  @override
  Widget build(BuildContext context) {
    print('Ended: $events');
    print(eventType.toLowerCase());
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "All events", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              bottomMargin: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Redirect
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10
                    ),
                    decoration: BoxDecoration(
                      color: TColor.SECONDARY_BACKGROUND,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var x in ["Ongoing", "Upcoming", "Ended"])
                          SizedBox(
                            width: media.width * 0.3,
                            child: CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  eventType = x;
                                  initEvents();
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(
                                          vertical: 5,
                                      )),
                                  backgroundColor: MaterialStateProperty.all<
                                      Color?>(
                                        eventType == x ? TColor.PRIMARY : null
                                      ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)))),
                              child: Text(
                                  x,
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.NORMAL,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          )
                      ],
                    ),
                  ),

                  // Search

                  SizedBox(height: media.height * 0.015,),
                  SizedBox(
                    height: 50,
                    child: CustomTextFormField(
                      decoration: CustomInputDecoration(
                        hintText: "Search events",
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: TColor.DESCRIPTION,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20
                        )
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: media.height * 0.015,),
                  EventList(eventType: "$eventType Event", events: events)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

