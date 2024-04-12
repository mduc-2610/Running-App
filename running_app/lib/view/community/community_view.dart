import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/add_button.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';
import 'package:running_app/view/community/club/club_view.dart';
import 'package:running_app/view/community/event/event_view.dart';
import 'package:running_app/view/community/feed/feed_view.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({
    super.key
  });

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  String _showView = "Events";
  String token = "";
  DetailUser? user;
  Activity? userActivity;
  bool userInEvent = false;


  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initUser() {
    setState(() {
      user = Provider.of<UserProvider>(context).user;
    });
  }

  void initUserActivity() async {
    final data = await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
    setState(() {
      userActivity = data;
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    initUser();
    initUserActivity();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List redirect = ["Events", "Feed", "Clubs"];
    return Scaffold(
      appBar: const CustomAppBar(
        title: Header(title: "Community", backButton: false, noIcon: true),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              if(_showView != "Feed")...[
                BackgroundContainer(
                  height: media.height * (_showView == "Events" ? 0.28 : 0.26),
                ),
              ],
              Column(
                children: [
                  // Redirect and search section
                  MainWrapper(
                    topMargin: media.height * 0.01,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 10
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: TColor.SECONDARY_BACKGROUND,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for(var x in redirect)
                            CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  _showView = x;
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: media.width * 0.07
                                      )
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color?>(
                                    _showView == x ? TColor.PRIMARY : null
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  )
                              ),
                              child: Text(
                                  x,
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontSize: FontSize.NORMAL,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: media.height * 0.005,),

                  // EventView(),
                  (_showView == "Events") ?
                  const EventView() : (_showView == "Feed" ? const FeedView() : const ClubView()),
                  SizedBox(height: media.height * 0.05,),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: (_showView == "Events" || _showView == "Clubs") ? SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, _showView == "Events" ? "/event_feature_create" : "/club_create");
          },
          child: Icon(
              Icons.add,
              size: 28,
          ),
        ),
      ) : null,
      // bottomSheet: (_showView == "Events" || _showView == "Clubs") ? AddButton(
      //   text: (_showView == "Events")
      //       ? "Create your own event"
      //       : "Create your own club",
      //   onPressed: () {
      //     Navigator.pushNamed(context, _showView == "Events" ? "/event_feature_create" : "/club_create");
      //   },
      // ) : null,
      bottomNavigationBar: Menu(),
    );
  }
}
