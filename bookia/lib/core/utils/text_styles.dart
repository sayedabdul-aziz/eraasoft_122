import 'package:bookia/core/constants/constants.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

TextStyle getHeadlineTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.darkColor,
    fontSize: fontSize ?? 30,
  );
}

TextStyle getTitleTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.darkColor,
    fontSize: fontSize ?? 24,
  );
}

TextStyle getBodyTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.darkColor,
    fontSize: fontSize ?? 20,
  );
}

TextStyle getSmallTextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    color: color ?? AppColors.darkColor,
    fontSize: fontSize ?? 16,
  );
}
