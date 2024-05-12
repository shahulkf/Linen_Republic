import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/features/home/widgets/product_view_widget.dart';
import 'package:linen_republic/features/product/view/product_details.dart';
import 'package:linen_republic/features/wishlist/controller/bloc/bloc/wishlist_bloc.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WishlistBloc>().add(FetchWishListEvent());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Wishlist',
            style: GoogleFonts.prata(),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
              if (state is FetchWishListSuccessState) {
                if (state.products.isEmpty) {
                  return const Center(
                    child: Text("Your WishList is waiting to be filled"),
                  );
                }
                final productss = state.products;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2.0,
                  ),
                  itemCount: productss.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                    product: state.products[index]),
                              ));
                        },
                        child: ProductViewWidget(product: productss[index]));
                  },
                );
              } else if (state is FetchWishListEmptyState) {
               
                return Center(
                    child: Text(
                  'Your WishList is waiting to be filled',
                  style: GoogleFonts.prata(fontSize: 19),
                ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })));
  }
}
