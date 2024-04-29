import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/like.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/social/post.dart';
import 'package:running_app/models/social/post_comment.dart';
import 'package:running_app/models/social/post_like.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_notification.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/feed/utils/common_widget/activity_record_post.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post.dart';
import 'package:running_app/utils/common_widgets/comment_create.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({
    super.key
  });

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
    int currentSlide = 0;
    bool isLoading = true, isLoading2 = false;
    DetailUser? user;
    String token = "";
    String? postId;
    dynamic post;
    bool showFullText = false;
    bool showViewMoreButton = false;
    bool checkRequestUser = false;
    List<Map<String, dynamic>> comments = [];
    String postType = "";
    int page = 1;
    double previousScrollOffset = 0;
    ScrollController scrollController = ScrollController();
    TextEditingController submitTextController = TextEditingController();
    bool like = false;
    String postLikeId = "";

    void submitLike() async {
      if(like == false) {
        CreatePostLike postLike = CreatePostLike(
          userId: getUrlId(user?.activity ?? ""),
          postId: postId,
        );
        final data = await callCreateAPI(
            'social/$postType-post-like',
            postLike.toJson(),
            token
        );
        Like author = Like(
            id: user?.id,
            name: user?.name,
            avatar: ""
        );
        setState(() {
          post?.likes?.insert(0, author);
          post?.increaseTotalLikes();
          postLikeId = data["id"];
          like = (like) ? false : true;
        });
      }
      else {
        await callDestroyAPI(
            'social/$postType-post-like',
            postLikeId,
            token
        );
        setState(() {
          int index = post?.likes?.indexWhere((like) => like.id == user?.id) ?? -1;
          if(index != -1) {
            post?.likes?.removeAt(index);
          }
          post?.decreaseTotalLikes();
          like = (like) ? false : true;
        });
      }
      // await initUserActivity();
    }

    void getSideData() {
      setState(() {
        Map<String, dynamic> arguments = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
        token = Provider.of<TokenProvider>(context).token;
        user = Provider.of<UserProvider>(context).user;
        postId = arguments["id"];
        checkRequestUser = arguments["checkRequestUser"];
        postType = arguments["postType"];
      });
    }

    Future<void> initPost() async {
      final data = await callRetrieveAPI(
          'social/${postType}-post',
          postId,
          null,
          (postType == "club"
              ? DetailClubPost.fromJson
              : DetailEventPost.fromJson),
          token,
          queryParams: "?cmt_pg=$page"
      );

      setState(() {
        post = data;
        comments.addAll(((postType == "club")
            ? (post as DetailClubPost?)?.comments
            : (post as DetailEventPost?)?.comments)?.map((e) => {
          "showViewMoreButton": false,
          "showFullText": false,
          "comment": e as dynamic,
          "checkUserComment": checkUserComment(e),
        }).toList() ?? []);

        // comments.addAll(((postType == "club")
        //     ? (post as DetailClubPost?)?.comments
        //     : (post as DetailEventPost?)?.comments)?.map((e) => {
        //   "showViewMoreButton": false,
        //   "showFullText": false,
        //   "comment": e
        // }).toList() ?? []);
      });
    }

  bool checkUserComment(dynamic cmt) {
    return user?.name == cmt.user?.name;
  }

    Future<void> submitComment({ bool reload = false }) async {
      if(reload == true) {
        setState(() {
          isLoading2 = true;
        });
      }
      CreatePostComment postComment = CreatePostComment(
        userId: getUrlId(user?.activity ?? ""),
        postId: postId,
        content: submitTextController.text,
      );

      print("Post comment: ${postComment.toJson()}");
      final data = await callCreateAPI(
          'social/$postType-post-comment',
          postComment.toJson(),
          token
      );
      comments.insert(0, {
        "showViewMoreButton": false,
        "showFullText": false,
        "comment": (postType == "club"
            ? ClubPostComment.fromJson(data)
            : EventPostComment.fromJson(data)) as dynamic,
        "checkUserComment": true
      });
    }

    void submit() async {
      if(submitTextController.text != "") {
        await submitComment(reload: true);
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          post?.increaseTotalComments();
          isLoading2 = false;
        });
      }
    }


    Future<void> delayedInit() async {
    await initPost();
    await Future.delayed(Duration(milliseconds: 500),);

    setState(() {
      isLoading = false;
    });
  }

  Map<String, dynamic> sportTypeIcon = {
    "Running": Icons.directions_run_rounded,
    "Walking": Icons.directions_walk_rounded,
    "Cycling": Icons.directions_bike_rounded,
    "Swimming": Icons.pool_rounded
  };

  @override
  void didChangeDependencies() {
    getSideData();
    delayedInit();
    super.didChangeDependencies();
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

    void scrollListenerOffSet() {
      double currentScrollOffset = scrollController.offset;
      if ((currentScrollOffset - previousScrollOffset).abs() > (page == 1 ? 0 : 350)) {
        // print("Previous: ${previousScrollOffset}, Current: ${currentScrollOffset}");
        // print('Loading page ${page + 1}');
        previousScrollOffset = currentScrollOffset;
        setState(() {
          page += 1;
        });
        print("Page limit: ${pageLimit(post?.totalComments ?? 0, 5)}");
        if(page <= pageLimit(post?.totalComments ?? 0, 5)) {
          delayedInit();
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(
          title: "Comment",
          noIcon: true,
          argumentsOnPressed: {
            "totalLikes": post?.totalLikes,
            "totalComments": post?.totalComments,
            "postLikeId": postLikeId,
            "postId": postId,
            "like": like,
          },
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
                (isLoading == false) ?
                Column(
                  children: [
                    Column(
                      children: [
                        PostWidget(
                          token: token,
                          post: post,
                          detail: true,
                          checkRequestUser: checkRequestUser,
                          postType: postType,
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
                          if(comments == null)...[
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
                                        // onTap: () {
                                        //   Navigator.pushNamed(context, '/user', arguments: {
                                        //     "id": comment["comment"]?.user?.id
                                        //   });
                                        // },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.asset(
                                            "assets/img/community/ptit_logo.png",
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
                                                          'social/$postType-post-comment',
                                                          comments[i]["comment"].id,
                                                          token
                                                      );
                                                      setState(() {
                                                        comments.removeAt(i);
                                                        post?.decreaseTotalComments();
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
                            ]
                          ],
                          SizedBox(height: media.height * 0.07,),
                        ],
                      ),
                    )
                  ],
                ) : Loading(),
              ],
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
