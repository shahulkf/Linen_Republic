import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/controller/bloc/orders/orders_bloc.dart';
import 'package:linen_republic/features/account/model/order/order_model.dart';
import 'package:linen_republic/features/account/orders/widgets/timeline_tile.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class OrdersViewPage extends StatelessWidget {
  const OrdersViewPage({Key? key, required this.orderModel}) : super(key: key);
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    context
        .read<OrdersBloc>()
        .add(OrderedProductsFetchEvent(productIds: orderModel.orderedItemIds));
    return WillPopScope(
      onWillPop: () async {
        context.read<OrdersBloc>().add(GetOrdersEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order Details',
            style: GoogleFonts.prata(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Order id : ',
                      style: GoogleFonts.prata(),
                    ),
                    Text(
                      orderModel.orderId,
                      style: GoogleFonts.prata(),
                    ),
                  ],
                ),
                height10,
                Container(
                  width: Responsive.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorGrey6,
                  ),
                  child: BlocBuilder<OrdersBloc, OrdersState>(
                    builder: (context, state) {
                      if (state is OrdredProductsFetchSuccess) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: Responsive.height * 0.12,
                                width: Responsive.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorGrey6,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              product.imageUrl.first)),
                                    ),
                                    width10,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.name,
                                          style:
                                              GoogleFonts.prata(fontSize: 20),
                                        ),
                                        Text(
                                          '${AppStrings.rupee}${product.price}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          ' Qty : ${product.quantity}',
                                          style: GoogleFonts.prata(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _buildTimelineTiles(orderModel.status),
                ),
                Text(
                  'Delivery Address',
                  style: GoogleFonts.prata(fontSize: 21),
                ),
                height10,
                Container(
                  height: Responsive.height * 0.24,
                  width: Responsive.width * 1,
                  decoration: BoxDecoration(
                      color: colorGrey6,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderModel.orderedAddress!.fullName,
                          style: GoogleFonts.prata(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'Locality :  ${orderModel.orderedAddress!.locality}',
                          style: GoogleFonts.prata(),
                        ),
                        Text(
                          'City : ${orderModel.orderedAddress!.city}',
                          style: GoogleFonts.prata(),
                        ),
                        Text(
                          'Flat No :  ${orderModel.orderedAddress!.flatNo}',
                          style: GoogleFonts.prata(),
                        ),
                        Text(
                          'Landmark :  ${orderModel.orderedAddress!.landmark}',
                          style: GoogleFonts.prata(),
                        ),
                        Text(
                          "State :  ${orderModel.orderedAddress!.state}-${orderModel.orderedAddress!.pincode}",
                          style: GoogleFonts.prata(),
                        ),
                        Text(
                          'Phone :  ${orderModel.orderedAddress!.phoneNumber}',
                          style: GoogleFonts.prata(fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                ),
                height10,
                Container(
                  height: Responsive.height * 0.13,
                  width: Responsive.width * 1,
                  decoration: BoxDecoration(
                      color: colorGrey6,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Payment Mode : ${orderModel.paymentMethod}',
                        style: GoogleFonts.prata(),
                      ),
                      const Divider(),
                      Text(
                        'Total Amount : ${AppStrings.rupee}${orderModel.totalPrice.toString()}',
                        style: GoogleFonts.prata(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTimelineTiles(String status) {
    List<Widget> tiles = [];

    // Add timeline tiles based on order status
    switch (status) {
      case 'Order Placed':
        tiles.add(
          TimeLineTile(
            isFirst: true,
            isLast: false,
            isPast: true,
            eventCard: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Placed',
                  style: GoogleFonts.prata(),
                ),
                AutoSizeText(
                    formatDate(orderModel.timestamp['Order Placed'].toString()),
                    maxLines: 2,
                    maxFontSize: 10,
                    minFontSize: 10,
                    style: GoogleFonts.prata()),
              ],
            ),
          ),
        );
        tiles.add(
          TimeLineTile(
            isFirst: false,
            isLast: false,
            isPast: false, // Change isPast value according to your logic
            eventCard: Text('Order Shipped', style: GoogleFonts.prata()),
          ),
        );
        tiles.add(
          TimeLineTile(
            isFirst: false,
            isLast: true,
            isPast: false,
            eventCard: Text('Out For Delivery', style: GoogleFonts.prata()),
          ),
        );
        break;
      case 'Order Shipped':
        tiles.add(
          TimeLineTile(
            isFirst: true,
            isLast: false,
            isPast: true,
            eventCard: Column(
              children: [
                Text(
                  'Order Placed',
                  style: GoogleFonts.prata(),
                ),
                AutoSizeText(
                  formatDate(orderModel.timestamp['Order Placed'].toString()),
                  style: GoogleFonts.prata(),
                  maxLines: 2,
                  maxFontSize: 10,
                  minFontSize: 10,
                ),
              ],
            ),
          ),
        );
        tiles.add(
          TimeLineTile(
            isFirst: false,
            isLast: false,
            isPast: true,
            eventCard: Column(
              children: [
                Text('Order Shipped', style: GoogleFonts.prata()),
                AutoSizeText(
                    maxLines: 2,
                    maxFontSize: 10,
                    minFontSize: 10,
                    formatDate(
                        orderModel.timestamp['Order Shipped'].toString()),
                    style: GoogleFonts.prata()),
              ],
            ),
          ),
        );
        tiles.add(
          TimeLineTile(
            isFirst: false,
            isLast: true,
            isPast: false,
            eventCard: Text('Out For Delivery', style: GoogleFonts.prata()),
          ),
        );
        break;
      case 'Out For Delivery':
        tiles.add(
          TimeLineTile(
            isFirst: true,
            isLast: false,
            isPast: true,
            eventCard: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Placed',
                  style: GoogleFonts.prata(),
                ),
                AutoSizeText(
                  maxLines: 2,
                  maxFontSize: 10,
                  minFontSize: 10,
                  formatDate(orderModel.timestamp['Order Placed'].toString()),
                  style: GoogleFonts.prata(),
                ),
              ],
            ),
          ),
        );
        tiles.add(
          TimeLineTile(
            isFirst: false,
            isLast: false,
            isPast: true,
            eventCard: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Shipped', style: GoogleFonts.prata()),
                AutoSizeText(
                    maxLines: 2,
                    maxFontSize: 10,
                    minFontSize: 10,
                    formatDate(
                        orderModel.timestamp['Order Shipped'].toString()),
                    style: GoogleFonts.prata()),
              ],
            ),
          ),
        );
        tiles.add(
          TimeLineTile(
            isFirst: false,
            isLast: true,
            isPast: true,
            eventCard: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Out For Delivery', style: GoogleFonts.prata()),
                AutoSizeText(
                    maxLines: 2,
                    maxFontSize: 10,
                    minFontSize: 10,
                    formatDate(
                        orderModel.timestamp['Out For Delivery'].toString()),
                    style: GoogleFonts.prata()),
              ],
            ),
          ),
        );
        break;
      default:
        // Handle unknown status
        break;
    }

    return tiles;
  }
}

String formatDate(String prevDate) {
  // Parse input datetime string
  DateTime dateTime = DateTime.parse(prevDate);

  // Format date
  DateFormat outputDateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = outputDateFormat.format(dateTime);

  // Format time
  DateFormat outputTimeFormat = DateFormat('HH:mm:ss');
  String formattedTime = outputTimeFormat.format(dateTime);

  // Return formatted date and time
  return "$formattedDate\n$formattedTime";
}
