import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post.dart';
import 'package:running_app/models/social/post_like.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_notification.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/feed/utils/common_widget/activity_record_post.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post_create_button.dart';

class PostLayout extends StatefulWidget {
  List<dynamic>? posts;
  bool isLoading;
  String postType;
  String postTypeId;
  bool? userInEvent;
  ScrollController scrollController;
  Future<void> Function() handleRefresh;

  PostLayout({
    required this.posts,
    required this.isLoading,
    required this.postType,
    required this.postTypeId,
    required this.scrollController,
    required this.handleRefresh,
    this.userInEvent,
    super.key
  });

  @override
  State<PostLayout> createState() => _PostLayoutState();
}

class _PostLayoutState extends State<PostLayout> {
  String token = "";
  DetailUser? user;

  ScrollController childScrollController = ScrollController();

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  @override
  void didChangeDependencies() {
    getProviderData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    print(widget.posts);
    // print('Activity Record: ${posts?.length}');
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: DefaultBackgroundLayout(
        child: Stack(
          children: [
            Column(
              children: [
                if(widget.postType == "club")...[
                  PostCreateButton(
                    argumentsOnPressed: {
                      "postType": widget.postType,
                      "postTypeId": widget.postTypeId,
                      "userInEvent": widget.userInEvent,
                    },
                  ),
                ],
                if(widget.isLoading)...[
                  Loading(
                    marginTop: media.height * 0.2,
                    backgroundColor: Colors.transparent,
                  )
                ]
                else...[
                  RefreshIndicator(
                    onRefresh: widget.handleRefresh,
                    child: SizedBox(
                      height: media.height * ((widget.postType == "club") ? 0.71 : 0.8),
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        child: Column(
                          children: [
                            if(widget.postType == "event")...[
                              PostCreateButton(
                                argumentsOnPressed: {
                                  "postType": widget.postType,
                                  "postTypeId": widget.postTypeId,
                                  "userInEvent": widget.userInEvent,
                                },
                              )
                            ],
                            if(widget.posts == null)...[
                              EmptyListNotification(
                                marginTop: media.height * 0.12,
                                title: "There's no post yet",
                                image: "assets/img/community/post.png",
                                imageWidget: Image.asset(
                                  "assets/img/community/post.png",
                                  width: 175,
                                  height: 175,
                                ),
                              )
                            ]
                            else...[
                              for (int i = 0; i < widget.posts!.length; i++) ...[
                                PostWidget(
                                  token: token,
                                  post: widget.posts?[i]["post"],
                                  checkRequestUser: user?.id == widget.posts?[i]["post"]?.user?.id,
                                  postType: widget.postType,
                                  postTypeId: widget.postTypeId,
                                  like: widget.posts?[i]["like"],
                                  deleteOnPressed: () async {
                                    showNotificationDecision(
                                        context, 'Notice',
                                        "Are you sure to delete this post?",
                                        "No", "Yes", onPressed2: () async {
                                      await callDestroyAPI(
                                          'social/${widget.postType}-post',
                                          widget.posts?[i]["post"].id,
                                          token
                                      );
                                      print("Post id $i");
                                      setState(() {
                                        widget.posts?.removeAt(i);
                                      });
                                      Navigator.pop(context);
                                    });
                                  },
                                  editOnPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/post_edit', arguments: {
                                      "postType": widget.postType,
                                      "postTypeId": widget.postTypeId,
                                      "userInEvent": widget.userInEvent,
                                      "id": widget.posts?[i]["post"].id,
                                      "title": widget.posts?[i]["post"].title,
                                      "content": widget.posts?[i]["post"].content,
                                    });
                                  },
                                  likeOnPressed: () async {
                                    if(widget.posts?[i]["like"] == false) {
                                      CreatePostLike postLike = CreatePostLike(
                                        userId: getUrlId(user?.activity ?? ""),
                                        postId: widget.posts?[i]["post"].id,
                                      );
                                      final data = await callCreateAPI(
                                          'social/${widget.postType}-post-like',
                                          postLike.toJson(),
                                          token
                                      );
                                      setState(() {
                                        widget.posts?[i]["post"]?.increaseTotalLikes();
                                        widget.posts?[i]["like"] = (widget.posts?[i]["like"]) ? false : true;
                                        widget.posts?[i]["post"].checkUserLike = data["id"];
                                        UserAbbr author = UserAbbr(
                                            id: user?.id,
                                            name: user?.name,
                                            avatar: ""
                                        );
                                        widget.posts?[i]["post"].likes.insert(0, author);
                                      });
                                    }
                                    else {
                                      await callDestroyAPI(
                                          'social/${widget.postType}-post-like',
                                          widget.posts?[i]["post"].checkUserLike,
                                          token
                                      );
                                      // int index = widget.posts?[i]["post"].likes
                                      //     ?.indexWhere((like) => like.id == user?.id) ?? -1;
                                      setState(() {
                                        widget.posts?[i]["post"].likes.removeAt(i);
                                        widget.posts?[i]["post"]?.decreaseTotalLikes();
                                        widget.posts?[i]["like"] = (widget.posts?[i]["like"]) ? false : true;
                                      });
                                    }
                                    // await initUserActivity();
                                  },
                                ),
                              ]
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ],
        )
      ),
    );
  }
}
