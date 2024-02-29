import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/common_widgets/back_button.dart';
import '../../utils/common_widgets/checkbox.dart';
import '../../utils/common_widgets/input_decoration.dart';
import '../../utils/common_widgets/main_button.dart';
import '../../utils/common_widgets/text_form_field.dart';
import '../../utils/constants.dart';
import '../../utils/common_widgets/main_wrapper.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _isChecked = false;
  List logoButton = [
    {
      "assets": "assets/img/login/google_logo.svg",
    },
    {
      "assets": "assets/img/login/facebook_logo.svg",
    },
    {
      "assets": "assets/img/login/twitter_logo.svg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.PRIMARY_BACKGROUND,
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, media.height * 0.17, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/img/login/logo.svg',
                width: media.width * 0.3,
                fit: BoxFit.contain,
              )
            ]
          ),
        ),
        MainWrapper(
          child: CustomBackButton(context: context)
        ),
        MainWrapper(
          child: Container(
            margin: EdgeInsets.fromLTRB(media.width * 0.015, media.height * 0.35, media.width * 0.015, 0),
            child: Column(
              children: [
                // ---SignIn section---
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.TITLE,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: media.height * 0.01,),
                    CustomTextFormField(
                      decoration: CustomInputDecoration(
                        hintText: "Enter a Username",
                      ),
                      keyboardType: TextInputType.text,
                      // validator: _validateEmail,
                      onSaved: (String? value) {
                        // _email = value ?? '';
                      },
                    ),
                    SizedBox(height: media.height * 0.01),
                    CustomTextFormField(
                      decoration: CustomInputDecoration(
                        hintText: "Enter a Password",
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      // validator: _validatePassword,
                      onSaved: (String? value) {
                        // _password = value ?? '';
                      },
                    ),
                    SizedBox(height: media.height * 0.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomCheckbox(
                                value: _isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isChecked = newValue ?? false;
                                  });
                                }
                            ),
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                color: TColor.DESCRIPTION,
                                fontSize: FontSize.NORMAL
                              ),
                            )
                          ]
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                                "Forgot password ?",
                                style: TextStyle(
                                  fontSize: FontSize.NORMAL,
                                ),
                            )
                        )
                      ]
                    ),
                    SizedBox(height: media.height * 0.01,),
                    CustomMainButton(
                      horizontalPadding: media.width * 0.36,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.BUTTON,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ),
                  ],
                ),

                SizedBox(height: media.height * 0.02),
                // ---Oauth section---
                Column(
                  children: [
                    SizedBox(
                      width: media.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/img/login/rectangle_1.svg",
                          ),
                          const Text(
                            "Or continue with",
                            style: TextStyle(
                              color: Color(0xff4b576b),
                              fontSize: FontSize.NORMAL,
                            )
                          ),
                          SvgPicture.asset(
                            "assets/img/login/rectangle_1.svg",
                          )

                        ]
                      ),
                    ),
                    SizedBox(height: media.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: logoButton.map((button) {
                        return TextButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color?>(TColor.SECONDARY_BACKGROUND),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    vertical: media.height * 0.03,
                                    horizontal: media.width * 0.1
                                ),
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(color: Color(0xff495466), width: 2.0), // Set the border color and width
                              ),
                            ),
                            child: SvgPicture.asset(
                              button["assets"],
                            ));
                      }).toList(),
                    )
                  ]
                ),

                SizedBox(height: media.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User?",
                      style: TextStyle(
                        color: TColor.DESCRIPTION,
                        fontSize: FontSize.NORMAL,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign_up');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: FontSize.NORMAL,
                          ),
                        )
                    )
                  ],
                )
              ]
            ),


          )
        )
      ])
    );
  }
}
