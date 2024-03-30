import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/home/widgets/product_view_widget.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Wishlist',
            style: GoogleFonts.prata(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1 / 2.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductViewWidget(product: products[index]);
            },
          ),
        ));
  }
}
