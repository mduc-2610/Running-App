import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/product/product.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';

import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import '../../utils/constants.dart';
import '../../utils/common_widgets/text_button.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<dynamic>? productList;
  String token = "";

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void initProduct() async {
    final data = await callListAPI('product/product', Product.fromJson, token);
    setState(() {
      productList = data;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    initProduct();
  }

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
                              for(var product in productList ?? [])
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
                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12.0),
                                                      color: TColor.SECONDARY_BACKGROUND.withOpacity(0.7),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/img/home/coin_icon.svg",
                                                          width: 16,
                                                          height: 16,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        Text(
                                                          product.price.toString() ?? "",
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
                                            )
                                          ],
                                        ),
                                        SizedBox(height: media.height * 0.01),
                                        Text(
                                          product.brand.name ?? "",
                                          style: TextStyle(
                                            color: TColor.DESCRIPTION,
                                            fontSize: FontSize.SMALL,
                                          ),
                                        ),
                                        // SizedBox(height: media.height * 0.005),
                                        Text(
                                          product.name ?? "",
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
