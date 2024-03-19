import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool light0 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return  Switch.adaptive(
      value: light0,
      onChanged: (bool value) {
        setState(() {
          light0 = value;
        });
      },
      activeColor: TColor.PRIMARY,
    );
   {

  }}
}
