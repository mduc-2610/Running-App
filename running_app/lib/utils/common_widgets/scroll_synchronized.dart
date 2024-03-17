import 'package:flutter/material.dart';

class ScrollSynchronized extends StatelessWidget {
  final Widget child;
  final ScrollController parentScrollController;
  final ScrollController? childScrollController;

  const ScrollSynchronized({
    required this.child,
    required this.parentScrollController,
    this.childScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            parentScrollController.animateTo(
              parentScrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
            );
          } else if (notification.metrics.pixels ==
              notification.metrics.minScrollExtent) {
            parentScrollController.animateTo(
              parentScrollController.position.minScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
            );
          }
        }
        return true;
      },
      child: child,
    );
  }
}
