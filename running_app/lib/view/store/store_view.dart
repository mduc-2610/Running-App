import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/product/brand.dart';
import 'package:running_app/models/product/product.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/empty_list_notification.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/loading.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/menu.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/scroll_synchronized.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  String menuButtonClicked = "/store";
  bool isLoading = true, isLoadingBrand = true;
  List<dynamic>? productList, brandList;
  String brandFilter = "";
  String token = "";
  ScrollController parentScrollController = ScrollController();
  ScrollController childScrollController = ScrollController();

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  Future<void> initBrand() async {
    final data = await callListAPI(
      'product/brand',
      Brand.fromJson,
      token,
      queryParams: "?limit=8"
    );
    setState(() {
      brandList = data;
    });
  }

  Future<void> initProduct() async {
    final data = await callListAPI(
        'product/product',
        Product.fromJson,
        token,
        queryParams: "?brand=${brandFilter}&"
            "limit=6"
    );
    setState(() {
      productList = data;
    });
  }

  Future<void> delayedInit({bool reload = false}) async {
    if(reload == true) {
      setState(() {
        isLoadingBrand = true;
      });
    } else {
      await initBrand();
    }
    await initProduct();
    await Future.delayed(Duration(milliseconds: 700));
    setState(() {
      isLoading = false;
      isLoadingBrand = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    delayedInit();
  }

  @override
  Widget build(BuildContext context) {
    print("?limit=6&"
        "brand=${brandFilter}");
    var media = MediaQuery.sizeOf(context);
    List brands = [
      {
        "name": "${brandList?[0].name}",
        "logo": "assets/img/store/brand/puma_logo.svg",
      },
      {
        "name": "${brandList?[1].name}",
        "logo": "assets/img/store/brand/reebok_logo.svg",
      },
      {
        "name": "${brandList?[2].name}",
        "logo": "assets/img/store/brand/nike_logo.svg",
      },
      {
        "name": "${brandList?[3].name}",
        "logo": "assets/img/store/brand/adidas_logo.svg",
      },

      {
        "name": "${brandList?[4].name}",
        "logo": "assets/img/store/brand/ua_logo.svg",
      },
      {
        "name": "${brandList?[5].name}",
        "logo": "assets/img/store/brand/reebok_logo.svg",
      },
      {
        "name": "${brandList?[6].name}",
        "logo": "assets/img/store/brand/nike_logo.svg",
      },
      {
        "name": "${brandList?[7].name}",
        "logo": "assets/img/store/brand/nike_logo.svg",
      }
    ];
    return Scaffold(
        appBar: CustomAppBar(
          title: const Header(title: "Store", backButton: false,),
          backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
        ),
      body: SingleChildScrollView(
        controller: parentScrollController,
        child:
          DefaultBackgroundLayout(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    if(isLoading == false)...[
                      MainWrapper(
                          topMargin: 0,
                          child: Column(
                            children: [
                              // Header
                              // const ,
                              SizedBox(height: media.height * 0.02,),
                              // Banner
                              CustomTextButton(
                                onPressed: () {

                                },
                                child: SvgPicture.asset(
                                  'assets/img/home/event_banner.svg',
                                  width: media.width * 0.95,
                                  fit: BoxFit.contain,
                                ), // Replace 'my_image.png' with your image asset path
                              ),
                              SizedBox(height: media.height * 0.02,),

                              GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, // Number of items in each row
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: (media.width * 0.22) / (media.height * 0.1), // Aspect ratio of each item
                                ),
                                shrinkWrap: true,
                                itemCount: brandList?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  var brand = brandList?[index];
                                  return CustomTextButton(
                                    onPressed: () {
                                      setState(() {
                                        brandFilter = (index < 7) ? brand.name : "";
                                        delayedInit(reload: true);
                                      });
                                    },
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        Size(media.width * 0.22, media.height * 0.1),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color?>(TColor.SECONDARY_BACKGROUND),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                      ),
                                      side: MaterialStateProperty.all<BorderSide>(
                                        const BorderSide(color: Color(0xff495466), width: 2.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(index < 7)...[
                                          SvgPicture.asset(
                                            brands[index]["logo"],
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          )
                                        ]
                                        else...[
                                          SizedBox(width: 30, height: 30,)
                                        ],
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            "${(index < 7) ? brand.name : "All"}",
                                            style: TextStyle(
                                              color: TColor.DESCRIPTION,
                                              fontSize: FontSize.SMALL,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              // Popular
                              Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Popular",
                                            style: TxtStyle.headSection
                                        ),
                                        CustomTextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/product');
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
                                  if(isLoadingBrand == false)...[
                                    if(productList?.length == 0)...[
                                      SizedBox(height: media.height * 0.05,),
                                      EmptyListNotification(
                                        title: "No products found",
                                        image: "assets/img/store/product/no_items_found.png",
                                      )
                                    ]
                                    else...[
                                      ScrollSynchronized(
                                        parentScrollController: parentScrollController,
                                        child: SizedBox (
                                          height: media.height * 0.71,
                                          child: GridView.count(
                                              padding: const EdgeInsets.all(0),
                                              crossAxisCount: 2,
                                              crossAxisSpacing: media.width * 0.04,
                                              mainAxisSpacing: media.height * 0.02,
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
                                      ),
                                    ]
                                  ] else...[
                                    Loading(
                                      marginTop: media.height * 0.05,
                                      backgroundColor: Colors.transparent,
                                    )
                                  ]
                                ],
                              ),
                            ],
                          )
                      ),
                    ]
                    else...[
                      Loading()
                    ]
                  ],
                ),
              ],
            ),
          ),
      ),
      bottomNavigationBar: Menu(
        buttonClicked: menuButtonClicked,
      )
    );
  }
}
