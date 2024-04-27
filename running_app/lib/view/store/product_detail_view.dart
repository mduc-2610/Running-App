import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/product/product.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/bottom_stick_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_notification.dart';
import 'package:running_app/utils/common_widgets/show_password_entry.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  bool isLoading = true, isLoading2 = false;
  String token = "";
  String? productId;
  DetailUser? user;
  Activity? userActivity;
  DetailProduct? product;
  bool showFullText = false;
  bool showViewMoreButton = false;
  int currentSlide = 0;

  Map<String, dynamic> buyButtonState = {};

  void getData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
      productId = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?)?["id"];
    });
  }

  Future<void> initUserActivity() async {
    final data = await callRetrieveAPI(
        null, null,
        user?.activity,
        Activity.fromJson, token);

    setState(() {
      userActivity = data;
    });
  }

  Future<void> initProduct() async {
    final data = await callRetrieveAPI(
        'product/product',
        productId, null,
        DetailProduct.fromJson, token);

    setState(() {
      product = data;

      if(checkUserOwnProduct()) {
        buyButtonState["text"] = "Owned";
        buyButtonState["color"] = TColor.BUTTON_DISABLED;
      }
      else {
        buyButtonState["text"] = "Buy";
        buyButtonState["color"] = TColor.PRIMARY;
      }
    });
  }

  bool checkUserOwnProduct() {
    return (userActivity?.products ?? []).where((e) => e.id == product?.id).toList().length != 0;
  }

  void delayedInit({ bool reload = false}) async {
    if(reload == true) {
      setState(() {
        isLoading = true;
      });
    }
    await initUserActivity();
    await initProduct();
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
    delayedInit();
  }


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(title: "Detail", noIcon: true),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              if(isLoading)...[
                Loading(
                  backgroundColor: Colors.transparent,
                )
              ]
              else...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section
                    Column(
                      children: [
                        SizedBox(
                          height: media.height * 0.27,
                          child: CarouselSlider(
                            options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                scrollDirection: Axis.horizontal,
                                viewportFraction: 1,
                                enableInfiniteScroll: false
                            ),
                            items: [
                              Container(
                                // margin: EdgeInsets.only(rig: 15),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "assets/img/store/product/air_force_1.png",
                                    fit: BoxFit.cover,
                                    width: media.width,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                // borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "assets/img/store/product/air_force_1.png",
                                  fit: BoxFit.cover,
                                  width: media.width,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: media.height * 0.01,),
                        DotsIndicator(
                          dotsCount: 2,
                          position: currentSlide,
                          decorator: DotsDecorator(
                            activeColor: TColor.PRIMARY,
                            spacing: const EdgeInsets.only(left: 8),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: media.height * 0.01,),

                    // Information section
                    MainWrapper(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: media.width * 0.7,
                                child: Text(
                                  "${product?.name}",
                                  style: TxtStyle.headSectionExtraThird,
                                ),
                              ),
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    "assets/img/store/brand/adidas_logo.svg",
                                    width: 35,
                                    height: 35,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: media.height * 0.01,),

                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/img/home/coin_icon_2.svg",
                                width: 25,
                                height: 25,
                              ),
                              Text(
                                "${product?.price} ",
                                style: TextStyle(
                                    color: TColor.ACCEPTED,
                                    fontSize: FontSize.TITLE,
                                    fontWeight: FontWeight.w900
                                ),
                              ),
                              // Text(
                              //   " points",
                              //   style: TxtStyle.normalText,
                              // )
                            ],
                          ),
                          SizedBox(height: media.height * 0.02,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TxtStyle.headSection,
                              ),
                              SizedBox(height: media.height * 0.01,),
                              LimitTextLine(
                                  description: "${product?.description}",
                                  onTap: () {},
                                  showFullText: showFullText,
                                  showViewMoreButton: showViewMoreButton,
                                  maxLines: 10
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                )
              ],
              if(isLoading2)...[
                Loading()
              ]
            ],
          )
        ),
      ),
      bottomSheet: (isLoading == false)
      ? SizedBox(
        width: media.width,
        child: BottomStickButton(
          text: buyButtonState["text"],
          onPressed: () {
            showNotificationDecision(
                context,
                "Notification",
                "Are you sure to buy this product?",
                "No", "Yes",
                onPressed2: () {
                  showPasswordEntry(
                    context,
                    onSubmitted: (result) async {
                      Map<String, dynamic> buyProduct = {
                        // "user_id": user?.id,
                        "product_id": product?.id,
                        "password": result,
                      };
                      // print(buyProduct);
                      setState(() {
                        isLoading2 = true;
                      });
                      final data = await callCreateAPI(
                          'product/product-buy', buyProduct, token);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {
                        isLoading2 = false;
                        if(data["message"] == "Product bought successfully") {
                          print("ok");
                          buyButtonState["text"] = "Owned";
                          buyButtonState["color"] = TColor.BUTTON_DISABLED;
                        }
                      });
                      print(data);
                      showNotification(context, "Notify", data["message"]);

                    }
                  );
                }
            );
          },
          buttonState: buyButtonState["color"] as Color,
          verticalPadding: 15,
        ),
      )
      : null,
    );
  }
}
