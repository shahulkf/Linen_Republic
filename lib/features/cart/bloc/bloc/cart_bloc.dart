import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:linen_republic/features/cart/controller/cart_repo/cart_repo.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo cartRepo;
  CartBloc(this.cartRepo) : super(CartInitial()) {
    on<ProductAddToCart>(_productAddToCart);
    on<ProductRemoveFromCart>(_productRemoveFromCart);
    on<CartProductsGetEvent>(_cartProductsGetEvent);
  }

  FutureOr<void> _productAddToCart(
      ProductAddToCart event, Emitter<CartState> emit) async {
    final response = await cartRepo.addToCart(event.cartModel);
    response.fold((l) => emit(AddToCartError(message: l)),
        (r) => AddToCartSuccess(message: r));
  }

  FutureOr<void> _productRemoveFromCart(
      ProductRemoveFromCart event, Emitter<CartState> emit) async {
    final response = await cartRepo.removeCart(event.id);
    response.fold((l) => emit(RemoveCartError(message: l)),
        (r) => emit(RemoveCartSuccess(message: r)));
  }

  FutureOr<void> _cartProductsGetEvent(
      CartProductsGetEvent event, Emitter<CartState> emit) async {
    final response = await cartRepo.getCart();
    response.fold((l) => emit(FetchCartProductsErrorState(message: l)),
        (r) => emit(FetchCartProductsSuccessState(cartItems: r)));
  }
}
