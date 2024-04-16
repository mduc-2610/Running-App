import 'package:flutter/material.dart';
import 'package:running_app/utils/common_widgets/input_decoration.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/text_form_field.dart';
import 'package:running_app/utils/constants.dart';

class SearchFilter extends StatefulWidget {
  // For filter
  final VoidCallback? filterOnPressed;
  // For search
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onPrefixPressed;
  final VoidCallback? onClearChanged;
  final bool? showClearButton;

  SearchFilter({
    required this.hintText,
    this.controller,
    this.filterOnPressed,
    this.onFieldSubmitted,
    this.onPrefixPressed,
    this.onClearChanged,
    this.showClearButton,
    super.key
  });

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

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
              borderRadius: BorderRadius.circular(10),
          ),
          child: CustomTextFormField(
            controller: widget.controller,
            decoration: CustomInputDecoration(
                hintText: widget.hintText,
                prefixIcon: Icon(Icons.search, color: TColor.DESCRIPTION),
                borderSide: 1,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20
                )
            ),
            keyboardType: TextInputType.text,
            onFieldSubmitted: widget.onFieldSubmitted,
            onPrefixPressed: widget.onPrefixPressed,
            showClearButton: widget.showClearButton,
            onClearChanged: widget.onClearChanged,
          ),
        ),
        CustomTextButton(
          onPressed: widget.filterOnPressed ?? () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                    vertical: 10,
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
              color: TColor.BORDER_COLOR,
              width: 1.0,
            )),
          ),
          child: Icon(Icons.filter_list_rounded, color: TColor.PRIMARY_TEXT,),
        )
      ],
    );
  }
}
