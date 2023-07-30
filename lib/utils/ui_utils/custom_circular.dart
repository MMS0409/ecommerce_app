import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? strokeWidth;
 final BuildContext? context;

  const CustomCircularProgressIndicator({
    super.key,
    this.strokeWidth,
    this.context
  });

  @override
  Widget build(BuildContext context) {
    if (strokeWidth == 4.0 || strokeWidth == null) {
      return CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.c_3669C9),
      );
    } else {
      return CircularProgressIndicator(
        strokeWidth: strokeWidth!,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
      );
    }
  }
}
