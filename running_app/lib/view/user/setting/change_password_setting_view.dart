import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:running_app/models/account/change_password.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/bottom_stick_button.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/show_notification.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/providers/token_provider.dart';
import 'package:running_app/utils/providers/user_provider.dart';

class ChangePasswordSettingView extends StatefulWidget {
  const ChangePasswordSettingView({super.key});

  @override
  _ChangePasswordSettingViewState createState() => _ChangePasswordSettingViewState();
}

class _ChangePasswordSettingViewState extends State<ChangePasswordSettingView> {
  String token = "";
  DetailUser? user;

  void getProviderData() {
    setState(() {
      token = Provider.of<TokenProvider>(context).token;
      user = Provider.of<UserProvider>(context).user;
    });
  }
  
  @override
  void didChangeDependencies() {
    getProviderData();
    super.didChangeDependencies();
  }
  
  void changePassword() async {
    final changePassword = ChangePassword(
      userId: user?.id,
      oldPassword: controller["Old password"]?.text,
      newPassword: controller["New password"]?.text,
      confirmNewPassword: controller["Confirm new password"]?.text,
    );
    
    print(changePassword);

    final data = await callCreateAPI(
        'account/user/change-password',
        changePassword.toJson(),
        token
    );
    if(data["error"] != null) {
      showNotification(context, "Error", data["error"]);
    } else {
      showNotification(context, "Success", data["message"], onPressed: () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }

    // print(data);
    // if(data["error"] == "Invalid old password") {
    // }
  }
  
  
  Map<String, TextEditingController> controller = {
    "Old password": TextEditingController(),
    "New password": TextEditingController(),
    "Confirm new password": TextEditingController(),
  };

  List fieldList = [
    {
      "label": "Old password",
    },
    {
      "label": "New password",
    },
    {
      "label": "Confirm new password",
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Header(title: "Change password", noIcon: true,),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: DefaultBackgroundLayout(
          child: Stack(
            children: [
              MainWrapper(
                topMargin: media.height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/img/login/logo.svg'
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MainWrapper(
                topMargin: media.height * 0.28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var field in fieldList)...[
                      CustomTextFormField(
                        decoration: CustomInputDecoration(
                          label: Text(
                           field["label"],
                           style: TxtStyle.normalTextDesc
                          )
                        ),
                        controller: controller[field["label"]],
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: media.height * 0.02,),
                    ],

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomStickButton(
        text: "Change password",
        onPressed: changePassword,
      ),
    );
  }
}