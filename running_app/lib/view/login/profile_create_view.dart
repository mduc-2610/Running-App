import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:csc_picker/csc_picker.dart';
import "package:running_app/models/account/user.dart";
import "package:running_app/models/account/profile.dart";
import "package:running_app/services/api_service.dart";
import "package:running_app/utils/common_widgets/app_bar.dart";
import "package:running_app/utils/common_widgets/header.dart";
import "package:running_app/utils/common_widgets/input_decoration.dart";
import "package:running_app/utils/common_widgets/loading.dart";
import "package:running_app/utils/common_widgets/main_button.dart";
import "package:running_app/utils/common_widgets/main_wrapper.dart";
import "package:running_app/utils/common_widgets/default_background_layout.dart";
import "package:running_app/utils/common_widgets/show_month_year.dart";
import "package:running_app/utils/common_widgets/show_notification.dart";
import "package:running_app/utils/common_widgets/text_button.dart";
import "package:running_app/utils/common_widgets/text_form_field.dart";
import "package:running_app/utils/common_widgets/wrapper.dart";
import "package:running_app/utils/constants.dart";
import "package:running_app/utils/function.dart";
import "package:running_app/utils/providers/token_provider.dart";
import "package:running_app/utils/providers/user_provider.dart";

class ProfileCreateView extends StatefulWidget {
  const ProfileCreateView({super.key});

  @override
  State<ProfileCreateView> createState() => _ProfileCreateViewState();
}

class _ProfileCreateViewState extends State<ProfileCreateView> {
  // bool isLoading = true;
  String? gender = "male";
  String selectedValue = "";
  String token = "";
  DetailUser? user;
  DetailProfile? userProfile;
  String? nation, city, shirtSize, trouserSize;


  String? userId;
  String? email;
  String? phoneNumber;

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
    });
  }

  void getArguments() {
    setState(() {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      userId = arguments["id"];
      email = arguments["email"];
      phoneNumber = arguments["phoneNumber"];
    });
  }

  Future<void> initUserProfile() async {
    final data = await callRetrieveAPI(null, null, user?.profile, DetailProfile.fromJson, token);
    setState(() {
      userProfile = data;
    });
  }

  void delayedInit() async {
    // getProviderData();
    // await initUserProfile();
    // initFields();
    // Future.delayed(Duration(seconds: 3));
    getArguments();
    initFields();
    setState(() {
      // isLoading = false;
    });
  }

  // void initFields() {
  //   setState(() {
  //     fields[0]["controller"].text = user?.name;
  //     fields[1]["controller"].text = user?.email;
  //     fields[4]["controller"].text = userProfile?.dateOfBirth ?? "";
  //     fields[5]["controller"].text = userProfile?.height?.toString() ?? "";
  //     fields[6]["controller"].text = userProfile?.weight?.toString() ?? "";
  //     fields[7]["controller"].text = user?.phoneNumber ?? "";
  //     fields[8]["controller"].text = userProfile?.shoeSize?.toString() ?? "";
  //     fields[2]["value"] = userProfile?.country ?? "";
  //     fields[3]["value"] = userProfile?.city ?? "";
  //     gender = userProfile?.gender?.toLowerCase();
  //     fields[9]["value"] = userProfile?.shirtSize ?? "";
  //     fields[10]["value"] = userProfile?.trouserSize ?? "";
  //   });
  // }

  void initFields() {
    setState(() {
      fields[1]["controller"].text = email ?? "";
      fields[2]["value"] = nation ?? "";
      fields[3]["value"] = city ?? "";
      fields[7]["controller"].text = phoneNumber ?? "";
    });
  }

  @override
  void didChangeDependencies() {
    delayedInit();
    super.didChangeDependencies();
  }

  final List<String> provinces = [
    'An Giang', 'Bà Rịa-Vũng Tàu', 'Bắc Giang',
    'Bắc Kạn', 'Bạc Liêu', 'Bắc Ninh',
    'Bến Tre', 'Bình Định', 'Bình Dương',
    'Bình Phước', 'Bình Thuận', 'Cà Mau',
    'Cao Bằng', 'Đắk Lắk', 'Đắk Nông',
    'Điện Biên', 'Đồng Nai', 'Đồng Tháp',
    'Gia Lai', 'Hà Giang', 'Hà Nam',
    'Hà Tĩnh', 'Hải Dương', 'Hậu Giang',
    'Hòa Bình', 'Hưng Yên', 'Khánh Hòa',
    'Kiên Giang', 'Kon Tum', 'Lai Châu',
    'Lâm Đồng', 'Lạng Sơn', 'Lào Cai',
    'Long An', 'Nam Định', 'Nghệ An',
    'Ninh Bình', 'Ninh Thuận', 'Phú Thọ',
    'Phú Yên', 'Quảng Bình', 'Quảng Nam',
    'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị',
    'Sóc Trăng', 'Sơn La', 'Tây Ninh',
    'Thái Bình', 'Thái Nguyên', 'Thanh Hóa',
    'Thừa Thiên-Huế', 'Tiền Giang', 'Trà Vinh',
    'Tuyên Quang', 'Vĩnh Long', 'Vĩnh Phúc',
    'Yên Bái', 'Phú Thọ', 'Hà Nội', 'Hồ Chí Minh City',
    'Hải Phòng', 'Đà Nẵng'
  ];

  List fields = [
    {
      "hintText": "Name",
      "value": "",
      "controller": TextEditingController() // Name controller
    },
    {
      "hintText": "Email",
      "value": "",
      "controller": TextEditingController() // Name controller
    },
    {
      "hintText": "Nation",
      "value": "",
    },
    {
      "hintText": "City",
      "value": "",
    },
    {
      "hintText": "Birthday",
      "value": "",
      "controller": TextEditingController(), // Height controller
    },
    {
      "hintText": "Height (cm)",
      "value": "",
      "controller": TextEditingController(), // Height controller
    },
    {
      "hintText": "Weight (kg)",
      "value": "",
      "controller": TextEditingController(), // Weight controller
    },
    {
      "hintText": "Phone number",
      "value": "",
      "controller": TextEditingController(), // Phone number controller
    },
    {
      "hintText": "Shoe size",
      "value": "",
      "controller": TextEditingController(), // Shoe size controller
    },
    {
      "hintText": "Shirt size",
      "value": "",
    },
    {
      "hintText": "Trouser size",
      "value": "",
    },
  ];

  void createAccountInformation() async {
    final profile = CreateUpdateProfile(
      user_id: userId,
      name: fields[0]["controller"].text,
      country: fields[2]["value"] ?? "",
      city: fields[3]["value"] ?? "",
      gender: gender?.toUpperCase(),
      dateOfBirth: fields[4]["controller"].text,
      height: (fields[5]["controller"].text != "") ? int.parse(fields[5]["controller"].text) : null,
      weight: (fields[6]["controller"].text != "") ? int.parse(fields[6]["controller"].text) : null,
      shoeSize: (fields[8]["controller"].text != "") ? int.parse(fields[8]["controller"].text) : null,
      shirtSize: fields[9]["value"],
      trouserSize: fields[10]["value"],
    );
    print(profile);

    final data = await callCreateAPI('account/profile', profile.toJson(), "");
    showNotification(context, 'Notice', "Successfully updated",
        onPressed: () {
          Navigator.pop(context);
        }
    );
    // Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    print(userId);
    print(email);
    print(phoneNumber);
    print(fields[2]["value"] ?? "");
    print(fields[3]["value"] ?? "");
    print("type: ${fields[8]["value"]}");
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Account Information", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              // if(isLoading == false)...[
                MainWrapper(
                  child: Column(
                    children: [
                      CustomTextButton(
                        onPressed: () {},
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/img/community/ptit_logo.png",
                                  width: 100,
                                  height: 100,
                                )
                            ),
                            const SizedBox(
                              height: 120,
                              width: 100,
                            ),
                            Positioned(
                              bottom: 10,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: TColor.PRIMARY
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: TColor.PRIMARY_TEXT,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: media.height * 0.015,),

                      // Information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Information",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                          SizedBox(height: media.height * 0.02),
                          Column(
                            children: [
                              for(int i = 0; i < 2; i++)...[
                                CustomTextFormField(
                                  controller: fields[i]["controller"],
                                  // initialValue: fields[i]["controller"].text ?? fields[i]["value"],
                                  decoration: CustomInputDecoration(
                                    // hintText: fields[i]["hintText"],
                                    label: Text(
                                      fields[i]["hintText"],
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.NORMAL,
                                      ),
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  ),
                                  keyboardType: TextInputType.text,
                                  noneEditable: (i == 1) ? true : false,
                                ),
                                SizedBox(height: media.height * 0.015,)
                              ],
                              for(int i = 2; i < 4; i++)...[
                                CustomMainButton(
                                  verticalPadding: 22,
                                  borderWidth: 2,
                                  borderWidthColor: TColor.BORDER_COLOR,
                                  background: Colors.transparent,
                                  horizontalPadding: 25,
                                  onPressed: () async {
                                    String result = "";
                                    if(i == 2) {
                                      result = await showChoiceList(context, ["Viet Nam"]);
                                    }
                                    else {
                                      result = await showChoiceList(context, provinces);
                                    }
                                    setState(() {
                                      fields[i]["value"] = result;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${fields[i]["value"] ?? fields[i]["hintText"]}",
                                        style: TxtStyle.largeTextDesc,
                                      ),
                                      Transform.rotate(
                                        angle: -90 * 3.14 / 180,
                                        child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: TColor.DESCRIPTION,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if(i == 2) SizedBox(height: media.height * 0.02,),
                              ],

                            ],
                          )
                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),

                      // Health Information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Health Information",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                          SizedBox(height: media.height * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for(var x in ["male", "female"])...[
                                Container(
                                  height: 60,
                                  width: media.width * 0.46,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: TColor.BORDER_COLOR,
                                          width: 2
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: x,
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value;
                                          });
                                        },
                                        fillColor: MaterialStateProperty.all<Color>(
                                          const Color(0xffcdcdcd),
                                        ),
                                      ),
                                      Text(
                                        x[0].toUpperCase() + x.substring(1),
                                        style: const TextStyle(
                                            color: Color(0xffcdcdcd),
                                            fontSize: 15
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                          SizedBox(height: media.height * 0.015,),
                          CustomTextFormField(
                            controller: fields[4]["controller"],
                            // initialValue: fields[4]["value"],
                            decoration: CustomInputDecoration(
                              label: Text(
                                fields[4]["hintText"],
                                style: TextStyle(
                                  color: TColor.DESCRIPTION,
                                  fontSize: FontSize.NORMAL,
                                ),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: media.height * 0.015,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: media.width * 0.46,
                                child: CustomTextFormField(
                                  controller: fields[5]["controller"],
                                  // initialValue: fields[5]["value"],
                                  decoration: CustomInputDecoration(
                                    // hintText: fields[5]["hintText"],
                                      label: Text(
                                        fields[5]["hintText"],
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.NORMAL,
                                        ),
                                      ),
                                      floatingLabelBehavior: FloatingLabelBehavior.auto
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: media.width * 0.46,
                                child: CustomTextFormField(
                                  controller: fields[6]["controller"],
                                  // initialValue: fields[6]["value"],
                                  decoration: CustomInputDecoration(
                                    // hintText: fields[6]["hintText"],
                                      label: Text(
                                        fields[6]["hintText"],
                                        style: TextStyle(
                                          color: TColor.DESCRIPTION,
                                          fontSize: FontSize.NORMAL,
                                        ),
                                      ),
                                      floatingLabelBehavior: FloatingLabelBehavior.auto
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),

                      // Additional information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Additional Information",
                            style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                          SizedBox(height: media.height * 0.02,),
                          for(int i = 7; i < 9; i++)...[
                            CustomTextFormField(
                              controller: fields[i]["controller"],
                              // initialValue: fields[i]["value"],
                              decoration: CustomInputDecoration(
                                // hintText: fields[i]["hintText"],
                                  label: Text(
                                    fields[i]["hintText"],
                                    style: TextStyle(
                                      color: TColor.DESCRIPTION,
                                      fontSize: FontSize.NORMAL,
                                    ),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto
                              ),
                              noneEditable: (i == 7) ? true : false,
                              keyboardType: (i == 7) ? TextInputType.text : TextInputType.number,
                            ),
                            SizedBox(height: media.height * 0.015,),
                          ],
                          for(int i = 9; i < 11; i++)...[
                            CustomMainButton(
                              verticalPadding: 22,
                              borderWidth: 2,
                              borderWidthColor: TColor.BORDER_COLOR,
                              background: Colors.transparent,
                              horizontalPadding: 25,
                              onPressed: () async {
                                String result = await showChoiceList(context, [
                                  "XS", "S", "M", "L", "XL", "XXL"
                                ]);
                                setState(() {
                                  fields[i]["value"] = result;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${fields[i]["value"] ?? fields[i]["hintText"]}",
                                    style: TxtStyle.largeTextDesc,
                                  ),
                                  Transform.rotate(
                                    angle: -90 * 3.14 / 180,
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: TColor.DESCRIPTION,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: media.height * 0.015,),
                          ]
                        ],
                      ),
                      SizedBox(height: media.height * 0.02,),

                      Column(
                        children: [
                          SizedBox(
                            width: media.width,
                            child: CustomMainButton(
                              background: Colors.transparent,
                              borderWidth: 2.0,
                              borderWidthColor: TColor.PRIMARY,
                              horizontalPadding: 0,
                              onPressed: () {
                                Navigator.pushNamed(context, "/address");
                              },
                              child: Text(
                                "Add address",
                                style: TextStyle(
                                    color: TColor.PRIMARY,
                                    fontSize: FontSize.LARGE,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              // ]
              // else...[
              //   Loading()
              // ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrapper(
          child: Container(
            margin: EdgeInsets.fromLTRB(media.width * 0.025, 15, media.width * 0.025, media.width * 0.025),
            child: CustomMainButton(
              horizontalPadding: 0,
              onPressed: createAccountInformation,
              child: Text(
                "Save",
                style: TextStyle(
                    color: TColor.PRIMARY_TEXT,
                    fontSize: FontSize.LARGE,
                    fontWeight: FontWeight.w800
                ),
              ),
            ),
          )
      ),
    );
  }
}
