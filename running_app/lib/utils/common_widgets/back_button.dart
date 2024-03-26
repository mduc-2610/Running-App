import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/constants.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext context;
  final VoidCallback? onPressed;

  const CustomBackButton({
    Key? key,
    required this.context,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: TColor.PRIMARY_TEXT,
      ),
      onPressed: () {
        if(onPressed != null) {
          onPressed?.call();
        }
        Navigator.pop(context);
      },
    );
  }
}
