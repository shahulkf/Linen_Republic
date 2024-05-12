import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/model/order/order_model.dart';
import 'package:linen_republic/features/account/orders/orders_view.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class OrderTileWidget extends StatelessWidget {
  const OrderTileWidget({
    super.key,
    required this.orderModel,
  });
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdersViewPage(orderModel: orderModel),
            ));
      },
      child: Container(
        height: Responsive.height * 0.14,
        width: Responsive.width * 1,
        decoration: const BoxDecoration(
            color: colorGrey6,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: Responsive.height * 0.11,
              width: Responsive.width * 0.23,
              decoration: BoxDecoration(
                  color: colorGrey5, borderRadius: BorderRadius.circular(12)),
              child: const Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.manageteamz.com%2Fblog%2Fwp-content%2Fuploads%2F2020%2F01%2Frole-of-drivers-in-a-delivery-business.png&f=1&nofb=1&ipt=89e1a60799e5382cba26682d35a98b51eb05dd3ccee65bd21728422a92227aef&ipo=images')),
            ),
            width10,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  maxFontSize: 13,
                  minFontSize: 13,
                  'Order Id : ${orderModel.orderId}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Status : ${orderModel.status}')
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
