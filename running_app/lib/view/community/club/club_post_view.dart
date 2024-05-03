import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/social/post.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post_layout.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post_create_button.dart';

class ClubPostView extends StatefulWidget {
  const ClubPostView({super.key});

  @override
  State<ClubPostView> createState() => _ClubPostViewState();
}

class _ClubPostViewState extends State<ClubPostView> {
  String token = "";
  DetailUser? user;
  Activity? userActivity;
  bool isLoading = true;
  String? clubId;
  DetailClub? club;
  List<dynamic> posts = [];
  int page = 1;
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

  Future<void> initUserActivity() async {
    final data = await callRetrieveAPI(
        null, null,
        user?.activity,
        Activity.fromJson,
        token,
        queryParams: "?fields=club_post_likes"
    );
    setState(() {
      userActivity = data;
    });
  }

  Future<void> initClub() async {
    final data = await callRetrieveAPI(
        'activity/club',
        clubId, null,
        DetailClub.fromJson, token,
        queryParams: "?exclude=participants"
            "&page=$page"
    );
    setState(() {
      club = data;
      posts.addAll(data.posts.map((e) {
        String result = "";
        return {
          "post": e as dynamic,
          "like": (e.checkUserLike == null) ? false : true,
        };
      }).toList() ?? []);
    });
  }

  Future<void> handleRefresh() async {
    setState(() {
      posts = [];
      page = 1;
    });
    delayedInit(reload: true, initSide: false);
  }

  void scrollListenerOffSet() {
    double currentScrollOffset = scrollController.offset;
    if ((currentScrollOffset - previousScrollOffset).abs() > 1000) {
      print("Loading page $page");
      previousScrollOffset = currentScrollOffset;
      setState(() {
        page += 1;
      });
      if(page <= pageLimit(club?.totalPosts ?? 0, 5)) {
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
    if(initSide == true) {
      await initUserActivity();
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
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(
            title: "Club posts",
            noIcon: true,
        ),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: PostLayout(
        handleRefresh: handleRefresh,
        posts: posts,
        isLoading: isLoading,
        postType: "club",
        scrollController: scrollController,
        postTypeId: clubId!,
      ),
    );
  }
}
