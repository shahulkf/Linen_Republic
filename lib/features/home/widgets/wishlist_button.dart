import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';

class WishlistButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const WishlistButton(
      {super.key, required this.isFavorite, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : ConstColor.blackColor,
      ),
      onPressed: onPressed,
    );
  }
}
