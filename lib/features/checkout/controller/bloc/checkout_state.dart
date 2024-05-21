part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

class CheckOutSuccess extends CheckoutState {
  final List<CartModel> cartedItems;
  final num totalItems;
  final num totalPrice;
  final bool paymentMethod;
  final AddressModel? deliveryAddress;

  CheckOutSuccess({
    required this.cartedItems,
    required this.totalItems,
    required this.totalPrice,
    required this.paymentMethod,
    required this.deliveryAddress,
  });
}
class CheckOutFailure extends CheckoutState{
  final String error;

  CheckOutFailure({required this.error});
}
