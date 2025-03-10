import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/home/data/models/get_slider_response/slider.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    super.initState();
    context.read<HomeCubit>().getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (_, state) =>
          state is SliderSuccessState ||
          state is SliderLoadingState ||
          state is SliderErrorState,
      builder: (context, state) {
        if (state is! SliderSuccessState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<SliderImage> sliders =
            context.read<HomeCubit>().sliderResponse?.data?.sliders ?? [];
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return CachedNetworkImage(
                  imageUrl: sliders[itemIndex].image ?? '',
                  fit: BoxFit.cover,
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
              count: sliders.length,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.primaryColor,
                dotColor: AppColors.greyColor,
                dotHeight: 8,
                dotWidth: 15,
                spacing: 5,
              ),
            )
          ],
        );
      },
    );
  }
}
