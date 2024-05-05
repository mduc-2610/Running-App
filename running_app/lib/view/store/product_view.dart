
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/product/brand.dart';
import 'package:running_app/models/product/product.dart';
import 'package:running_app/models/product/category.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/button/text_button.dart';
import 'package:running_app/utils/common_widgets/layout/app_bar.dart';
import 'package:running_app/utils/common_widgets/layout/empty_list_notification.dart';

import 'package:running_app/utils/common_widgets/layout/header.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/layout/loading.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/layout/menu.dart';
import 'package:running_app/utils/common_widgets/layout/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_filter.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String menuButtonClicked = "/store";
  bool showClearButton = false;
  bool isLoading = true;
  List<dynamic>? productList, brandList, categoryList;
  List<dynamic>? brandNameList, categoryNameList;
  String token = "";
  String brandFilter = "";
  String categoryFilter = "";
  TextEditingController searchTextController = TextEditingController();

  void initToken() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  Future<void> initProduct() async {
    final data = await callListAPI(
        'product/product',
        Product.fromJson,
        token,
        queryParams: "?q=${searchTextController.text}&"
                    "brand=${brandFilter}&"
                    "category=${categoryFilter}"
    );
    setState(() {
      productList = data;
    });
  }

  Future<void> initBrand() async {
    final data = await callListAPI(
        'product/brand',
        Brand.fromJson,
        token,
    );
    setState(() {
      brandList = data;
      brandNameList = brandList?.map((e) => (e.name ?? "")).toList();
    });
  }

  Future<void> initCategory() async {
    final data = await callListAPI(
      'product/category',
      Category.fromJson,
      token,
    );
    setState(() {
      categoryList = data;
      categoryNameList = categoryList?.map((e) => (e.name ?? "")).toList();
    });
  }

  Future<void> delayedInit({bool reload = false}) async {
    if(reload == true) {
      setState(() {
        isLoading = true;
      });
    }
    else {
      await initBrand();
      await initCategory();
    }
    await initProduct();
    await Future.delayed(Duration(milliseconds: 700));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> delayedInitProduct() async {
    await initProduct();
    await Future.delayed(Duration(milliseconds: 700));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initToken();
    delayedInit();
  }

  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    print(categoryNameList);
    print("?q=${searchTextController.text}"
        "&brand=${brandFilter}"
        "&category=${categoryFilter}"
    );
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: Header(
            title: "Product",
            iconButtons: [
              {
                "icon": Icons.filter_alt_outlined,
                "onPressed": () async {
                  Map<String, String?> result =await showFilter(
                      context,
                      [
                        {
                          "title": "Brand",
                          "list": brandNameList ?? []
                        },
                        {
                          "title": "Category",
                          "list": categoryNameList ?? []
                        },
                      ],
                      buttonClicked: [brandFilter, categoryFilter]
                  );

                  setState(() {
                    brandFilter = result["Brand"] ?? "";
                    categoryFilter = result["Category"] ?? "";
                    delayedInit(reload: true);
                  });
                }
              }
            ],
          ),
          backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: DefaultBackgroundLayout(
            child: Stack(
              children: [
                MainWrapper(
                  child: Column(
                    children: [
                      // Search bar
                      CustomTextFormField(
                          controller: searchTextController,
                          decoration: CustomInputDecoration(
                            hintText: "Search products",
                            prefixIcon: Icon(
                                Icons.search,
                                color: TColor.DESCRIPTION
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          showClearButton: showClearButton,
                          onClearChanged: () {
                            searchTextController.clear();
                            setState(() {
                              showClearButton = false;
                              delayedInit(reload: true);
                            });
                          },
                          onFieldSubmitted: (String x) {
                            delayedInit(reload: true);
                          },
                          onPrefixPressed: () {
                            delayedInit(reload: true);
                          },
                      ),
                      SizedBox(height: media.height * 0.02,),

                      // Product
                      if(isLoading == false)...[
                        if(productList?.length == 0)...[
                          SizedBox(height: media.height * 0.2,),
                          EmptyListNotification(
                            title: "No products found",
                            image: "assets/img/store/product/no_items_found.png",
                          )
                        ]
                        else...[
                          SingleChildScrollView(
                            child: SizedBox(
                              height: media.height * 0.7,
                              child: GridView.count(
                                  padding: const EdgeInsets.all(0),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: media.width * 0.04,
                                  mainAxisSpacing: media.height * 0.02,
                                  children: [
                                    for(var product in productList ?? [])
                                      CustomTextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/product_detail', arguments: {
                                            "id": product?.id
                                          });
                                        },
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
                          marginTop: media.height * 0.3,
                          backgroundColor: Colors.transparent,
                        )
                      ]
                    ],
                  ),
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
