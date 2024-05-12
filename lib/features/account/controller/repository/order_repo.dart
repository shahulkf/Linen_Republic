import 'package:dartz/dartz.dart';
import 'package:linen_republic/features/account/model/order/order_model.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';

abstract class OrderRepository {
  Future<Either<String, String>> orderPlaced(OrderModel orderModel);
  Future<Either<String, List<OrderModel>>> fetchOrders();
  Future<Either<String, List<CartModel>>> getOrderedItems(List<String> ids);
}
