import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class CommentCreate extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback submitOnPressed;
  final VoidCallback chooseImageOnPressed;
  const CommentCreate({
    required this.controller,
    required this.submitOnPressed,
    required this.chooseImageOnPressed,
    super.key
  });

  @override
  State<CommentCreate> createState() => _CommentCreateState();
}

class _CommentCreateState extends State<CommentCreate> {
  void submitDone(BuildContext context) {
    widget.controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: TColor.BORDER_COLOR)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: media.width * 0.75,
            child: CustomTextFormField(
              controller: widget.controller,
              decoration: CustomInputDecoration(
                hintText: "Write your comment here",
                borderSide: 0,
                borderRadius: BorderRadius.circular(0),
              ),
              keyboardType: TextInputType.text,
              clearIcon: true,
            ),
          ),
          MainWrapper(
            leftMargin: 0,
            topMargin: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.chooseImageOnPressed,
                  child: Icon(
                    Icons.image,
                    color: TColor.PRIMARY_TEXT,
                    size: 30,
                  ),
                ),
                SizedBox(width: media.width * 0.03,),
                GestureDetector(
                  onTap: () {
                    widget.submitOnPressed.call();
                    submitDone(context);
                  },
                  child: Icon(
                    CupertinoIcons.paperplane,
                    color: TColor.PRIMARY_TEXT,
                    size: 30,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
