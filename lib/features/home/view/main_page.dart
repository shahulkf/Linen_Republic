import 'package:flutter/material.dart';
import 'package:linen_republic/features/account/view/account.dart';
import 'package:linen_republic/features/cart/view/cart.dart';
import 'package:linen_republic/features/home/view/home_screen.dart';
import 'package:linen_republic/features/home/widgets/bottom_nav.dart';
import 'package:linen_republic/features/wishlist/view/wishlist.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _pages = [
     HomePage(),
    const CartPage(),
    const WishListPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, index, _) {
          return _pages[index];
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
