import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/constants.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "Address", noIcon: true,),
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
            MainWrapper(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: media.width * 0.1
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/img/address/address.svg"
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Text(
                          "Add your address",
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Text(
                          "Unfortunately we don't know where to deliver your items to you",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.DESCRIPTION,
                              fontSize: FontSize.SMALL,
                              fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            // Container(height: media.height,),
            Positioned(
              left: media.width * 0.025,
              right: media.width * 0.025,
              bottom: media.height * 0.025,
              child: CustomMainButton(
                horizontalPadding: media.width * 0.32,
                onPressed: () {},
                background: Colors.transparent,
                borderWidth: 2,
                borderWidthColor: TColor.PRIMARY,
                borderRadius: 16,
                child: Text(
                  "Add address",
                  style: TextStyle(
                      color: TColor.PRIMARY,
                      fontSize: FontSize.LARGE,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
