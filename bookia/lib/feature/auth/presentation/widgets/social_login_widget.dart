import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider()),
            Gap(10),
            Text("Or Login With", style: getSmallTextStyle()),
            Gap(10),
            Expanded(child: Divider()),
          ],
        ),
        Gap(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: SvgPicture.asset(
                  "assets/icons/google.svg",
                ),
              ),
            ),
            Gap(10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: SvgPicture.asset(
                  "assets/icons/facebook.svg",
                ),
              ),
            ),
            Gap(10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: SvgPicture.asset(
                  "assets/icons/apple.svg",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
