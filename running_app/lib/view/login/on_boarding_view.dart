import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';

import '../../utils/constants.dart';
import '../../utils/common_widgets/back_button.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List guidelineArr = [
    {
      "title": "Run",
      "description": 'Lorem ipsum dolor sit, '
          'amet consectetur adipisicing elit. '
          'Illum nesciunt necessitatibus sapiente doloribus aut, '
          'similique eius. Accusamus laboriosam perferendis alias?',
    },
    {
      "title": "Health",
      "description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Assumenda, deserunt molestiae rem deleniti exercitationem ex beatae laborum minus possimus architecto."
    },
    {
      "title": "Community",
      "description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Perferendis blanditiis ex qui harum eveniet odit!"
    }
  ];

  int _currentIndex = 0;

  void _nextSlide() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % guidelineArr.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.PRIMARY_BACKGROUND,
      body: Stack(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, media.height * 1 / 5, 0, 0),
          child: SvgPicture.asset(
              'assets/img/login/on_board_bg.svg',
              width: media.width,
              fit: BoxFit.contain
          ),
        ),

        MainWrapper(
          topMargin: media.height * 0.06,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(context: context),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_in');
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  )
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                          height: media.height * 0.35,
                          padding: const EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 24
                          ),
                          decoration: BoxDecoration(
                            color: TColor.SECONDARY_BACKGROUND,
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(
                              width: 2.0,
                              color: TColor.BORDER_COLOR
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                guidelineArr[_currentIndex]['title'],
                                style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: media.width * 0.75,
                                child: Text(
                                  guidelineArr[_currentIndex]['description'],
                                  style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: media.height * 0.02,),
                              CustomTextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 24
                                        )
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        TColor.PRIMARY
                                    )
                                ),
                                onPressed: () {
                                  if(_currentIndex == 2) Navigator.pushNamed(context, '/sign_in');
                                  else _nextSlide();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      _currentIndex < 2 ? "Next" : "Skip",
                                      style: TextStyle(
                                          color: TColor.PRIMARY_TEXT,
                                          fontSize: FontSize.LARGE,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    SizedBox(width: media.width * 0.01,),
                                    if(_currentIndex != 2)
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: TColor.PRIMARY_TEXT,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                  ),
                  SizedBox(height: media.width * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: TColor.DESCRIPTION,
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign_in');
                        },
                        child: Text(
                          'Sign in',
                            style: TextStyle(
                              color: TColor.PRIMARY,
                              fontSize: FontSize.NORMAL,
                              fontWeight: FontWeight.w500,
                            )
                        )
                      )
                    ],
                  )
                ]
              ),
            ]
          )
        )
      ],)
    );
  }
}
