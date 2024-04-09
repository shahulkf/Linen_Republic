part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class AddToCartSuccess extends CartState {
  final String message;

  AddToCartSuccess({required this.message});
}

class RemoveCartSuccess extends CartState {
  final String message;

  RemoveCartSuccess({required this.message});
}

class AddToCartError extends CartState {
  final String message;

  AddToCartError({required this.message});
}

class RemoveCartError extends CartState {
  final String message;

  RemoveCartError({required this.message});
}

class FetchCartProductsSuccessState extends CartState {
  final List<CartModel> cartItems;

  FetchCartProductsSuccessState({required this.cartItems});
}

class FetchCartProductsErrorState extends CartState {
  final String message;

  FetchCartProductsErrorState({required this.message});
}
