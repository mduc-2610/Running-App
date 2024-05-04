import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post_like.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
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
  Activity? userActivity;
  List<dynamic> activityRecords = [];
  bool isLoading = true;
  String showView = "Explore";
  double previousScrollOffset = 0;
  int page = 1;
  bool isVisible = true;
  ScrollController scrollController = ScrollController();


  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  Future<void> initUserActivity() async {
    final data = await callRetrieveAPI(
        null, null,
        user?.activity,
        Activity.fromJson,
        token,
        queryParams: "?fields=activity_record_post_likes"
    );
    setState(() {
      userActivity = data;
    });
  }

  Future<void> initActivityRecord() async {
    final data = await callListAPI(
        'activity/activity-record/feed',
        DetailActivityRecord.fromJson,
        token,
        queryParams: "?exclude=comments&"
            "feed_pg=${page}"
    );
    setState(() {
      activityRecords.addAll(data.map((e) {
        String result = "";
        return {
          "activityRecord": e as dynamic,
          "like": (e.checkUserLike == null) ? false : true,
        };
      }).toList() ?? []);
    });
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  void delayedInit({bool reload = false, bool initSide = true}) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    } else if(initSide) {
      await initUserActivity();
    }
    await initActivityRecord();
    await Future.delayed(Duration(milliseconds: 500),);

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


  void scrollListenerOffSet() {
    double currentScrollOffset = scrollController.offset;
    if ((currentScrollOffset - previousScrollOffset).abs() > 800) {
      print("Loading page $page");
      previousScrollOffset = currentScrollOffset;
      setState(() {
        page += 1;
      });
      delayedInit(initSide: false);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    scrollController.addListener(scrollListenerOffSet);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
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
                  controller: scrollController,
                  child: Column(
                    children: [
                      if (isLoading == false) ...[
                        if(activityRecords.length == 0)...[
                          EmptyListNotification(
                            marginTop: media.height * 0.15,
                            title: "No activities found",
                          )
                        ]
                        else...[
                          for (var activityRecord in activityRecords ?? []) ...[
                            ActivityRecordPost(
                              token: token,
                              activityRecord: activityRecord["activityRecord"],
                              checkRequestUser: user?.id == activityRecord["activityRecord"]?.user?.id,
                              like: activityRecord["like"],
                              likeOnPressed: () async {
                                if(activityRecord["like"] == false) {
                                  CreatePostLike postLike = CreatePostLike(
                                    userId: getUrlId(user?.activity ?? ""),
                                    postId: activityRecord["activityRecord"].id,
                                  );
                                  final data = await callCreateAPI(
                                      'social/act-rec-post-like',
                                      postLike.toJson(),
                                      token
                                  );
                                  setState(() {
                                    activityRecord["activityRecord"]?.increaseTotalLikes();
                                    activityRecord["like"] = (activityRecord["like"]) ? false : true;
                                    activityRecord["activityRecord"].checkUserLike = data["id"];
                                    UserAbbr author = UserAbbr(
                                        id: user?.id,
                                        name: user?.name,
                                        avatar: ""
                                    );
                                    activityRecord["activityRecord"].likes.insert(0, author);
                                  });
                                }
                                else {
                                  await callDestroyAPI(
                                    'social/act-rec-post-like',
                                    activityRecord["activityRecord"].checkUserLike,
                                    token
                                  );
                                  int index = activityRecord["activityRecord"].likes
                                      ?.indexWhere((like) => like.id == user?.id) ?? -1;
                                  setState(() {
                                    if(index != - 1) {
                                      activityRecord["activityRecord"].likes.removeAt(index);
                                    }
                                    activityRecord["activityRecord"]?.decreaseTotalLikes();
                                    activityRecord["like"] = (activityRecord["like"]) ? false : true;
                                  });
                                }
                                // await initUserActivity();
                              },
                              // getArguments: (result)  {
                              //   setState(() {
                              //     arguments = result;
                              //     if(activityRecord["activityRecord"].id == arguments?["activityRecordId"]) {
                              //       activityRecord["like"] = arguments?["like"];
                              //       activityRecord["postLikeId"] = arguments?["postLikeId"];
                              //     }
                              //   });
                              // },
                            ),
                          ]
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
