import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor,
    this.height,
    this.width,
    this.fgColor,
    this.borderColor,
    this.radius = 10,
  });

  final String text;
  final Function() onPressed;
  final Color? bgColor;
  final Color? fgColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? AppColors.primaryColor,
            side: borderColor != null
                ? BorderSide(color: borderColor ?? AppColors.primaryColor)
                : BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
        child: Text(
          text,
          style: getBodyTextStyle(color: fgColor ?? AppColors.whiteColor),
        ),
      ),
    );
  }
}
