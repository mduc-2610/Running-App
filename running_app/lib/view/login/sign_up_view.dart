import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/button/back_button.dart';
import 'package:running_app/utils/common_widgets/button/main_button.dart';
import 'package:running_app/utils/common_widgets/form/input_decoration.dart';
import 'package:running_app/utils/common_widgets/form/text_form_field.dart';
import 'package:running_app/utils/common_widgets/layout/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_modal_bottom/show_notification.dart';
import 'package:running_app/utils/constants.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  bool signUpPressed = false;

  late List<Map<String, dynamic>> signUpFields;

  @override
  void initState() {
    super.initState();

    signUpFields = [
      {
        'fieldType': 'Username',
        'hintText': 'Enter a Username',
        'keyboardType': TextInputType.text,
        'controller': TextEditingController(),
        'validator': (value) => validateUsername(value),
      },
      {
        'fieldType': 'Email',
        'hintText': 'Enter an Email',
        'keyboardType': TextInputType.emailAddress,
        'controller': TextEditingController(),
        'validator': (value) => validateEmail(value),
      },
      {
        'fieldType': 'Phone number',
        'hintText': 'Enter a Phone number',
        'keyboardType': TextInputType.phone,
        'controller': TextEditingController(),
        'validator': (value) => validatePhoneNumber(value),
      },
      {
        'fieldType': 'Password',
        'hintText': 'Enter a Password',
        'keyboardType': TextInputType.visiblePassword,
        'obscureText': true,
        'controller': TextEditingController(),
        'validator': (value) => validatePassword(value),
      },
      {
        'fieldType': 'Confirm Password',
        'hintText': 'Enter the Password again',
        'keyboardType': TextInputType.visiblePassword,
        'obscureText': true,
        'controller': TextEditingController(),
        'validator': (value) => validateConfirmPassword(value),
      }
    ];

    // for (var field in signUpFields) {
    //   field['controller'].addListener(() {
    //     setState(() {});
    //   });
    // }
  }

  @override
  void dispose() {
    for (var field in signUpFields) {
      field['controller'].dispose();
    }
    super.dispose();
  }

  void signUp() async {
    if (formKey.currentState?.validate() ?? false) {
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

      if (password != confirmPassword) {
        showNotification(context, 'Error', "Confirm password doesn't match password");
      } else {
        final data = await callCreateAPI('account/user', user.toJson(), "");
        print(data);
        Navigator.pushReplacementNamed(context, '/profile_create', arguments: {
          "id": data["id"],
          "email": data["email"],
          "phoneNumber": data["phone_number"],
          "username": username,
          "password": password,
        });
      }
    }
    setState(() {
      signUpPressed = true;
    });
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    }
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

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number.';
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    final passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.';
    }
    return null;
  }


  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != signUpFields[3]['controller'].text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.PRIMARY_BACKGROUND,
      body: SizedBox(
        height: media.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, media.height * 0.17, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/img/login/logo.svg',
                      width: media.width * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              MainWrapper(
                topMargin: media.height * 0.06,
                child: CustomBackButton(context: context),
              ),
              MainWrapper(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      media.width * 0.015, media.height * 0.35, media.width * 0.015, 0),
                  child: Column(
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.TITLE,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: media.width * 0.02),
                      Form(
                        key: formKey,
                        child: Column(
                          children: signUpFields.map((field) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  inputDecorationTheme: InputDecorationTheme(
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.SMALL,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    errorMaxLines: 5
                                  ),
                                ),
                                child: CustomTextFormField(
                                  decoration: CustomInputDecoration(
                                    label: Text(
                                      field['hintText'],
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
                                  validator: field['validator'],
                                  onChanged: (value) {
                                    if (signUpPressed && (formKey.currentState?.validate() ?? false)) {
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: media.width * 0.03),
                      CustomMainButton(
                        horizontalPadding: media.width * 0.35,
                        onPressed: signUp,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.BUTTON,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: media.height * 0.03,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
