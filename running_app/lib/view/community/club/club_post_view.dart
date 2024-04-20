import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/social/post.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post_layout.dart';
import 'package:running_app/view/community/utils/common_widgets/post/post_create_button.dart';

class ClubPostView extends StatefulWidget {
  const ClubPostView({super.key});

  @override
  State<ClubPostView> createState() => _ClubPostViewState();
}

class _ClubPostViewState extends State<ClubPostView> {
  String token = "";
  bool isLoading = true;
  String? clubId;
  DetailClub? club;
  List<ClubPost>? posts;


  void getData() {
    Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      clubId = arguments?["id"];
    });
  }

  Future<void> initClub() async {
    final data = await callRetrieveAPI(
        'activity/club',
        clubId, null, DetailClub.fromJson, token);
    setState(() {
      club = data;
      posts = club?.posts;
    });
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  void delayedInit() async {
    await initClub();
    await Future.delayed(Duration(milliseconds: 1500),);

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
        title: Header(title: "Club posts", noIcon: true),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: PostLayout(
        posts: posts,
        isLoading: isLoading,
        postType: "club"
      ),
    );
  }
}
