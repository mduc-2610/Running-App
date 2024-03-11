import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class SearchFilter extends StatelessWidget {
  final String hintText;
  const SearchFilter({
    required this.hintText,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: media.width * 0.78,
          height: media.height * 0.05,
          decoration: BoxDecoration(
              color: TColor.SECONDARY_BACKGROUND,
              borderRadius: BorderRadius.circular(10)
          ),
          child: CustomTextFormField(
            decoration: CustomInputDecoration(
                hintText: hintText,
                prefixIcon: Icon(Icons.search, color: TColor.DESCRIPTION),
                borderSide: 0,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20
                )
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        CustomTextButton(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 0
                )
            ),
            backgroundColor: MaterialStateProperty.all<Color?>(
                TColor.SECONDARY_BACKGROUND
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            side: MaterialStateProperty.all(BorderSide(
              color: TColor.BORDER_COLOR, // Set border color here
              width: 1.0, // Set border width here
            )),
          ),
          child: Icon(Icons.filter_list_rounded, color: TColor.PRIMARY_TEXT,),
        )
      ],
    );
  }
}
