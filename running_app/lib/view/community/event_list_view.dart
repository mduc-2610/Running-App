import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/event_box.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class EventListView extends StatefulWidget {
  const EventListView({super.key});

  @override
  State<EventListView> createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  String _eventType = "Ongoing";
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    Header(title: "All events", noIcon: true,),
                    SizedBox(height: media.height * 0.015,),

                    // Redirect
                    Container(
                      padding: EdgeInsets.symmetric(
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
                                    _eventType = x;
                                  });
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 5,
                                        )),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color?>(
                                          _eventType == x ? TColor.PRIMARY : null
                                        ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10)))),
                                child: Text(x,
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
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20
                          )
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: media.height * 0.015,),
                    EventList(eventType: _eventType + " Event",),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  final String eventType;
  const EventList({
    required this.eventType,
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
        for(int i = 0; i < 10; i++)...[
          EventBox(),
          if(i < 9) SizedBox(height: media.height * 0.02,),
        ]
      ],
    );
  }
}
