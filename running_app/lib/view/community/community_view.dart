import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/background_container.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/view/community/club_view.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    List redirect = ["Events", "Social", "Clubs"];
    return Scaffold(
      body: CustomStack(
        children: [
          BackgroundContainer(
            // height: media.height * 0.38,
            height: media.height * 0.36,
          ),
          MainWrapper(
            child: Column(
              children: [
                const Header(title: "Community", backButton: false, noIcon: true),
                SizedBox(height: media.height * 0.02,),
                // Redirect and search section
                Container(
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
                          onPressed: () {},
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: media.width * 0.07
                                  )
                              ),
                              backgroundColor: MaterialStateProperty.all<Color?>(
                                  x == "Clubs" ? TColor.PRIMARY : null
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
                SizedBox(height: media.height * 0.005,),


                // EventView(),
                const ClubView(),
              ],
            )
          ),
          const Menu(),
        ],
      ),
    );
  }
}
