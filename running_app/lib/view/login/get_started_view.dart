import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/notification_box.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/constants.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> onBoard = {
      "title": "Running App",
      "description": "Run and earn with our app. Some text. Example will be her"
    };

    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.PRIMARY_BACKGROUND,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/img/login/get_started_bg.svg',
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: MainWrapper(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  media.width * 0.02,
                  0,
                  media.width * 0.02,
                  media.height * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      onBoard["title"].toString(),
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: media.width * 0.01),
                    Center(
                      child: SizedBox(
                        width: media.width * 0.7,
                        child: Text(
                          onBoard["description"].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: TColor.DESCRIPTION,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: media.width * 0.08),
                    CustomMainButton(
                      horizontalPadding: media.width * 0.3,
                      verticalPadding: 24,
                      onPressed: () {
                        Navigator.pushNamed(context, '/on_board');
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.LARGE,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
