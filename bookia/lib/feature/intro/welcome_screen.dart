import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/extenstions/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/page/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AssetsManager.welcome,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 130,
            bottom: 90,
            right: 22,
            left: 22,
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsManager.logoSvg,
                    width: 210,
                  ),
                  const Gap(10),
                  Text('Order Your Book Now!',
                      style: getBodyTextStyle(fontSize: 18)),
                  Spacer(),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      context.pushTo(LoginScreen());
                    },
                  ),
                  Gap(15),
                  CustomButton(
                    text: 'Register',
                    bgColor: AppColors.whiteColor,
                    fgColor: AppColors.darkColor,
                    borderColor: AppColors.darkColor,
                    onPressed: () {
                      context.pushTo(RegisterScreen());
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
