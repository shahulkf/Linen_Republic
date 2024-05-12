import 'package:dartz/dartz.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';

abstract class CartRepo {
  Future<Either<String, String>> addToCart(CartModel cartModel);

  Future<Either<String, dynamic>> getCart();

  Future<Either<String, String>> removeCart(String id);

  Future<Either<String, String>> updateCart(CartModel cartModel);

  Future<void> clearCart();
}
