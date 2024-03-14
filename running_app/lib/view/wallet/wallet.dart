import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/constants.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List purchaseCategory = [
      {
        "category": "Bank Account",
        "asset": "assets/img/wallet/bank.svg",
        "color": const Color(0xff7b61ff),
        "borderColor": const Color(0xff5953a7),
        "description": "Unfortunately we don't know where to send your money"
      },
      {
        "category": "Card",
        "asset": "assets/img/wallet/card.svg",
        "color": const Color(0xfff14985),
        "borderColor": const Color(0xfff36497),
        "description": "Unfortunately we don't know where to send your money"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Header(title: "New wallet", noIcon: true,),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/home/background_1.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            Center(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      width: media.width * 0.6,
                      child: SizedBox(
                        height: 65,
                        child: Text(
                          "Select the withdrawal type",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.6
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: media.height * 0.02,),
                    for(var category in purchaseCategory)...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 16
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: media.width * 0.03
                        ),
                        decoration: BoxDecoration(
                            color: TColor.SECONDARY_BACKGROUND,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 1,
                                color: TColor.BORDER_COLOR
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: category["borderColor"],
                                      width: 2,
                                    ),
                                    color: category["color"],
                                  ),
                                  child: SvgPicture.asset(
                                    category["asset"],
                                  ),
                                ),
                                SizedBox(width: media.width * 0.025,),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category["category"],
                                        style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.LARGE,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      SizedBox(height: media.height * 0.01,),
                                      Text(
                                        category["description"],
                                        style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: FontSize.SMALL,
                                            fontWeight: FontWeight.w500
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            CustomIconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: TColor.PRIMARY_TEXT,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: media.height * 0.02,),
                    ]
                  ],
                ),
              ),
        
            )
          ],
        ),
      ),
    );
  }
}
