import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';

class ProductViewWidget extends StatelessWidget {
  const ProductViewWidget({
    super.key,
  });

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
          child: Container(
            height: 200,
            width: 160,
            decoration: BoxDecoration(
                color: colorGrey6,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/linen_shirt_1.jpeg'),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        height10,
        const Text(
          'Linen Club',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, color: colorGrey3),
        ),
        const Text(
          'Men Slim Fit Shirt with \nBand Collar',
          style: TextStyle(fontSize: 16, color: colorGrey3),
        ),
        const Text(
          '999',
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: ConstColor.blackColor),
        ),
        Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(4)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '3.2',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Icon(
                Icons.star_outlined,
                size: 16,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
    );
  }
}
