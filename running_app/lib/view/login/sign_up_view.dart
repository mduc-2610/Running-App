import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/button/back_button.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_notification.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  void signUp() async {
    String username = signUpFields[0]['controller'].text;
    String email = signUpFields[1]['controller'].text;
    String phoneNumber = signUpFields[2]['controller'].text;
    String password = signUpFields[3]['controller'].text;
    String confirmPassword = signUpFields[4]['controller'].text;
    CreateUser user = CreateUser(
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
    );
    if(password != confirmPassword) {
      showNotification(context, 'Error', "Confirm password doesn't match password");
    }
    else {
      final data = await callCreateAPI('account/user', user.toJson(), "");
      print(data);
      Navigator.pushNamed(context, '/profile_create', arguments: {
        "id": data["id"],
        "email": data["email"],
        "phoneNumber": data["phone_number"]
      });
    }

  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    }
    // Add additional validation rules if necessary
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email.';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    // Add additional validation rules if necessary
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != password) {
      return 'Passwords do not match.';
    }
    return null;
  }

  List<Map<String, dynamic>> signUpFields = [
    {
      'fieldType': 'Username',
      'hintText': 'Enter a Username',
      'keyboardType': TextInputType.text,
      'controller': TextEditingController(),
      // 'validator': validateUsername,
    },
    {
      'fieldType': 'Email',
      'hintText': 'Enter an Email',
      'keyboardType': TextInputType.emailAddress,
      'controller': TextEditingController(),
      // 'validator': validateEmail,
    },
    {
      'fieldType': 'Phone number',
      'hintText': 'Enter a Phone number',
      'keyboardType': TextInputType.number,
      'controller': TextEditingController(),
      // 'validator': validateEmail,
    },
    {
      'fieldType': 'Password',
      'hintText': 'Enter a Password',
      'keyboardType': TextInputType.visiblePassword,
      'obscureText': true,
      'controller': TextEditingController(),
      // 'validator': validatePassword,
    },
    {
      'fieldType': 'Confirm Password',
      'hintText': 'Enter the Password again',
      'keyboardType': TextInputType.visiblePassword,
      'obscureText': true,
      'controller': TextEditingController(),
      // 'validator':validateConfirmPassword
    }
  ];

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
              MainWrapper(
                  topMargin: media.height * 0.06,
                  child: CustomBackButton(context: context)
              ),
              MainWrapper(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(media.width * 0.015, media.height * 0.35, media.width * 0.015, 0),
                    child: Column(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: TColor.PRIMARY_TEXT,
                              fontSize: FontSize.TITLE,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: media.width * 0.02,),

                        for (var field in signUpFields)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomTextFormField(
                              decoration: CustomInputDecoration(
                                // labelText: field['fieldType'],
                                // hintText: field['hintText'],
                                label: Text(
                                  field["hintText"],
                                  style: TextStyle(
                                    color: TColor.DESCRIPTION,
                                    fontSize: FontSize.NORMAL,
                                  ),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                              ),
                              keyboardType: field['keyboardType'],
                              obscureText: field['obscureText'] ?? false,
                              controller: field['controller'],

                              // validator: field['validator'],
                            ),
                          ),
                        SizedBox(height: media.width * 0.03),
                        CustomMainButton(
                            horizontalPadding: media.width * 0.35,
                            onPressed: signUp,
                            //     () async {
                            //   bool isValid = true;
                            //
                            //   // Validate all form fields
                            //   for (var field in signUpFields) {
                            //     if (field['validator'] != null) {
                            //       FormFieldValidator<String>? validator = field['validator'];
                            //       String? error = validator!(field['controller'].text);
                            //       print(error);
                            //       if (error != null) {
                            //         isValid = false;
                            //         break;
                            //       }
                            //     }
                            //   }
                            //   if(isValid) {
                            //     final username = signUpFields[0]['controller'].text;
                            //     final email = signUpFields[1]['controller'].text;
                            //     final password = signUpFields[2]['controller'].text;
                            //     final confirmPassword = signUpFields[3]['controller'].text;
                            //
                            //     _createUser(username, email, password, confirmPassword);
                            //   }
                            //   Navigator.pushReplacementNamed(context, '/profile_create');
                            // },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.BUTTON,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                        ),
                      ],
                    ),
                  )
              )
            ]),
          ),
        )
    );
  }
}

