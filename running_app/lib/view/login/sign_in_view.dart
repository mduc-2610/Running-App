import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/login.dart';
import 'package:running_app/models/account/performance.dart';
import 'package:running_app/models/account/privacy.dart';
import 'package:running_app/models/account/profile.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/form/checkbox.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_notification.dart';
import 'package:running_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
  }

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

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    print(usernameController.text);
    print(passwordController.text);
    Login login = Login(
      username: usernameController.text,
      password: passwordController.text,
    );
    // try {
      final tokenResponse = await callCreateAPI(
          'account/login',
          login.toJson(), "");
      print(tokenResponse);
      var token;
      if(tokenResponse["error"] != null) {
        showNotification(context, 'Error', tokenResponse["error"] ?? "");
      }
      else {
        token = tokenResponse["token"];
        Provider.of<TokenProvider>(context, listen: false).setToken(token);

        List<dynamic> users = await callListAPI('account/user', User.fromJson, token);
        final userId = users.firstWhere((element) => element.username == usernameController.text).id;

        DetailUser user = await callRetrieveAPI('account/user', userId, null, DetailUser.fromJson, token);
        // Performance userPerformance = await callRetrieveAPI(null, null, user.performance, Performance.fromJson, token);
        // DetailProfile userProfile = await callRetrieveAPI(null, null, user.profile, DetailProfile.fromJson, token);
        // Privacy userPrivacy = await callRetrieveAPI(null, null, user.privacy, Privacy.fromJson, token);
        // Activity userActivity = await callRetrieveAPI(null, null, user.activity, Activity.fromJson, token);

        Provider.of<UserProvider>(context, listen: false).setUser(user,);
        // Provider.of<UserProvider>(context, listen: false).userActivity = userActivity;
        // Provider.of<UserProvider>(context, listen: false).userPerformance = userPerformance;
        // Provider.of<UserProvider>(context, listen: false).userProfile = userProfile;
        // Provider.of<UserProvider>(context, listen: false).userPrivacy = userPrivacy;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('user', jsonEncode(user.toJson()));
        // await prefs.setString('userActivity', jsonEncode(userActivity.toJson()));
        // await prefs.setString('userPerformance', jsonEncode(userPerformance.toJson()));
        // await prefs.setString('userProfile', jsonEncode(userProfile.toJson()));
        // await prefs.setString('userPrivacy', jsonEncode(userPrivacy.toJson()));

        Navigator.pushNamed(context, '/home', arguments: {
          'token': token
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.PRIMARY_BACKGROUND,
      body: SingleChildScrollView(
        child: SizedBox(
          height: media.height,
          child: Stack(children: [
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
            SizedBox(height: media.height * 0.06,),
            MainWrapper(
              child: Container(
                margin: EdgeInsets.fromLTRB(media.width * 0.015, media.height * 0.32, media.width * 0.015, 0),
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
                        SizedBox(height: media.height * 0.02,),
                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                            // hintText: "Enter a Username",
                            label: Text(
                              "Enter a Username",
                              style: TextStyle(
                                color: TColor.DESCRIPTION,
                                fontSize: FontSize.NORMAL,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          // validator: _validateEmail,
                          onSaved: (String? value) {
                            // _email = value ?? '';
                          },
                        ),
                        SizedBox(height: media.height * 0.015),
                        CustomTextFormField(
                          decoration: CustomInputDecoration(
                            // hintText: "Enter a Password",
                            label: Text(
                              "Enter a Password",
                              style: TextStyle(
                                color: TColor.DESCRIPTION,
                                fontSize: FontSize.NORMAL,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          controller: passwordController,
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
                                child: Text(
                                    "Forgot password ?",
                                    style: TextStyle(
                                      color: TColor.PRIMARY,
                                      fontSize: FontSize.NORMAL,
                                      fontWeight: FontWeight.w500,
                                    )
                                )
                            )
                          ]
                        ),
                        SizedBox(height: media.height * 0.01,),
                        CustomMainButton(
                          horizontalPadding: media.width * 0.36,
                          // onPressed: () {
                          //   Navigator.pushReplacementNamed(context, '/home');
                          // },
                            onPressed: signIn,
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
                            child: Text(
                              'Sign Up',
                                style: TextStyle(
                                  color: TColor.PRIMARY,
                                  fontSize: FontSize.NORMAL,
                                  fontWeight: FontWeight.w500,
                                )
                            )
                        )
                      ],
                    )
                  ]
                ),
        
        
              )
            )
          ]),
        ),
      )
    );
  }
}
