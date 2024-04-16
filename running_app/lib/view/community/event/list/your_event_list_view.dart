import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/event/utils/common_widgets/event_list.dart';

class YourEventListView extends StatefulWidget {
  const YourEventListView({super.key});

  @override
  State<YourEventListView> createState() => _YourEventListViewState();
}

class _YourEventListViewState extends State<YourEventListView> {
  bool isLoading = true;
  String eventType = "Joined";
  DetailUser? user;
  Activity? userActivity;
  List<dynamic>? events;
  String token = "";
  bool showClearButton = true;
  TextEditingController searchTextController = TextEditingController();

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  Future<void> initUserActivity() async {
    final activity = await callRetrieveAPI(
        null, null,
        user?.activity,
        Activity.fromJson,
        token,
        queryParams: "?event_state=${eventType.toLowerCase()}&"
            "event_name=${searchTextController.text}"
    );
    setState(() {
      userActivity = activity;
      events = userActivity?.events;
    });
  }

  Future<void> delayedInit({ bool reload = false}) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    }
    await initUserActivity();
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProviderData();
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    print("?state=${eventType.toLowerCase()}&"
        "name=${searchTextController.text}");
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Your events", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                bottomMargin: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Redirect
                    Container(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10
                        ),
                        decoration: BoxDecoration(
                          color: TColor.SECONDARY_BACKGROUND,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BShadow.customBoxShadow
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var x in ["Created", "Joined", "Ended"])
                              SizedBox(
                                width: media.width * 0.3,
                                child: CustomTextButton(
                                  onPressed: () {
                                    setState(() {
                                      eventType = x;
                                      searchTextController.text = searchTextController.text;
                                    });
                                    delayedInit(reload: true);
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
                                      '$x',
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
                    ),

                    // Search

                    SizedBox(height: media.height * 0.015,),
                    SizedBox(
                      height: 50,
                      child: CustomTextFormField(
                        controller: searchTextController,
                        decoration: CustomInputDecoration(
                          hintText: "Search events",
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: TColor.DESCRIPTION,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        onClearChanged: () {
                          searchTextController.clear();
                          setState(() {
                            showClearButton = false;
                          });
                          delayedInit(reload: true);
                        },
                        onFieldSubmitted: (String x) {
                          delayedInit(reload: true);
                        },
                        onPrefixPressed: () {
                          delayedInit(reload: true);
                        },
                      ),
                    ),
                    SizedBox(height: media.height * 0.015,),
                    if(isLoading == false)...[
                      EventList(
                          scrollHeight: media.height * 0.67,
                          eventType: "$eventType Event",
                          events: events
                      ),
                    ]
                    else...[
                      Loading(
                        marginTop: media.height * 0.25,
                        backgroundColor: Colors.transparent,
                      )
                    ]
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
