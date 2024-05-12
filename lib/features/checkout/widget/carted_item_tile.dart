import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class CartedItemtile extends StatelessWidget {
  final CartModel cartModel;
  const CartedItemtile({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Responsive.height * 0.11,
        width: Responsive.width * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorGrey6,
        ),
        child: Row(
          children: [
            SizedBox(
              width: Responsive.width * 0.03,
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(
                image: NetworkImage(cartModel.imageUrl.first),
                fit: BoxFit.fill,
              ),
            ),
            width10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height10,
                Text(
                  cartModel.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: colorGrey3),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    cartModel.description,
                    maxLines: 1,
                    style: const TextStyle(color: colorGrey4),
                  ),
                ),
                Text(
                  "${AppStrings.rupee}${cartModel.price.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: colorGrey2),
                )
              ],
            ),
            SizedBox(
              width: Responsive.width * 0.10,
            ),
            Text(
              'Qty :  ${cartModel.quantity}',
              style: const TextStyle(color: colorGrey2),
            )
          ],
        ),
      ),
    );
  }
}
