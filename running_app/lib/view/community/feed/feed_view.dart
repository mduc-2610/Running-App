import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post_like.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/separate_bar.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/utils/common_widgets/activity_record_post.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  String token = "";
  DetailUser? user;
  List<dynamic> activityRecords = [];
  bool isLoading = true, isLoading2 = false, reachEnd = false;
  String showView = "Explore";
  bool isVisible = true;
  ScrollController scrollController = ScrollController();
  double previousScrollOffset = 0;
  int page = 1;
  bool stopLoadingPage = false;
  Map<String, dynamic> popArguments = {};

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  Future<void> initActivityRecord() async {
    // print("THIS VIEW: $showView");
    dynamic data;
    try {
      data =
      (showView == "Explore")
          ? await callListAPI(
          'activity/activity-record/feed',
          DetailActivityRecord.fromJson,
          token,
          queryParams: "?exclude=comments&"
              "feed_pg=${page}"
          )
          : (showView == "Following")
          ? (await callRetrieveAPI(
          null, null,
          user?.activity,
          Activity.fromJson,
          token,
          queryParams: "?fields=following_activity_records&"
              "act_rec_exclude=comments&"
              "following_act_rec_page=${page}"
          )).followingActivityRecords
          : (await callRetrieveAPI(
          null, null,
          user?.activity,
          Activity.fromJson,
          token,
          queryParams: "?fields=activity_records&"
              "act_rec_exclude=comments&"
              "act_rec_page=${page}"
          )).activityRecords
      ;
    }
    catch(e) {
      setState(() {
        stopLoadingPage = true;
      });
    }
    if(!stopLoadingPage) {
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
  }

  Future<void> handleRefresh() async {
    setState(() {
      page = 1;
      activityRecords = [];
    });
    delayedInit(reload: true);
  }

  void delayedInit({bool reload = false, reload2 = false, bool initSide = false}) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    }

    if(reload2) {
      setState(() {
        page = 1;
        isLoading2 = true;
      });
    }

    await initActivityRecord();
    // await Future.delayed(Duration(milliseconds: 500),);

    setState(() {
      isLoading = false;
      isLoading2 = false;
      reachEnd = false;
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
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        page += 1;
        reachEnd = true;
      });
      if(!stopLoadingPage) {
        delayedInit();
      }
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
                              activityRecords = [];
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
                              reload: () {
                                setState(() {
                                  page = 1;
                                  activityRecords = [];
                                });
                                delayedInit(reload: true);
                              },
                              token: token,
                              detailOnPressed: () async {
                                Map<String, dynamic> result = await Navigator.pushNamed(context, '/activity_record_detail', arguments: {
                                  "id": activityRecord["activityRecord"].id,
                                  "checkRequestUser": user?.id == activityRecord["activityRecord"]?.user?.id,
                                }) as Map<String, dynamic>;
                                if(result["reload"] != null) {
                                  setState(() {
                                    page = 1;
                                    activityRecords = [];
                                  });
                                  delayedInit(reload: true);
                                }
                                print("Check comment on pressed: ${result["checkCommentPressed"]}");
                                print("Check like on on pressed ${result["checkLikePressed"]}");
                                if(result["checkCommentPressed"]) {
                                  delayedInit(reload2: true);
                                  setState(() {
                                    activityRecord["activityRecord"].totalComments = result["totalComments"];
                                  });
                                }
                                if(result["checkLikePressed"]) {
                                  delayedInit(reload2: true);
                                  setState(() {
                                    if(activityRecord["like"]) {
                                      int index = activityRecord["activityRecord"].likes
                                          ?.indexWhere((like) => like.id == user?.id) ?? -1;
                                      if(index != -1) {
                                        activityRecord["activityRecord"].likes.removeAt(index);
                                      }
                                      activityRecord["like"] = false ;
                                      activityRecord["activityRecord"]?.decreaseTotalLikes();
                                    }
                                    else {
                                      UserAbbr author = UserAbbr(
                                          id: user?.id,
                                          name: user?.name,
                                          avatar: user?.avatar,
                                      );
                                      activityRecord["activityRecord"].likes.insert(0, author);
                                      activityRecord["like"] = true ;
                                      activityRecord["activityRecord"]?.increaseTotalLikes();
                                    }
                                  });
                                }
                              },
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
                                        avatar: user?.avatar,
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
                                    if(index != -1) {
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
                        ],
                        if(reachEnd)...[
                          Loading(reachEnd: true,)
                        ]
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if(isLoading)...[
          Loading(
            marginTop: media.height * 0.35,
            backgroundColor: Colors.transparent,
          )
        ],
        if(isLoading2)...[
          Loading(
            marginTop: media.height * 0.35,
          )
        ]

      ],
    );
  }
}
