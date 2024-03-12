import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/progress_bar.dart';
import 'package:running_app/utils/common_widgets/seperate_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';

import '../../models/account/user.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic>? users;
  User? user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    users = await callListAPI('account/user', User.fromJson);
    user = await callRetrieveAPI('account/user', users?[0].id, DetailUser.fromJson);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Header(username: '${user?.username?.substring(0, 5)}...' ?? "",),
        automaticallyImplyLeading: false,
        backgroundColor: TColor.PRIMARY,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              BackgroundContainer(height: media.height * 0.39,),
              MainWrapper(
                child: Column(
                  children: [
                    // Level
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: media.width * 0.78),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "14000 / ",
                                        ),
                                        TextSpan(
                                          text: "15000 ",
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.LARGE,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "steps",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    "Level 5",
                                    style: TextStyle(
                                      color: Color(0xffffc932),
                                      fontSize: FontSize.LARGE,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8
                                    )
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: media.height * 0.005,),
                            const ProgressBar(
                              totalSteps: 10, // Total steps
                              currentStep: 9, // Current step
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          "assets/img/home/star.svg",
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
        
                    SizedBox(height: media.height * 0.02,),
                    // Today
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: media.height * 0.015,
                        horizontal: media.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff6b60bd),
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: const Color(0xff746cb3),
                          width: 2
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/img/home/running_avt.svg",
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: media.width * 0.03 ,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "26 May",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Today",
                                    style: TextStyle(
                                      color: Color(0xff43c465),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "01:09:44",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: 12,
                                    ),
                                  )
        
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/img/home/step_icon.svg",
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: media.width * 0.01,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "2345",
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
        
                                  const SeparateBar(width: 27, height: 1,),
        
                                  const SizedBox(height: 2),
                                  const Text(
                                    "5000",
                                    style: TextStyle(
                                      color: Color(0xff43c465),
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
        
                    SizedBox(height: media.height * 0.02,),
        
                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(var x in [
                          {
                            "amount": "53.524",
                            "iconSvg": "assets/img/home/step_icon.svg",
                            "text": "Steps",
                          },
                          {
                            "amount": "1000",
                            "iconSvg": "assets/img/home/coin_icon.svg",
                            "text": "Points",
                          }
                        ])
                          Container(
                            width: media.width * 0.46,
                            height: media.height * 0.18,
                            // padding: EdgeInsets.symmetric(
                            //   vertical: media.height * 0.047,
                            //   horizontal: media.width * 0.075,
                            // ),
        
                            decoration: BoxDecoration(
                                color: const Color(0xff6b60bd),
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                    color: const Color(0xff746cb3),
                                    width: 2
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  x["amount"] as String,
                                  style: TextStyle(
                                    color: TColor.PRIMARY_TEXT,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 40,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        x["iconSvg"] as String,
                                        width: 18,
                                        height: 18,
                                    ),
                                    SizedBox(width: media.width * 0.01,),
                                    Text(
                                      x["text"] as String,
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.LARGE,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ]
                            ),
                          )
                      ],
                    ),
        
                    SizedBox(height: media.height * 0.04,),
        
                    // Event
                    CustomTextButton(
                      onPressed: () {
        
                      },
                      child: SvgPicture.asset(
                        'assets/img/home/event_banner.svg',
                        width: media.width * 0.95,
                        fit: BoxFit.contain,
                      ), // Replace 'my_image.png' with your image asset path
                    ),
        
                    // History
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "History",
                              style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.NORMAL,
                                fontWeight: FontWeight.w600,
                              )
                            ),
                            CustomTextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/activity');
                              },
                              child: Text(
                                  "See all",
                                  style: TextStyle(
                                    color: TColor.PRIMARY,
                                    fontSize: FontSize.NORMAL,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                            )
                          ]
                        ),
                        for(int i = 0; i < 2; i++)
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, media.height * 0.01),
                            padding: EdgeInsets.symmetric(
                              vertical: media.height * 0.015,
                              horizontal: media.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    color: const Color(0xff3f4252),
                                    width: 2
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "27 May",
                                      style: TextStyle(
                                        color: TColor.PRIMARY,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )
                                    ),
                                    SizedBox(height: media.height * 0.005),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: 12,
                                        ),
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: "100 pt",
                                            style: TextStyle(
                                              color: Color(0xffda477e),
                                            ),
                                          ),
                                          TextSpan(text: " - 12,4 km - 1222 kcal"),
                                        ]
                                      )
                                    )
                                  ],
                                ),
        
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.SMALL,
                                      fontWeight: FontWeight.w400
                                    ),
                                    children: <TextSpan> [
                                      TextSpan(
                                        text: "10,120 ",
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.NORMAL,
                                          fontWeight: FontWeight.w900
                                        )
                                      ),
                                      const TextSpan(text: "steps")
                                    ]
                                  ),
                                )
                              ]
                            ),
                          ),
                      ],
                    )
                  ]
                )
              ),
        
            ],
          ),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }
}
