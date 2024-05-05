import 'package:flutter/material.dart';


class ProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final double? width;
  const ProgressBar({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    double progress = currentStep / totalSteps;
    return Container(
      width: width ?? media.width * 0.78,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: const AlwaysStoppedAnimation<Color>(
            Color(0xff6cb64f),
          ),
          value: progress,
        ),
      ),
    );
  }
}