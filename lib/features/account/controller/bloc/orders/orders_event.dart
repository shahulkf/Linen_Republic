part of 'orders_bloc.dart';

@immutable
class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {}

class OrderPlacedEvent extends OrdersEvent {
  final OrderModel orderModel;

  OrderPlacedEvent({required this.orderModel});
}

class OrderedProductsFetchEvent extends OrdersEvent {
  final List<String> productIds;
  OrderedProductsFetchEvent({required this.productIds});
}
