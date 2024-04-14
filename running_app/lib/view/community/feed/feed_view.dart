import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/feed/utils/common_widget/activity_record_post.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  String token = "";
  DetailUser? user;
  List<dynamic>? activityRecords;
  bool isLoading = true;
  String showView = "Explore";

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }


  Future<void> initActivityRecord() async {
    final data = await callListAPI('activity/activity-record/feed', DetailActivityRecord.fromJson, token, pagination: true);
    setState(() {
      activityRecords = data;
    });
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  void delayedInit() async {
    await initActivityRecord();
    await Future.delayed(Duration(milliseconds: 1500),);

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

  ScrollController scrollController = ScrollController();
  bool isVisible = true;
  void scrollListener() {
    double scrollThreshold = 100.0;
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (scrollController.position.pixels > scrollThreshold) {
        setState(() {
          isVisible = false;
        });
      }
    } else {
      setState(() {
        isVisible = true;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(isVisible);
    var media = MediaQuery.sizeOf(context);
    print('Activity Record: ${activityRecords?.length}');
    return Stack(
      children: [
        Column(
          children: [
              AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Visibility(
                  visible: isVisible,
                  child: MainWrapper(
                    bottomMargin: media.height * 0.01,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var x in [
                        {
                          "type": "Explore",
                          "icon": Icons.explore,
                        },
                        {
                          "type": "Following",
                          "icon": Icons.people_alt_rounded,
                        },
                        {
                          "type": "You",
                          "icon": Icons.person,
                        }
                      ]) ...[
                        CustomTextButton(
                          onPressed: () {
                            setState(() {
                              showView = x["type"] as String;
                              isLoading = true;
                            });
                            delayedInit();
                          },
                          child: Container(
                            width: media.width * 0.29,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: (showView == x["type"])
                                    ? TColor.PRIMARY
                                    : TColor.SECONDARY_BACKGROUND,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BShadow.customBoxShadow]),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: TColor.SECONDARY_BACKGROUND,
                                      boxShadow: [BShadow.customBoxShadow2]),
                                  child: Icon(
                                    x["icon"] as IconData,
                                    color: TColor.PRIMARY_TEXT,
                                  ),
                                ),
                                SizedBox(height: media.height * 0.01),
                                Text(
                                  x["type"] as String,
                                  style: TxtStyle.normalText,
                                )
                              ],
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                          ),
                ),
              ),
            RefreshIndicator(
              onRefresh: handleRefresh,
              child: SizedBox(
                height: media.height * 0.73,
                child: SingleChildScrollView(
                  controller: scrollController, // Attach the scroll controller
                  child: Column(
                    children: [
                      if (isLoading == false) ...[
                        for (var activityRecord in activityRecords ?? []) ...[
                          ActivityRecordPost(
                            token: token,
                            activityRecord: activityRecord,
                            checkRequestUser: user?.id == activityRecord?.user?.id,
                          ),
                        ]
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if(isLoading == true)...[
          Loading(
            marginTop: media.height * 0.35,
            backgroundColor: Colors.transparent,
          )
        ]
      ],
    );
  }
}
