import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

void showPasswordEntry(
    BuildContext context,
    {String? title,
    String? hintText,
    String? submitText,
    void Function(String)? onSubmitted,}
    ) {
  var media = MediaQuery.of(context).size;
  TextEditingController _passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: TColor.SECONDARY_BACKGROUND,
        title: Text(
          title ?? "Enter your password",
          style: TxtStyle.headSection,
          textAlign: TextAlign.center,
        ),
        content: Container(
          width: media.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: CustomInputDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // hintText: "Password"
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomMainButton(
                    verticalPadding: 8,
                    horizontalPadding: 12,
                    borderRadius: 8,
                    onPressed: () {
                      Navigator.pop(context);
                      if(onSubmitted != null)
                      onSubmitted(_passwordController.text);
                    },
                    child: Text(
                      submitText ?? "Confirm",
                      style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.LARGE,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    background: TColor.PRIMARY,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
