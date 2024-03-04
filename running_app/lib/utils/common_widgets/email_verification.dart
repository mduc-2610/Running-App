import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/back_button.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/stack.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/common_widgets/verify_code_form.dart';
import 'package:running_app/utils/constants.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomStack(
        children: [
          MainWrapper(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Header(title: "", noIcon: true,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/img/util/mailbox_envelop.svg",
                    ),
                    SizedBox(height: media.height * 0.015,),
                    Text(
                      "Verify your email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.LARGE,
                        fontWeight: FontWeight.w900
                      ),
                    ),
                    SizedBox(height: media.height * 0.015,),
                    Container(
                      width: media.width * 0.85,
                      child: Text(
                        "Enter the email associated with your account we’ll send email with password to verify",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TColor.DESCRIPTION,
                            fontSize: FontSize.SMALL,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: media.height * 0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int i = 0; i < 4; i++)...[
                          Container(
                            width: media.width * 0.16,
                            height: media.height * 0.1,
                            child: CustomTextFormField(
                              decoration: CustomInputDecoration(
                                fillColor: TColor.SECONDARY_BACKGROUND,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 26,
                                  vertical: 20
                                )
                              ),
                              inputTextStyle: TextStyle(
                                color: TColor.PRIMARY_TEXT,
                                fontSize: FontSize.LARGE,
                                fontWeight: FontWeight.w900
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                            ),
                          ),
                          if(i != 3) SizedBox(width: media.width * 0.03,)
                        ]
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomMainButton(
                      horizontalPadding: media.width * 0.32,
                      onPressed: () {},
                      child: Text(
                        "Verify Email",
                        style: TextStyle(
                            color: TColor.PRIMARY_TEXT,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(height: media.height * 0.02,),
                    CustomMainButton(
                      horizontalPadding: media.width * 0.29,
                      onPressed: () {},
                      child: Text(
                        "Open mail app",
                        style: TextStyle(
                            color: TColor.PRIMARY,
                            fontSize: FontSize.LARGE,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      background: Colors.transparent,
                      borderWidth: 2,
                      borderWidthColor: TColor.PRIMARY,
                      borderRadius: 16,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
