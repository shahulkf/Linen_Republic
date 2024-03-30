import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/home/model/product_model.dart';

class ProductViewWidget extends StatelessWidget {
  const ProductViewWidget({super.key, required this.product});
  final ProductModel product;

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
                    color: colorGrey6,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(product.image.first),
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              ),
            ],
          ),
        ),
        height10,
        AutoSizeText(
          product.title,
          maxLines: 1,
          minFontSize: 16,
          style: const TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, color: colorGrey3),
        ),
        AutoSizeText(
          product.description,
          style: const TextStyle(fontSize: 16, color: colorGrey3),
          maxLines: 2,
        ),
        Text(
          "${AppStrings.rupee}${product.price.toString()}",
          style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: ConstColor.blackColor),
        ),
      ],
    );
  }
}
