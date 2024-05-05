import 'package:flutter/material.dart';
import 'package:running_app/utils/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final String? backgroundImage;
  final Color? backgroundColor;
  final bool? forceMaterialTransparency;
  const CustomAppBar({
    required this.title,
    this.backgroundImage,
    this.backgroundColor,
    this.forceMaterialTransparency,
    Key? key,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late AssetImage _assetImage;

  @override
  void initState() {
    super.initState();
    if(widget.backgroundImage != null) {
      _assetImage = AssetImage(widget.backgroundImage ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: widget.forceMaterialTransparency ?? false,
      titleSpacing: 0,
      title: widget.title,
      automaticallyImplyLeading: false,
      backgroundColor: widget.backgroundColor ?? TColor.PRIMARY,
      flexibleSpace: (widget.backgroundImage != null)
          ? Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _assetImage,
            fit: BoxFit.cover,
          ),
        ),
      ) : null,
    );
  }

}
