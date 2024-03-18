import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';


class ChoiceButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Map<String, dynamic> buttonState;
  final VoidCallback onPressed;
  const ChoiceButton({
    this.icon,
    required this.buttonState,
    required this.text,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return CustomTextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12
        ),
        decoration: BoxDecoration(
            color: buttonState["backgroundColor"],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 2,
                color: buttonState["borderColor"]
            )
        ),
        child: Row(
          children: [
            if(icon != null)...[
              Icon(
                icon,
                color: buttonState["iconColor"],
              ),
              SizedBox(width: media.width * 0.01,)
            ],
            Text(
              text,
              style: TextStyle(
                color: buttonState["textColor"],
                fontSize: FontSize.NORMAL,
              ),
            )
          ],
        ),
      ),
    );
  }
}
