import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_bar_matu/components/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/features/home/widgets/wishlist_button.dart';
import 'package:linen_republic/features/wishlist/controller/bloc/bloc/wishlist_bloc.dart';
import 'package:linen_republic/features/wishlist/controller/wishlist_services/wishlist_services.dart';

class ProductViewWidget extends StatefulWidget {
  const ProductViewWidget({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductViewWidget> createState() => _ProductViewWidgetState();
}

class _ProductViewWidgetState extends State<ProductViewWidget> {
  bool isFavorite = false;
  @override
  void initState() {
    getFavorite();
    super.initState();
  }

  getFavorite() async {
    isFavorite = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) =>
            (value.data()!['wishlist'] as List).contains(widget.product.id));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          borderRadius: BorderRadius.circular(
            10,
          ),
          elevation: 10,
          child: Stack(
            children: [
              Container(
                height: 200,
                width: 160,
                decoration: BoxDecoration(
                    // color: colorGrey6,
                    borderRadius: BorderRadius.circular(10),
                    image: !(widget.product.image[0] as String)
                            .contains('firebase')
                        ? DecorationImage(
                            image: AssetImage(widget.product.image.first),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(widget.product.image.first),
                            fit: BoxFit.cover,
                          )),
              ),
              Positioned(
                right: 0,
                child: WishlistButton(
                  isFavorite: isFavorite,
                  onPressed: () async {
                    if (isFavorite) {
                      await WishListServices()
                          .deleteWishlist(widget.product.id.toString());
                    } else {
                      await WishListServices()
                          .addToWishlist(widget.product.id.toString());
                    }
                    getFavorite();
                    context.read<WishlistBloc>().add(FetchWishListEvent());
                  },
                ),
              ),
            ],
          ),
        ),
        height10,
        AutoSizeText(
          widget.product.title,
          maxLines: 1,
          minFontSize: 16,
          style: GoogleFonts.prata(
              fontSize: 19, fontWeight: FontWeight.bold, color: colorGrey3),
        ),
        AutoSizeText(
          widget.product.description,
          style: GoogleFonts.prata(fontSize: 16, color: colorGrey3),
          maxLines: 2,
        ),
        Text(
          "${AppStrings.rupee}${widget.product.price.toString()}",
          style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: ConstColor.blackColor),
        ),
      ],
    );
  }
}
