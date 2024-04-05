import 'package:flutter/material.dart';

import '../constants.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color fillColor;
  final Color checkColor;
  final BorderRadius borderRadius;
  final VisualDensity visualDensity;

  const CustomCheckbox({super.key, 
    required this.value,
    required this.onChanged,
    this.fillColor = Colors.grey,
    this.checkColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(5.0)),
    this.visualDensity = VisualDensity.compact,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: TColor.PRIMARY_BACKGROUND,

        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return TColor.PRIMARY;
            }
            return TColor.PRIMARY_BACKGROUND;
          }),
          checkColor: MaterialStateProperty.all<Color>(widget.checkColor),
          shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
          visualDensity: widget.visualDensity,
          side: BorderSide(
            color: TColor.PRIMARY, // Specify your border color here
            // width: , // Specify your border width here
          ),
        ),
      ),
      child: Checkbox(
        
        value: widget.value,
        onChanged: widget.onChanged,
      ),
    );
  }
}

