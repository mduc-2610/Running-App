import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';

class LimitLineText extends StatefulWidget {
  final String description;
  final VoidCallback onTap;
  bool showFullText;
  bool showViewMoreButton;
  TextStyle? style;
  int? char_in_line;
  LimitLineText({
    required this.description,
    required this.onTap,
    required this.showFullText,
    required this.showViewMoreButton,
    this.style,
    this.char_in_line,
    super.key
  });

  @override
  State<LimitLineText> createState() => _LimitLineTextState();
}

class _LimitLineTextState extends State<LimitLineText> {
  @override
  Widget build(BuildContext context) {
    if(countTextLines(widget.description, char_in_line: widget.char_in_line) > 2) {
      widget.showViewMoreButton = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: widget.style ?? TxtStyle.descSectionNormal,
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
