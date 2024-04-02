import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';

class DescriptionText extends StatefulWidget {
  final String description;
  final VoidCallback onTap;
  bool showFullText;
  bool showViewMoreButton;

  DescriptionText({
    required this.description,
    required this.onTap,
    required this.showFullText,
    required this.showViewMoreButton,
    super.key
  });

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  @override
  Widget build(BuildContext context) {
    if(countTextLines(widget.description) > 2) {
      widget.showViewMoreButton = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: TxtStyle.descSectionNormal,
          maxLines: widget.showFullText ? null : 2,
        ),
        if(widget.showViewMoreButton)... [
          GestureDetector(
            onTap: widget.onTap,
            child: Text(
              widget.showFullText ? "Show less" : "Show more",
              style: TextStyle(
                  color: TColor.PRIMARY,
                  fontSize: FontSize.NORMAL,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline
              ),
            ),
          )
        ]
      ],
    );
  }
}
