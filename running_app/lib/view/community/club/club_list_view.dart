import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/form/search_filter.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_filter.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class ClubListView extends StatefulWidget {
  const ClubListView({super.key});

  @override
  State<ClubListView> createState() => _ClubListViewState();
}

class _ClubListViewState extends State<ClubListView> {
  bool isLoading = true;
  List<dynamic>? clubs;
  String token = "";
  bool showClearButton = false;
  String sportTypeFilter = "";
  String clubModeFilter = "";
  String organizationTypeFilter = "";
  TextEditingController searchTextController = TextEditingController();

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  Future<void> initClubs() async {
    final data = await callListAPI(
        "activity/club",
        Club.fromJson,
        token,
        queryParams: "?name=${searchTextController.text}&"
            "sport_type=${sportTypeFilter}&"
            "mode=${clubModeFilter}&"
            "org_type=${organizationTypeFilter}"
    );
    setState(() {
      clubs = data;
    });
  }

  void delayedInit({bool reload = false}) async {
    if(reload) {
      setState(() {
        isLoading = true;
      });
    }
    await initClubs();
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    initToken();
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    print("?name=${searchTextController.text}&"
        "sport_type=${sportTypeFilter}&"
        "mode=${clubModeFilter}&"
        "org_type=${organizationTypeFilter}");
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
                    SearchFilter(
                        hintText: "Search clubs",
                        controller: searchTextController,
                        showClearButton: showClearButton,
                        onClearChanged: () {
                          searchTextController.clear();
                          setState(() {
                            showClearButton = false;
                          });
                          delayedInit(reload: true);
                        },
                        onFieldSubmitted: (String x) {
                          delayedInit(reload: true);
                        },
                        onPrefixPressed: () {
                          delayedInit(reload: true);
                        },
                        filterOnPressed:() async {
                          Map<String, String?> result =await showFilter(
                              context,
                              [
                                {
                                  "title": "Sport type",
                                  "list": ["Running", "Cycling", "Swimming"]
                                },
                                {
                                  "title": "Club mode",
                                  "list": ["Public", "Private"]
                                },
                                {
                                  "title": "Organization type",
                                  "list": ["Company", "Sport club", "School"]
                                },
                              ],
                              buttonClicked: [sportTypeFilter, clubModeFilter, organizationTypeFilter]
                          );

                          setState(() {
                            sportTypeFilter = result["Sport type"] ?? "";
                            clubModeFilter = result["Club mode"] ?? "";
                            organizationTypeFilter = result["Organization type"] ?? "";
                            delayedInit(reload: true);
                          });
                        }
                    ),
        
                    SizedBox(height: media.height * 0.01,),
                    // All clubs
                    if(isLoading == false)...[
                      if(clubs?.length == 0)...[
                        SizedBox(height: media.height * 0.25,),
                        EmptyListNotification(
                          title: "No clubs found",
                          description: "",
                        )
                      ]
                      else...[
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
                                                        "Member: ${club?.totalParticipants}",
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
                      ]
                    ]
                    else...[
                      Loading(
                        marginTop: media.height * 0.3,
                        backgroundColor: Colors.transparent,
                      )
                    ]
        
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
