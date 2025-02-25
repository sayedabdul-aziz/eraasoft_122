import 'package:bookia/core/utils/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({
    super.key,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return Image.asset(
              'assets/images/welcome.png',
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
          options: CarouselOptions(
            height: 150,
            viewportFraction: .8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Gap(15),
        SmoothPageIndicator(
          controller: PageController(initialPage: currentIndex),
          count: 3,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.primaryColor,
            dotColor: AppColors.greyColor,
            dotHeight: 10,
            dotWidth: 15,
            spacing: 5,
          ),
        )
      ],
    );
  }
}
