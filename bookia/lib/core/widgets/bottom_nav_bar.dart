import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/cart_list/presentation/page/cart_screen.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:bookia/feature/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/icons/Home.svg',
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset('assets/icons/Home.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/icons/Bookmark.svg',
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset('assets/icons/Bookmark.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/icons/Category.svg',
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset('assets/icons/Category.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/icons/Profile.svg',
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset('assets/icons/Profile.svg'),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
