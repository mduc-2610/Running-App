import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/social/follow.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class FollowView extends StatefulWidget {
  const FollowView({super.key});

  @override
  State<FollowView> createState() => _FollowViewState();
}

class _FollowViewState extends State<FollowView> {
  String _showLayout = "Following";
  String field = "followees";
  String menuButtonClicked = "/home";
  List<dynamic>? users;
  String token = "";
  DetailUser? user, otherUser;
  Activity? userActivity;
  bool isLoading = true, isLoading2 = false;
  int page = 1;
  TextEditingController searchTextController = TextEditingController();
  bool showClearButton = false;
  bool checkOtherUser = false;

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  Future<void> initUser() async {
    Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if(arguments?["id"] != null) {
      final data = await callRetrieveAPI(
          'account/user',
          arguments?["id"],
          null, DetailUser.fromJson,  token);
      setState(() {
        otherUser = data;
        checkOtherUser = true;
      });
    }
    else {
      checkOtherUser = false;
    }
  }

  Future<void> initUserActivity() async {
    String url = user?.activity ?? "";
    if(checkOtherUser) {
      url = otherUser?.activity ?? "";
    }
    final data = await callRetrieveAPI(
        null, null,
        url,
        Activity.fromJson,
        token,
        queryParams: "?fields=$field&"
            "${field == "follower"
            ? "follower_page" : "followee_page"}=$page&"
            "${field == "follower"
            ? "follower_q" : "followee_q"}=${searchTextController.text}&"
            "pg_sz=1000"
    );
    setState(() {
      userActivity = data;
    });
  }

  Future<void> delayedInit({ bool reload = false, reload2 = false, bool initSide = false }) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    }
    if(reload2) {
      setState(() {
        isLoading2 = true;
      });
    }
    if(initSide) {
      await initUser();
    }

    await initUserActivity();
    await Future.delayed(Duration(milliseconds: 500),);

    setState(() {
      isLoading = false;
      isLoading2 = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProviderData();
    delayedInit(initSide: true);
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    print("Check other user $checkOtherUser");
    print("?fields=$field&"
        "${field == "followers" ? "follower_page" : "followee_page"}=$page");
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Follow", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: CustomTextFormField(
                        controller: searchTextController,
                        decoration: CustomInputDecoration(
                            hintText: "Search",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20
                            ),
                            prefixIcon: Icon(
                                Icons.search_rounded,
                                color: TColor.DESCRIPTION
                            )
                        ),
                        keyboardType: TextInputType.text,
                        showClearButton: showClearButton,
                        onClearChanged: () {
                          searchTextController.clear();
                          setState(() {
                            showClearButton = false;
                            delayedInit(reload: true);
                          });
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var x in ["Following", "Follower"])...[
                          SizedBox(
                            width: media.width * 0.46,
                            child: CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  _showLayout = x;
                                  field = (x == "Following") ? "followees" : "followers";
                                  delayedInit(reload: true);
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: media.width * 0.07)),
                                  backgroundColor: MaterialStateProperty.all<
                                      Color?>(
                                      _showLayout == x ? TColor.PRIMARY : null),
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
                      ],
                    ),
                    SizedBox(height: media.height * 0.015,),
                    if(isLoading)...[
                      Loading(
                        marginTop: media.height * 0.28,
                        backgroundColor: Colors.transparent,
                      )
                    ]
                    else...[
                      (_showLayout == "Follower")
                          ? FollowLayout(
                        layout: "Follower",
                        token: token,
                        userId: ((checkOtherUser) ? getUrlId(user?.activity ?? "") : userActivity?.id) ?? "",
                        totalFollow: userActivity?.totalFollowers ?? 0,
                        followList: userActivity?.followers ?? [],
                        reload: () {
                          delayedInit(reload: true);
                        },
                        checkOtherUser: checkOtherUser,
                      )
                          : FollowLayout(
                        layout: "Following",
                        token: token,
                        userId: ((checkOtherUser) ? getUrlId(user?.activity ?? "") : userActivity?.id) ?? "",
                        totalFollow: userActivity?.totalFollowees ?? 0,
                        followList: userActivity?.followees ?? [],
                        reload: () {
                          delayedInit(reload: true);
                        },
                        checkOtherUser: checkOtherUser,
                      )
                    ]
                  ],
                ),
              ),
              // if(isLoading)...[
              //   Loading(
              //     marginTop: media.height * 0.35,
              //   )
              // ]
            ],
          ),
        ),
      ),
    );
  }
}

class FollowLayout extends StatefulWidget {
  final String layout;
  final String token;
  final String userId;
  final int totalFollow;
  final List<dynamic> followList;
  final VoidCallback? reload;
  final bool checkOtherUser;

  const FollowLayout({
    required this.layout,
    required this.token,
    required this.userId,
    required this.totalFollow,
    required this.followList,
    required this.checkOtherUser,
    this.reload,
    super.key,
  });

  @override
  State<FollowLayout> createState() => _FollowLayoutState();
}

class _FollowLayoutState extends State<FollowLayout> {
  // Map<String, dynamic> followButtonState = {};
  List<Map<String, dynamic>> followList = [];
  int totalFollow = 0;


  @override
  void initState() {
    totalFollow = widget.totalFollow;
    if(widget.layout == "Following") {
      followList.addAll(widget.followList.map((e) => {
        "follow": e,
        "followButtonState": {
          "text": (e.checkUserFollow == null) ? "Follow" : "Unfollow",
          "backgroundColor": (e.checkUserFollow == null) ? TColor.PRIMARY : Colors.transparent,
        }
      }));
    }
    else {
      followList.addAll(widget.followList.map((e) => {
        "follow": e,
        "followButtonState": {
          "text": (e.checkUserFollow == null) ? "Follow" : "Unfollow",
          "backgroundColor": (e.checkUserFollow == null) ? TColor.PRIMARY : Colors.transparent,
        }
      }));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.layout,
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
              Text(
                "${totalFollow}",
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: media.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(followList.length == 0)...[
                  Center(
                    child: EmptyListNotification(
                      marginTop: media.height * 0.2,
                      title: "No users found",
                    ),
                  )
                ]
                else...[
                  for(int i = 0; i < followList.length; i++)...[
                    CustomTextButton(
                      onPressed: () async {
                        Map<String, dynamic> result = await Navigator.pushNamed(context, '/user', arguments: {
                          "id": followList[i]["follow"].id
                        }) as Map<String, dynamic>;
                        if(result["checkFollow"]) {
                          widget.reload?.call();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: TColor.BORDER_COLOR),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/img/community/ptit_logo.png",
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                SizedBox(width: media.width * 0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      followList[i]["follow"].name,
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.SMALL,
                                          fontWeight: FontWeight.w800
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: CustomTextButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 0
                                            )
                                        ),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all(
                                            followList[i]["followButtonState"]["backgroundColor"]
                                        ),
                                        side: MaterialStateProperty.all(
                                            BorderSide(
                                                width: 1.0,
                                                color: TColor.PRIMARY
                                            )
                                        )
                                    ),
                                    onPressed: () async {
                                      if(followList[i]["followButtonState"]["text"] == "Unfollow") {
                                        print("Check user follow: ${followList[i]["follow"].checkUserFollow}");
                                        await callDestroyAPI(
                                            'social/follow',
                                            followList[i]["follow"].checkUserFollow,
                                            widget.token
                                        );
                                        if(widget.layout == "Following" && !widget.checkOtherUser) {
                                          setState(() {
                                            totalFollow -= 1;
                                          });
                                        }
                                      } else {
                                        Follow follow = Follow(
                                            followerId: widget.userId,
                                            followeeId: followList[i]["follow"].actId
                                        );
                                        print(follow.toJson());
                                        final data = await callCreateAPI(
                                            'social/follow',
                                            follow.toJson(),
                                            widget.token
                                        );
                                        followList[i]["follow"].checkUserFollow = data["id"];
                                        if(widget.layout == "Following" && !widget.checkOtherUser) {
                                          setState(() {
                                            totalFollow += 1;
                                          });
                                        }
                                      }
                                      setState(() {
                                        if(followList[i]["followButtonState"]["text"] == "Unfollow") {
                                          followList[i]["followButtonState"] = {
                                            "text": "Follow",
                                            "backgroundColor": TColor.PRIMARY
                                          };
                                        }
                                        else {
                                          followList[i]["followButtonState"] = {
                                            "text": "Unfollow",
                                            "backgroundColor": Colors.transparent
                                          };
                                        }
                                      });
                                    },
                                    child: Text(
                                      followList[i]["followButtonState"]["text"],
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.LARGE,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                  SizedBox(height: media.height * 0.3,)
                ]
              ],
            ),
          ),
        )
      ],
    );
  }
}

