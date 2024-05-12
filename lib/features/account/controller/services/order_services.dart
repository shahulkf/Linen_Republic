import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic/features/account/controller/repository/order_repo.dart';
import 'package:linen_republic/features/account/model/order/order_model.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';

class OrderServices implements OrderRepository {
  @override
  Future<Either<String, List<OrderModel>>> fetchOrders() async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('Orders')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      final orders =
          response.docs.map((e) => OrderModel.fromJson(e.data())).toList();
      return right(orders);
    } catch (e) {
      return left('Something Went Wrong $e');
    }
  }

  @override
  Future<Either<String, String>> orderPlaced(OrderModel orderModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderModel.orderId)
          .set(orderModel.toJson());
      return right('Success');
    } catch (e) {
      return left('Error');
    }
  }

  @override
  Future<Either<String, List<CartModel>>> getOrderedItems(
      List<String> ids) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('products')
          .where('id', whereIn: ids)
          .get();
      final products = response.docs
          .map((e) => CartModel(
              name: e.data()['name'],
              productId: e.data()['id'],
              price: e.data()['price'].toString(),
              quantity: '1',
              description: '',
              imageUrl:
                  (e['images'] as List).map((ee) => ee.toString()).toList(),
              stock: ''))
          .toList();
      return right(products);
    } catch (e) {
      return left(e.toString());
    }
  }
}
