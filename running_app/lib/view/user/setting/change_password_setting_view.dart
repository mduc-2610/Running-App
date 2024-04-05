import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/default_background_layout.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class ChangePasswordSettingView extends StatefulWidget {
  const ChangePasswordSettingView({super.key});

  @override
  _ChangePasswordSettingViewState createState() => _ChangePasswordSettingViewState();
}

class _ChangePasswordSettingViewState extends State<ChangePasswordSettingView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
  TextEditingController();

  Future<void> _changePassword() async {
    // final String url = 'http://your_api_url/change-password/';
    // final response = await http.post(
    //   Uri.parse(url),
    //   body: {
    //     'old_password': _oldPasswordController.text,
    //     'new_password': _newPasswordController.text,
    //     'confirm_new_password': _confirmNewPasswordController.text,
    //   },
    // );
    //
    // if (response.statusCode == 200) {
    //   // Password changed successfully
    //   // Handle success scenario
    // } else {
    //   // Password change failed
    //   // Handle error scenario
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
      body: DefaultBackgroundLayout(
        child: Stack(
          children: [
            MainWrapper(
              topMargin: media.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/img/login/logo.svg'
                  ),
                ],
              ),
            ),
            MainWrapper(
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

                  SizedBox(
                    width: media.width,
                    child: CustomMainButton(
                      horizontalPadding: 0,
                      onPressed: _changePassword,
                      child: Text(
                        'Change password',
                        style: TextStyle(
                          color: TColor.PRIMARY_TEXT,
                          fontSize: FontSize.NORMAL,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}