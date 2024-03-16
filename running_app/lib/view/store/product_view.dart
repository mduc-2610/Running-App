import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';

import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import '../../utils/constants.dart';
import '../../utils/common_widgets/text_button.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: const Header(
            title: "Product",
            iconButtons: [
              {
                "icon": Icons.filter_alt_outlined,
              }
            ],
          ),
          backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
        ),
        body: SingleChildScrollView(
          child: DefaultBackgroundLayout(
            child: Stack(
              children: [
                MainWrapper(
                  child: Column(
                    children: [
                      // Search bar
                      CustomTextFormField(
                        decoration: CustomInputDecoration(
                          hintText: "Search products",
                          prefixIcon: Icon(Icons.search, color: TColor.DESCRIPTION),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: media.height * 0.01,),

                      // Product
                      SizedBox(
                        height: media.height, // Set a specific height
                        child: GridView.count(
                            padding: const EdgeInsets.all(0),
                            crossAxisCount: 2,
                            crossAxisSpacing: media.width * 0.05,
                            mainAxisSpacing: media.height * 0.025,
                            children: [
                              for(int i = 0; i < 100; i++)
                                CustomTextButton(
                                  onPressed: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(media.width * 0.025),
                                    // width: media.width * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: TColor.SECONDARY_BACKGROUND,
                                      border: Border.all(
                                        color: const Color(0xff495466),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child: Image.asset(
                                                "assets/img/store/product/air_force_1.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(media.width * 0.18, 5, 0, 0),
                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                        color: TColor.SECONDARY_BACKGROUND.withOpacity(0.7),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/img/home/coin_icon.svg",
                                                            width: 16,
                                                            height: 16,
                                                            fit: BoxFit.contain,
                                                          ),
                                                          Text(
                                                            "1200",
                                                            style: TextStyle(
                                                              color: TColor.PRIMARY_TEXT,
                                                              fontSize: FontSize.NORMAL,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: media.height * 0.01),
                                        Text(
                                          "Nike",
                                          style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: FontSize.SMALL,
                                          ),
                                        ),
                                        // SizedBox(height: media.height * 0.005),
                                        Text(
                                          "Air Force 1 Low '07",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: TColor.PRIMARY_TEXT,
                                            fontSize: FontSize.SMALL,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Menu()
    );
  }
}
