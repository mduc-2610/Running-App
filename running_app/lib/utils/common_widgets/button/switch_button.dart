import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class SwitchButton extends StatefulWidget {
  final bool? switchState;
  final ValueChanged<bool>? onChanged;
  const SwitchButton({
    this.switchState,
    this.onChanged,
    super.key
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {

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
      value: widget.switchState!,
      onChanged: widget.onChanged,
      activeColor: TColor.PRIMARY,
    );
  }
}
