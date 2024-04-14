import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';

class LimitTextLine extends StatefulWidget {
  final String description;
  final VoidCallback onTap;
  bool showFullText;
  bool showViewMoreButton;
  TextStyle? style;
  int? charInLine;
  int? maxLines;
  LimitTextLine({
    required this.description,
    required this.onTap,
    required this.showFullText,
    required this.showViewMoreButton,
    this.style,
    this.charInLine,
    this.maxLines,
    super.key
  });

  @override
  State<LimitTextLine> createState() => _LimitTextLineState();
}

class _LimitTextLineState extends State<LimitTextLine> {
  @override
  Widget build(BuildContext context) {
    print(countTextLines(widget.description, charInLine: widget.charInLine));
    if(countTextLines(widget.description, charInLine: widget.charInLine) > (widget.maxLines ?? 2)) {
      widget.showViewMoreButton = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: widget.style ?? TxtStyle.descSectionNormal,
          maxLines: widget.showFullText ? null : (widget.maxLines ?? 2),
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
