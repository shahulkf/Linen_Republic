import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/controller/bloc/orders/orders_bloc.dart';
import 'package:linen_republic/features/account/orders/widgets/ordertile_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrdersBloc>().add(GetOrdersEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: GoogleFonts.prata(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is GetOrderSuccessState) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('Empty'));
              }
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height10,
                        OrderTileWidget(
                          orderModel: state.orders[index],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is GetOrderErrorState) {
              return const Text('Error ');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
