import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class FollowerView extends StatefulWidget {
  const FollowerView({super.key});

  @override
  State<FollowerView> createState() => _FollowerViewState();
}

class _FollowerViewState extends State<FollowerView> {
  bool _showFollowerLayout = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Follow", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: CustomTextFormField(
                      decoration: CustomInputDecoration(
                          hintText: "Type a name of athlete here",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20
                          ),
                          prefixIcon: Icon(
                              Icons.search_rounded,
                              color: TColor.DESCRIPTION
                          )
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
        
                  SizedBox(height: media.height * 0.015,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var x in ["Following", "Follower"])...[
                        SizedBox(
                          width: media.width * 0.46,
                          child: CustomTextButton(
                            onPressed: () {
                              setState(() {
                                _showFollowerLayout = x == "Follower";
                              });
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: media.width * 0.07)),
                                backgroundColor: MaterialStateProperty.all<
                                    Color?>(
                                  // x == "Total stats" ? TColor.PRIMARY : null
        
                                    x == "Following" && _showFollowerLayout == false
                                        || x == "Follower" && _showFollowerLayout == true
                                        ? TColor.PRIMARY : null),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)))),
                            child: Text(x,
                                style: TextStyle(
                                  color: TColor.PRIMARY_TEXT,
                                  fontSize: FontSize.NORMAL,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        )
                      ],
                    ],
                  ),
                  SizedBox(height: media.height * 0.015,),
                  (_showFollowerLayout)
                      ? const FollowLayout(layout: "Follower", amount: "0")
                      : const FollowLayout(layout: "Following", amount: "0")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FollowLayout extends StatelessWidget {
  final String layout;
  final String amount;
  const FollowLayout({super.key, required this.layout, required this.amount});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              layout,
              style: TextStyle(
                  color: TColor.PRIMARY_TEXT,
                  fontSize: FontSize.LARGE,
                  fontWeight: FontWeight.w800
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                  color: TColor.PRIMARY_TEXT,
                  fontSize: FontSize.LARGE,
                  fontWeight: FontWeight.w800
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for(int i = 0; i < 3; i++)...[
              CustomTextButton(
                onPressed: () {},
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
                            child: Image.asset(
                              "assets/img/community/ptit_logo.png",
                              width: 35,
                              height: 35,
                            ),
                          ),
                          SizedBox(width: media.width * 0.02,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                layout == "Following" ? "Minh Duc" : "Dang Minh Duc",
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
                                      (layout == "Follower") ? TColor.PRIMARY : Colors.transparent
                                  ),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                      width: 1.0,
                                      color: TColor.PRIMARY
                                    )
                                  )
                              ),
                              onPressed: () {},
                              child: Text(
                                (layout == "Follower") ? "Follow" : "Unfollow",
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
          ],
        )
      ],
    );
  }
}

