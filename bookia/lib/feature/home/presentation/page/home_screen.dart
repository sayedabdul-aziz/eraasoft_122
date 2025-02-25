import 'package:bookia/feature/home/presentation/widgets/home_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/logo.svg', width: 100),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/search.svg')),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/notification.svg'))
        ],
      ),
      body: Column(
        children: [
          HomeBanner(),
        ],
      ),
    );
  }
}
