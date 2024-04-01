import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/search_filter.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class ClubListView extends StatefulWidget {
  const ClubListView({super.key});

  @override
  State<ClubListView> createState() => _ClubListViewState();
}

class _ClubListViewState extends State<ClubListView> {
  List<dynamic>? clubs;
  String token = "";

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initClubs() async {
    print("ok");
    final data = await callListAPI("activity/club", Club.fromJson, token);
    print('data $data');
    setState(() {
      clubs = data;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    initClubs();
  }

  @override
  Widget build(BuildContext context) {
    print('Clubs: $clubs');
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Club", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    // Search clubs
                    const SearchFilter(hintText: "Search clubs"),
        
                    SizedBox(height: media.height * 0.01,),
                    // All clubs
                    SizedBox(
                      height: media.height - media.height * 0.1,
                      child: GridView.count(
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
        
                          crossAxisSpacing: media.width * 0.035,
                          mainAxisSpacing: media.height * 0.01,
                          children: [
                            for(var club in clubs ?? [])
                              CustomTextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/club_detail', arguments: {
                                    "id": club?.id
                                  });
                                },
                                child: IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.0),
                                          color: TColor.SECONDARY_BACKGROUND,
                                          border: Border.all(
                                            color: const Color(0xff495466),
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: Image.asset(
                                                  "assets/img/community/ptit_logo.png",
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: media.height * 0.015,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  club?.name ?? "",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: TColor.PRIMARY_TEXT,
                                                      fontSize: FontSize.LARGE,
                                                      fontWeight: FontWeight.w800
                                                  ),
                                                ),
                                                // SizedBox(height: media.height * 0.01),
                                                Text(
                                                  club?.sportType ?? "",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: TColor.DESCRIPTION,
                                                    fontSize: FontSize.SMALL,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                // SizedBox(height: media.height * 0.005,),
                                                Text(
                                                  "Member: ${club?.numberOfParticipants}",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: TColor.DESCRIPTION,
                                                    fontSize: FontSize.SMALL,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: media.height * 0.01,),
        
                                            Center(
                                              child: SizedBox(
                                                width: media.width * 0.4, // Set width of the TextButton
                                                height: 35,
                                                child: CustomMainButton(
                                                  horizontalPadding: 0,
                                                  verticalPadding: 0,
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Join",
                                                    style: TextStyle(
                                                        color: TColor.PRIMARY_TEXT,
                                                        fontSize: FontSize.LARGE,
                                                        fontWeight: FontWeight.w800
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]
        
                                  ),
                                ),
                              ),
                          ]
                      ),
                    ),
        
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
