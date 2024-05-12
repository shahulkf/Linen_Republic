import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/features/account/controller/repository/order_repo.dart';
import 'package:linen_republic/features/account/model/order/order_model.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository orderrepo;
  OrdersBloc(this.orderrepo) : super(OrdersInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      final response = await orderrepo.fetchOrders();
      response.fold((l) => emit(GetOrderErrorState()),
          (r) => emit(GetOrderSuccessState(orders: r)));
    });
    on<OrderPlacedEvent>((event, emit) async {
      final response = await orderrepo.orderPlaced(event.orderModel);
      response.fold((l) => emit(OrderPlacedErrorState()),
          (r) => emit(OrderPlacedSuccessState()));
    });
    on<OrderedProductsFetchEvent>((event, emit) async {
      final response = await orderrepo.getOrderedItems(event.productIds);
      response.fold((l) => emit(OrderPlacedErrorState()),
          (r) => emit(OrdredProductsFetchSuccess(products: r)));
    });
  }
}
