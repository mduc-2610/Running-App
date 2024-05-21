import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/social/follow.dart';
import 'package:running_app/services/api_service.dart';

import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/button/icon_button.dart';
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

class UserDiscoveryView extends StatefulWidget {
  const UserDiscoveryView({super.key});

  @override
  State<UserDiscoveryView> createState() => _UserDiscoveryViewState();
}

class _UserDiscoveryViewState extends State<UserDiscoveryView> {
  bool isLoading = true, isLoading2 = false;
  String token = "";
  DetailUser? user;
  List<dynamic> userList = [];
  bool showClearButton = false;
  TextEditingController searchTextController = TextEditingController();

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }

  Future<void> initUserList() async {
    final data = await callListAPI(
        'account/activity',
        UserAbbr.fromJson,
        token,
        queryParams: "?name=${searchTextController.text}"
    );
    setState(() {
      // userList = data;
      // userList.addAll(data.map((e) => {
      //   "user": e,
      //   "followButtonState": {
      //     "text": (e.checkUserFollow == null) ? "Follow" : "Unfollow",
      //     "backgroundColor": (e.checkUserFollow == null) ? TColor.PRIMARY : Colors.transparent,
      //   }
      // }));
      userList = data.map((e) => {
        "user": e,
        "followButtonState": {
          "text": (e.checkUserFollow == null) ? "Follow" : "Unfollow",
          "backgroundColor": (e.checkUserFollow == null) ? TColor.PRIMARY : Colors.transparent,
        }
      }).toList();
    });
  }

  void delayedInit({ bool reload = false, bool reload2 = false }) async {
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
    await initUserList();

    setState(() {
      isLoading = false;
      isLoading2 = false;
    });
  }

  Future<void> handleRefresh() async {
    delayedInit(reload: true);
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

    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Search", noIcon: true,),
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
                            hintText: "Type name of athlete here",
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
                    RefreshIndicator(
                      onRefresh: handleRefresh,
                      child: SizedBox(
                        height: media.height * 0.83,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       "Suggestion",
                              //       style: TextStyle(
                              //           color: TColor.PRIMARY_TEXT,
                              //           fontSize: FontSize.LARGE,
                              //           fontWeight: FontWeight.w800
                              //       ),
                              //     ),
                              //     Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         for(var user in userList ?? [])...[
                              //           CustomTextButton(
                              //             onPressed: () {
                              //               Navigator.pushNamed(context, '/other_user', arguments: {
                              //                 "id": user.id
                              //               });
                              //             },
                              //             child: Container(
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: 10
                              //               ),
                              //               decoration: BoxDecoration(
                              //                 border: Border(
                              //                   bottom: BorderSide(width: 2, color: TColor.BORDER_COLOR),
                              //                 ),
                              //               ),
                              //               child: Row(
                              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                 children: [
                              //                   Row(
                              //                     children: [
                              //                       ClipRRect(
                              //                         borderRadius: BorderRadius.circular(50),
                              //                         child: Image.asset(
                              //                           "assets/img/community/ptit_logo.png",
                              //                           width: 35,
                              //                           height: 35,
                              //                         ),
                              //                       ),
                              //                       SizedBox(width: media.width * 0.02,),
                              //                       SizedBox(
                              //                         width: media.width * 0.5,
                              //                         child: Column(
                              //                           crossAxisAlignment: CrossAxisAlignment.start,
                              //                           children: [
                              //                             Text(
                              //                               user?.username,
                              //                               style: TextStyle(
                              //                                   color: TColor.PRIMARY_TEXT,
                              //                                   fontSize: FontSize.SMALL,
                              //                                   fontWeight: FontWeight.w800
                              //                               ),
                              //                               maxLines: 1,
                              //                               overflow: TextOverflow.ellipsis,
                              //                             ),
                              //                             Text(
                              //                               "Nho Quan - Ninh Binh",
                              //                               style: TextStyle(
                              //                                   color: TColor.DESCRIPTION,
                              //                                   fontSize: FontSize.SMALL,
                              //                                   fontWeight: FontWeight.w500
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       SizedBox(
                              //                         child: CustomTextButton(
                              //                           style: ButtonStyle(
                              //                               padding: MaterialStateProperty.all(
                              //                                   const EdgeInsets.symmetric(
                              //                                       horizontal: 20,
                              //                                       vertical: 0
                              //                                   )
                              //                               ),
                              //                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              //                                 RoundedRectangleBorder(
                              //                                   borderRadius: BorderRadius.circular(10.0),
                              //                                 ),
                              //                               ),
                              //                               backgroundColor: MaterialStateProperty.all(
                              //                                   TColor.PRIMARY
                              //                               )
                              //                           ),
                              //                           onPressed: () {},
                              //                           child: Text(
                              //                             "Follow",
                              //                             style: TextStyle(
                              //                                 color: TColor.PRIMARY_TEXT,
                              //                                 fontSize: FontSize.NORMAL,
                              //                                 fontWeight: FontWeight.w700
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                       SizedBox(width: media.width * 0.02,),
                              //                       CustomIconButton(
                              //                         icon: Icon(
                              //                           Icons.cancel,
                              //                           color: TColor.PRIMARY_TEXT,
                              //                           size: 20,
                              //                         ),
                              //                         onPressed: () {},
                              //                       )
                              //                     ],
                              //                   )
                              //                 ],
                              //               ),
                              //             ),
                              //           )
                              //         ]
                              //       ],
                              //     )
                              //   ],
                              // ),
                              // SizedBox(height: media.height * 0.02,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "People on App",
                                        style: TxtStyle.headSection,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if(isLoading)...[
                                        Loading(
                                          marginTop: media.height * 0.3,
                                          backgroundColor: Colors.transparent,
                                        )
                                      ]
                                      else...[
                                        if(userList.length == 0)...[
                                          Center(
                                            child: EmptyListNotification(
                                              marginTop: media.height * 0.2,
                                              title: "No user found",
                                            ),
                                          )
                                        ]
                                        else...[
                                          for(int i = 0; i < userList.length; i++)...[
                                            CustomTextButton(
                                              onPressed: () async {
                                                Map<String, dynamic> result = await Navigator.pushNamed(context, '/user', arguments: {
                                                  "id": userList[i]["user"].id
                                                }) as Map<String, dynamic>;
                                                if(result["checkFollow"]) {
                                                  delayedInit(reload2: true);
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
                                                          child: Image.network(
                                                            userList[i]["user"].avatar,
                                                            width: 45,
                                                            height: 45,
                                                          ),
                                                        ),
                                                        SizedBox(width: media.width * 0.02,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              userList[i]["user"].name,
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
                                                                    userList[i]["followButtonState"]["backgroundColor"]
                                                                ),
                                                                side: MaterialStateProperty.all(
                                                                    BorderSide(width: 2, color: TColor.PRIMARY)
                                                                )
                                                            ),
                                                            onPressed: () async {
                                                              if(userList[i]["followButtonState"]["text"] == "Unfollow") {
                                                                print("Check user follow: ${userList[i]["user"].checkUserFollow}");
                                                                await callDestroyAPI(
                                                                    'social/follow',
                                                                    userList[i]["user"].checkUserFollow,
                                                                    token
                                                                );
                                                              } else {
                                                                Follow follow = Follow(
                                                                    followerId: getUrlId(user?.activity ?? ""),
                                                                    followeeId: userList[i]["user"].actId
                                                                );
                                                                print(follow.toJson());
                                                                final data = await callCreateAPI(
                                                                    'social/follow',
                                                                    follow.toJson(),
                                                                    token
                                                                );
                                                                userList[i]["user"].checkUserFollow = data["id"];
                                                              }
                                                              setState(() {
                                                                if(userList[i]["followButtonState"]["text"] == "Unfollow") {
                                                                  userList[i]["followButtonState"] = {
                                                                    "text": "Follow",
                                                                    "backgroundColor": TColor.PRIMARY
                                                                  };
                                                                }
                                                                else {
                                                                  userList[i]["followButtonState"] = {
                                                                    "text": "Unfollow",
                                                                    "backgroundColor": Colors.transparent
                                                                  };
                                                                }
                                                              });
                                                            },
                                                            child: Text(
                                                              userList[i]["followButtonState"]["text"],
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
                                          ]
                                        ]
                                      ]
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if(isLoading2)...[
                Loading(
                  marginTop: media.height * 0.35,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
