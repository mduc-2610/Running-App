import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post_comment.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/comment_create.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/view/community/feed/utils/common_widget/activity_record_post.dart';

class FeedCommentView extends StatefulWidget {
  const FeedCommentView({super.key});

  @override
  State<FeedCommentView> createState() => _FeedCommentViewState();
}

class _FeedCommentViewState extends State<FeedCommentView> {
  int currentSlide = 0;
  bool isLoading = true;
  String token = "";
  String? activityRecordId;
  DetailActivityRecord? activityRecord;
  bool showFullText = false;
  bool showViewMoreButton = false;
  bool checkRequestUser = false;
  List<Map<String, dynamic>>? comments;

  void getSideData() {
    setState(() {
      Map<String, dynamic> arguments = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
      token = Provider.of<TokenProvider>(context).token;
      activityRecordId = arguments["id"];
      checkRequestUser = arguments["checkRequestUser"];
    });
  }

  Future<void> initActivityRecord() async {
    final data = await callRetrieveAPI(
        'activity/activity-record',
        activityRecordId,
        null,
        DetailActivityRecord.fromJson,
        token
    );

    setState(() {
      activityRecord = data;
      comments = activityRecord?.comments?.map((e) => {
        "showViewMoreButton": false,
        "showFullText": false,
        "comment": e
      }).toList();
    });
  }

  Future<void> delayedInit() async {
    await initActivityRecord();
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(title: "Comment", noIcon: true),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SizedBox(
          child: SingleChildScrollView(
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
                              activityRecord: activityRecord,
                              socialSection: true,
                              checkRequestUser: checkRequestUser,
                              detail: true,
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
                              for(var comment in comments!)...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context, '/user', arguments: {
                                              "id": comment["comment"]?.user?.id
                                            });
                                          },
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
                                        Container(
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
                                                    "id": comment["comment"]?.user?.id
                                                  });
                                                },
                                                child: Text(
                                                    comment["comment"]?.user?.name,
                                                    style: TextStyle(
                                                        color: TColor.PRIMARY_TEXT,
                                                        fontSize: FontSize.NORMAL,
                                                        fontWeight: FontWeight.w700
                                                    )
                                                ),
                                              ),
                                              LimitTextLine(
                                                  description: "${comment["comment"]?.content}",
                                                  onTap: () {
                                                    setState(() {
                                                      comment["showFullText"] = (comment["showFullText"]) ? false : true;
                                                    });
                                                  },
                                                  showFullText: comment["showFullText"],
                                                  showViewMoreButton: comment["showViewMoreButton"]
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: media.height * 0.007,),
                                    Padding(
                                      padding: EdgeInsets.only(left: media.width * 0.08),
                                      child: Text(
                                        "${formatDateTimeEnUS(DateTime.parse(comment["comment"]?.createdAt), timeFirst: true, shortcut: true, time: true)}",
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
      ),
      bottomSheet: Wrapper(
        child: CommentCreate(),
      ),
    );
  }
}
