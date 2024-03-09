import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class AccountInformationSettingView extends StatefulWidget {
  const AccountInformationSettingView({super.key});

  @override
  State<AccountInformationSettingView> createState() => _AccountInformationSettingViewState();
}

class _AccountInformationSettingViewState extends State<AccountInformationSettingView> {
  String? gender = "";
  List fields = [
    {
      "hintText": "Name",
    },
    {
      "hintText": "Email",
    },
    {
      "hintText": "Nation",
    },
    {
      "hintText": "City",
    },
    {
      "hintText": "Birthday",
    },
    {
      "hintText": "Height",
    },
    {
      "hintText": "Weight",
    },
    {
      "hintText": "Phone number",
    },
    {
      "hintText": "Address",
    },
    {
      "hintText": "Shoe size",
    },
    {
      "hintText": "Shirt size",
    },
    {
      "hintText": "Trouser size",
    },
  ];
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: media.height * 1.5,
          child: CustomStack(
            backgroundHeight: media.height * 1.5,
            children: [
              MainWrapper(
                child: Column(
                  children: [
                    Header(title: "Account Information", noIcon: true,),
                    SizedBox(height: media.height * 0.015,),
          
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
                          SizedBox(
                            height: 120,
                            width: 100,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(8),
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
                        SizedBox(height: media.height * 0.015,),
                        Column(
                          children: [
                            for(int i = 0; i < 2; i++)...[
                              CustomTextFormField(
                                decoration: CustomInputDecoration(
                                  hintText: fields[i]["hintText"],
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: media.height * 0.01,)
                            ],
                          for(int i = 0; i < 2; i++)...[
                            SizedBox(
                              height: 60,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                // value: selectedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    // selectedValue = newValue;
                                  });
                                },
                                items: [
                                  for(int i = 0; i < 5; i++)
                                  DropdownMenuItem(
                                    value: "Option $i",
                                    child: Text(
                                        "Option $i",
                                      style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.SMALL,
                                      ),
                                    ),
                                  ),
                                ],
                                decoration: CustomInputDecoration(
                                  hintText: fields[2]["hintText"]
                                ),
                                dropdownColor: Colors.black,
          
                              ),
                            ),
                            SizedBox(height: media.height * 0.01,),
                          ]
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
                        SizedBox(height: media.height * 0.01,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for(var x in ["male", "female"])...[
                              Container(
                                height: 50,
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
                                          Color(0xffcdcdcd),
                                      ),
                                    ),
                                    Text(
                                      x[0].toUpperCase() + x.substring(1),
                                      style: TextStyle(
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
                        SizedBox(height: media.height * 0.01,),
                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                            hintText: fields[4]["hintText"],
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: media.height * 0.01,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.46,
                              child: CustomTextFormField(
                                decoration: CustomInputDecoration(
                                  hintText: fields[5]["hintText"],
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.46,
                              child: CustomTextFormField(
                                decoration: CustomInputDecoration(
                                  hintText: fields[6]["hintText"],
                                ),
                                keyboardType: TextInputType.text,
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
                        SizedBox(height: media.height * 0.01,),
                        for(int i = 7; i < 10; i++)...[
                          CustomTextFormField(
                            decoration: CustomInputDecoration(
                              hintText: fields[i]["hintText"],
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: media.height * 0.01,),
                        ],
                        for(int i = 10; i < 12; i++)...[
                          SizedBox(
                            height: 60,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              // value: selectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  // selectedValue = newValue;
                                });
                              },
                              items: [
                                for(int i = 0; i < 5; i++)
                                  DropdownMenuItem(
                                    value: "Option $i",
                                    child: Text(
                                      "Option $i",
                                      style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: FontSize.SMALL,
                                      ),
                                    ),
                                  ),
                              ],
                              decoration: CustomInputDecoration(
                                  hintText: fields[i]["hintText"]
                              ),
                              dropdownColor: Colors.black,

                            ),
                          ),
                          SizedBox(height: media.height * 0.01,),
                        ]
                      ],
                    ),
                    SizedBox(height: media.height * 0.02,),

                    SizedBox(
                      width: media.width,
                      child: CustomMainButton(
                        horizontalPadding: 0,
                        onPressed: () {},
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
