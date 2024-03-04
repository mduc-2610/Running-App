import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_app/utils/common_widgets/main_button.dart';
import 'package:running_app/utils/constants.dart';

class NotificationBox extends StatefulWidget {
  final String? svgNotify;
  final Widget? iconNotify;
  final String? title;
  final String? description;

  const NotificationBox({
    this.svgNotify,
    this.iconNotify,
    this.title,
    this.description,
    Key? key,
  }) : super(key: key);

  @override
  _NotificationBoxState createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  set isVisible(bool value) {
    setState(() {
      _isVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Visibility(
      visible: _isVisible,
      child: Center(
        child: IntrinsicHeight(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: media.width * 0.05,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 33,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: TColor.SECONDARY_BACKGROUND,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: TColor.BORDER_COLOR,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.svgNotify != null) ...[
                  SvgPicture.asset(
                    widget.svgNotify!,
                  ),
                  SizedBox(height: media.height * 0.02),
                ] else if (widget.iconNotify != null) ...[
                  widget.iconNotify!,
                  SizedBox(height: media.height * 0.02),
                ],
                if (widget.title != null) ...[
                  Text(
                    widget.title!,
                    style: TextStyle(
                      color: TColor.PRIMARY_TEXT,
                      fontSize: FontSize.TITLE,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: media.height * 0.02),
                ],
                if (widget.description != null) ...[
                  Text(
                    widget.description!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TColor.DESCRIPTION,
                      fontSize: FontSize.NORMAL,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: media.height * 0.02),
                ],
                CustomMainButton(
                  horizontalPadding: media.width * 0.33,
                  verticalPadding: 15,
                  onPressed: () {
                    isVisible = false;
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      color: TColor.PRIMARY_TEXT,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
