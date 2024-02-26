import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';

ValueNotifier indexChangeNotifier = ValueNotifier(0);

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, value, _) {
        return BottomBarDoubleBullet(
          selectedIndex: value,
          onSelect: (index) {
            indexChangeNotifier.value = index;
          },
          items: [
            BottomBarItem(iconData: Icons.home_outlined, label: 'Home'),
            BottomBarItem(iconData: Icons.shopping_bag_outlined, label: 'Cart'),
            BottomBarItem(iconData: Icons.favorite, label: 'WishList'),
            BottomBarItem(iconData: Icons.person_4_outlined, label: 'Account')
          ],
          color: ConstColor.blackColor,
        );
      },
    );
  }
}
