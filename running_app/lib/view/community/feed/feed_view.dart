import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/constants.dart';
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
  List<dynamic>? activityRecords;
  bool isLoading = true;

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }


  Future<void> initActivityRecord() async {
    final data = await callListAPI('activity/activity-record/feed', DetailActivityRecord.fromJson, token, pagination: true);
    setState(() {
      activityRecords = data;
    });
  }

  Future<void> handleRefresh() async {
    delayedInit();
  }

  void delayedInit() async {

    await initActivityRecord();
    await Future.delayed(Duration(milliseconds: 1500),);

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
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    print('Activity Record: ${activityRecords?.length}');
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: SizedBox(
        height: media.height * 0.73,
        child: SingleChildScrollView(
          child: (isLoading == false) ? Column(
            children: [
              for(var activityRecord in activityRecords ?? [])...[
                ActivityRecordPost(
                    token: token,
                    activityRecord: activityRecord,
                    checkRequestUser: user?.id == activityRecord?.user?.id,
                ),
                // SeparateBar(width: media.width, height: 10, color: TColor.SECONDARY_BACKGROUND,  radius: 0,),
              ]
            ],
          ) : Loading(
            backgroundColor: Colors.transparent,
          )
        ),
      ),
    );
  }
}
