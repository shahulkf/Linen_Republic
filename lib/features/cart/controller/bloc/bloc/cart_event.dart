part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class ProductAddToCart extends CartEvent {
  final CartModel cartModel;

  ProductAddToCart({required this.cartModel});
}

class ProductRemoveFromCart extends CartEvent {
  final String id;

  ProductRemoveFromCart({required this.id});
}

class CartProductsGetEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {}
