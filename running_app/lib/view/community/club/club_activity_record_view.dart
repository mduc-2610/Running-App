import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/social/post.dart';
import 'package:running_app/models/social/post_like.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/utils/common_widgets/activity_record_post.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post_layout.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post_create_button.dart';

class ClubActivityRecordView extends StatefulWidget {
  const ClubActivityRecordView({super.key});

  @override
  State<ClubActivityRecordView> createState() => _ClubActivityRecordViewState();
}

class _ClubActivityRecordViewState extends State<ClubActivityRecordView> {
  String token = "";
  DetailUser? user;
  Activity? userActivity;
  bool isLoading = true;
  String? clubId;
  DetailClub? club;
  List<dynamic> activityRecords = [];
  int page = 1;
  bool stopLoadingPage = false;
  double previousScrollOffset = 0;
  ScrollController scrollController = ScrollController();

  void getData() {
    Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
      clubId = arguments?["id"];
    });
  }

  Future<void> initClub() async {
    dynamic data;
    try {
      data = await callRetrieveAPI(
          'activity/club',
          clubId, null,
          DetailClub.fromJson, token,
          queryParams: "?exclude=participants, posts&"
              "act_rec_page=$page"
      );
    }
    catch(e) {
      setState(() {
        stopLoadingPage = true;
      });
    }
    setState(() {
      club = data;
      activityRecords.addAll(data.activityRecords.map((e) {
        String result = "";
        return {
          "activityRecord": e as dynamic,
          "like": (e.checkUserLike == null) ? false : true,
        };
      }).toList() ?? []);
    });
  }

  Future<void> handleRefresh() async {
    setState(() {
      activityRecords = [];
      page = 1;
    });
    delayedInit(reload: true, initSide: false);
  }

  void scrollListenerOffSet() {
    double currentScrollOffset = scrollController.offset;
    if ((currentScrollOffset - previousScrollOffset).abs() > 500) {
      print("Loading page $page");
      previousScrollOffset = currentScrollOffset;
      setState(() {
        page += 1;
      });
      if(!stopLoadingPage) {
        delayedInit(initSide: false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListenerOffSet);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void delayedInit({bool reload = false, bool initSide = true}) async {
    if(reload == true) {
      setState(() {
        isLoading = true;
      });
    }
    await initClub();
    await Future.delayed(Duration(milliseconds: 500),);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(
          title: "Club activities",
          noIcon: true,
        ),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: scrollController,
          child: DefaultBackgroundLayout(
            child: Stack(
              children: [
                Column(
                  children: [
                    Column(
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
                  ],
                ),
                if(isLoading == true)...[
                  Loading(
                    marginTop: media.height * 0.35,
                    backgroundColor: Colors.transparent,
                  )
                ]
              ],
            ),
          ),
        ),
      )
    );
  }
}
