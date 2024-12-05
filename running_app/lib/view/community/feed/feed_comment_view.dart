import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post_comment.dart';
import 'package:running_app/models/social/post_like.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/comment_create.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/layout/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_month_year.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_notification.dart';
import 'package:running_app/utils/common_widgets/layout/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/utils/common_widgets/activity_record_post.dart';

class FeedCommentView extends StatefulWidget {
  const FeedCommentView({super.key});

  @override
  State<FeedCommentView> createState() => _FeedCommentViewState();
}

class _FeedCommentViewState extends State<FeedCommentView> {
  int currentSlide = 0;
  bool isLoading = true, isLoading2 = false, reachEnd = false;
  String token = "";
  DetailUser? user;
  Activity? userActivity;
  String? activityRecordId;
  DetailActivityRecord? activityRecord;
  bool showFullText = false;
  bool showViewMoreButton = false;
  bool checkRequestUser = false, checkCommentPressed = false;
  List<Map<String, dynamic>> comments = [];
  int page = 1;
  bool like = false;
  double previousScrollOffset = 0;
  ScrollController scrollController = ScrollController();
  TextEditingController submitTextController = TextEditingController();

  String postLikeId = "";

  void getSideData() {
    setState(() {
      Map<String, dynamic> arguments = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
      activityRecordId = arguments["id"];
      checkRequestUser = arguments["checkRequestUser"];
    });
  }

  Future<void> initUserActivity() async {
    final data = await callRetrieveAPI(
        null, null,
        user?.activity,
        Activity.fromJson,
        token,
        queryParams: "?fields=activity_record_post_comments"
    );
    setState(() {
      userActivity = data;
      like = (activityRecord?.checkUserLike == null) ? false : true;
    });
  }
  
  // String checkUserLike() {
  //   String result = "";
  //   for(var activity in userActivity?.activityRecordPostLikes ?? []) {
  //     if(activity.id == activityRecordId) {
  //       result = activity.postLikeId;
  //     }
  //   }
  //   return result;
  // }

  Future<void> initActivityRecord() async {
    final data = await callRetrieveAPI(
        'activity/activity-record',
        activityRecordId,
        null,
        DetailActivityRecord.fromJson,
        token,
        queryParams: "?cmt_pg=$page"
    );

    setState(() {
      activityRecord = data;
      comments.addAll(activityRecord?.comments?.map((e) => {
        "showViewMoreButton": false,
        "showFullText": false,
        "comment": e as dynamic,
        "checkUserComment": checkUserComment(e),
      }).toList() ?? []);
      for(var comment in comments) {
        print("Check: ${comment["comment"].user.name} ${comment["checkUserComment"]}");
      }
    });
  }

  bool checkUserComment(ActivityRecordPostComment cmt) {
    return user?.name == cmt.user?.name;
  }

  Future<void> delayedInit({bool reload = false, reload2 = false, bool initSide = true}) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    }

    if(reload) {
      setState(() {
        isLoading2 = true;
      });
    }

    else if(initSide) {
      await initUserActivity();
    }
    await initActivityRecord();
    await Future.delayed(Duration(milliseconds: 500),);

    setState(() {
      isLoading = false;
      isLoading2 = false;
      reachEnd = false;
    });
  }

  Map<String, dynamic> sportTypeIcon = {
    "Running": Icons.directions_run_rounded,
    "Walking": Icons.directions_walk_rounded,
    "Cycling": Icons.directions_bike_rounded,
    "Swimming": Icons.pool_rounded
  };

  void scrollListenerOffSet() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        reachEnd = true;
        page += 1;
      });
      if(page <= pageLimit(activityRecord?.totalComments ?? 0, 5)) {
        delayedInit(initSide: false);
      }
      else {
        setState(() {
          reachEnd = false;
        });
      }
    }
  }

  Future<void> submitComment({ bool reload = false }) async {
    if(reload == true) {
      setState(() {
        isLoading2 = true;
      });
    }
    CreatePostComment postComment = CreatePostComment(
      userId: getUrlId(user?.activity ?? ""),
      postId: activityRecordId,
      content: submitTextController.text,
    );

    print("Post comment: ${postComment.toJson()}");
    final data = await callCreateAPI(
        'social/act-rec-post-comment',
        postComment.toJson(),
        token
    );
    comments.insert(0, {
      "showViewMoreButton": false,
      "showFullText": false,
      "comment": ActivityRecordPostComment.fromJson(data) as dynamic,
      "checkUserComment": true
    });
  }

  void submitLike() async {
    if(like == false) {
      CreatePostLike postLike = CreatePostLike(
        userId: getUrlId(user?.activity ?? ""),
        postId: activityRecordId,
      );
      final data = await callCreateAPI(
          'social/act-rec-post-like',
          postLike.toJson(),
          token
      );
      UserAbbr author = UserAbbr(
          id: user?.id,
          name: user?.name,
          avatar: user?.avatar,
      );
      setState(() {
        activityRecord?.likes?.insert(0, author);
        activityRecord?.increaseTotalLikes();
        activityRecord?.checkUserLike = data["id"];
        like = (like) ? false : true;
      });
    }
    else {
      await callDestroyAPI(
          'social/act-rec-post-like',
          activityRecord?.checkUserLike,
          token
      );
      setState(() {
        int index = activityRecord?.likes?.indexWhere((like) => like.id == user?.id) ?? -1;
        if(index != -1) {
          activityRecord?.likes?.removeAt(index);
        }
        activityRecord?.decreaseTotalLikes();
        like = (like) ? false : true;
      });
    }
    // await initUserActivity();
  }

  void submit() async {
    if(submitTextController.text.trim() != "") {
      await submitComment(reload: true);
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        activityRecord?.increaseTotalComments();
        checkCommentPressed = true;
        isLoading2 = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    getSideData();
    delayedInit();
    super.didChangeDependencies();
  }

  Future<void> handleRefresh() async {
    delayedInit();
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

  @override
  Widget build(BuildContext context) {
    print("COMMENTS: $comments");
    print("Check: ${activityRecord?.totalComments}");
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(
            title: "Comment",
            noIcon: true,
            argumentsOnPressed: {
              "totalLikes": activityRecord?.totalLikes,
              "totalComments": activityRecord?.totalComments,
              "postLikeId": activityRecord?.checkUserLike,
              "activityRecordId": activityRecordId,
              "like": like,
              "checkCommentPressed": checkCommentPressed,
            },
        ),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SizedBox(
          child: SingleChildScrollView(
            controller: scrollController,
            child: DefaultBackgroundLayout(
              child: Stack(
                children: [
                  (isLoading == false) ?
                  Column(
                    children: [
                      Column(
                        children: [
                          ActivityRecordPost(
                              token: token,
                              activityRecord: activityRecord!,
                              socialSection: true,
                              checkRequestUser: checkRequestUser,
                              detail: true,
                              like: like,
                              likeOnPressed: submitLike,
                          ),
                        ],
                      ),
                      SizedBox(height: media.height * 0.01,),

                      MainWrapper(
                        topMargin: 0,
                        child: Column(
                          children: [
                            if(comments.length == 0)...[
                              EmptyListNotification(
                                title: "No comment",
                              ),
                            ]
                            else...[
                              if(isLoading2)...[
                                Loading(
                                  marginTop: media.height * 0,
                                  backgroundColor: Colors.transparent,
                                  height: media.height * 0.05,
                                ),
                              ],
                              for(int i = 0; i < comments.length; i++)...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context, '/user', arguments: {
                                              "id": comments[i]["comment"]?.user?.id
                                            });
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: Image.network(
                                              comments[i]["comment"]?.user?.avatar,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: media.width * 0.02,),
                                        GestureDetector(
                                          onTap: () {
                                            if(comments[i]["checkUserComment"]) {
                                              showActionList(context,
                                              [
                                                {
                                                  "text": "Delete",
                                                  "textColor": TColor.WARNING,
                                                  "onPressed": () async {
                                                    final data = await callDestroyAPI(
                                                        'social/act-rec-post-comment',
                                                        comments[i]["comment"].id,
                                                        token
                                                    );
                                                    setState(() {
                                                      checkCommentPressed = true;
                                                      comments.removeAt(i);
                                                      activityRecord?.decreaseTotalComments();
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                                }
                                              ],
                                              "Options");
                                            }
                                          },
                                          child: Container(
                                            width: media.width * 0.8,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12,
                                                horizontal: 12
                                            ),
                                            decoration: BoxDecoration(
                                              color: TColor.SECONDARY_BACKGROUND,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context, '/user', arguments: {
                                                      "id": comments[i]["comment"]?.user?.id
                                                    });
                                                  },
                                                  child: Text(
                                                      comments[i]["comment"]?.user?.name,
                                                      style: TextStyle(
                                                          color: TColor.PRIMARY_TEXT,
                                                          fontSize: FontSize.NORMAL,
                                                          fontWeight: FontWeight.w700
                                                      )
                                                  ),
                                                ),
                                                LimitTextLine(
                                                    description: "${comments[i]["comment"]?.content}",
                                                    onTap: () {
                                                      setState(() {
                                                        comments[i]["showFullText"] = (comments[i]["showFullText"]) ? false : true;
                                                      });
                                                    },
                                                    showFullText: comments[i]["showFullText"],
                                                    showViewMoreButton: comments[i]["showViewMoreButton"]
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: media.height * 0.007,),
                                    Padding(
                                      padding: EdgeInsets.only(left: media.width * 0.08),
                                      child: Text(
                                        "${formatDateTimeEnUS(DateTime.parse(comments[i]["comment"]?.createdAt), timeFirst: true, shortcut: true, time: true)}",
                                        style: TxtStyle.smallTextDesc,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: media.height * 0.02,)
                              ],
                              if(reachEnd)...[
                                Loading(reachEnd: true,)
                              ]
                            ],
                            SizedBox(height: media.height * 0.07,),
                          ],
                        ),
                      )
                    ],
                  ) : Loading(),
                  // if(isLoading2)...[
                  //   Loading(
                  //     marginTop: media.height * 0.25,
                  //   )
                  // ]
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Wrapper(
        child: CommentCreate(
          controller: submitTextController,
          chooseImageOnPressed: () {},
          submitOnPressed: submit,
        ),
      ),
    );
  }
}
