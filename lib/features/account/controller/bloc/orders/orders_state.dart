part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class GetOrderSuccessState extends OrdersState {
  final List<OrderModel> orders;

  GetOrderSuccessState({required this.orders});
}

class GetOrderErrorState extends OrdersState {}

class OrderPlacedSuccessState extends OrdersState {}

class OrderPlacedErrorState extends OrdersState {}

class OrdredProductsFetchSuccess extends OrdersState {
  final List<CartModel> products;

  OrdredProductsFetchSuccess({required this.products});
}

class OrdredProductsFetchError extends OrdersState {}
