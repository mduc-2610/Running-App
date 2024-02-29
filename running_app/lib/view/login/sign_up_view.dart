import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:running_app/models/account/user.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';

import '../../utils/constants.dart';
import '../../utils/common_widgets/input_decoration.dart';
import '../../utils/common_widgets/back_button.dart';
import '../../utils/common_widgets/text_form_field.dart';
import '../../utils/common_widgets/main_wrapper.dart';

import '../../services/api_service.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  Future<void> _createUser(String username, String email, String password, String confirmPassword) async {
    final userCreate = CreateUser(
        username: username,
        email: email,
        password: password
    );
    final data = await callCreateAPI('account/user', userCreate.toJson());
    print(data);
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    List<Map<String, dynamic>> signUpFields = [
      {
        'fieldType': 'Username',
        'hintText': 'Enter a Username',
        'keyboardType': TextInputType.text,
        'controller': TextEditingController(),
        'validator': validateUsername,
      },
      {
        'fieldType': 'Email',
        'hintText': 'Enter an Email',
        'keyboardType': TextInputType.emailAddress,
        'controller': TextEditingController(),
        'validator': validateEmail,
      },
      {
        'fieldType': 'Password',
        'hintText': 'Enter a Password',
        'keyboardType': TextInputType.visiblePassword,
        'obscureText': true,
        'controller': TextEditingController(),
        'validator': validatePassword,
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
                            hintText: field['hintText'],
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
                        onPressed: () async {
                          bool isValid = true;

                          // Validate all form fields
                          for (var field in signUpFields) {
                            if (field['validator'] != null) {
                              FormFieldValidator<String>? validator = field['validator'];
                              String? error = validator!(field['controller'].text);
                              print(error);
                              if (error != null) {
                                isValid = false;
                                break;
                              }
                            }
                          }
                          if(isValid) {
                            final username = signUpFields[0]['controller'].text;
                            final email = signUpFields[1]['controller'].text;
                            final password = signUpFields[2]['controller'].text;
                            final confirmPassword = signUpFields[3]['controller'].text;

                            _createUser(username, email, password, confirmPassword);
                          }
                        },
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
        ])
    );
  }
}
