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

class YourEventListView extends StatefulWidget {
  const YourEventListView({super.key});

  @override
  State<YourEventListView> createState() => _YourEventListViewState();
}

class _YourEventListViewState extends State<YourEventListView> {
  String _eventType = "Joined";
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "All events", noIcon: true,),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/home/background_1.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    // Redirect
                    Container(
                      // padding: EdgeInsets.symmetric(
                      //     vertical: 5,
                      //     horizontal: 10
                      // ),
                      // decoration: BoxDecoration(
                      //   color: TColor.SECONDARY_BACKGROUND,
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var x in ["Joined", "Ended"])
                            SizedBox(
                              width: media.width * 0.46,
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
