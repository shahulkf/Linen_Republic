import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic/features/cart/controller/cart_repo/cart_repo.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';

class CartServices implements CartRepo {
  @override
  Future<Either<String, String>> addToCart(CartModel cartModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(cartModel.productId)
          .set(cartModel.toMap());
      return right('Added Successfully');
    } catch (e) {
      return left('Error');
    }
  }

  @override
  Future<Either<String, List<CartModel>>> getCart() async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .get();
      final cart =
          response.docs.map((e) => CartModel.fromMap(e.data())).toList();
      return right(cart);
    } catch (e) {
      return left('Something Went Wrong');
    }
  }

  @override
  Future<Either<String, String>> removeCart(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(id)
          .delete();
      return right('Removed Successfully');
    } catch (e) {
      return left('Something Went Wrong');
    }
  }

  @override
  Future<Either<String, String>> updateCart(CartModel cartModel) {
    // ignore: empty_catches
    try {} catch (e) {}
    throw UnimplementedError();
  }

  Future<void> updateQuantity(CartModel cartModel, bool isAdd) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      int quantity = int.parse(cartModel.quantity);
      final newQuantity = isAdd ? (quantity += 1) : (quantity -= 1);
      if (newQuantity >= 0) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('cart')
            .doc(cartModel.productId)
            .update({'quantity': newQuantity.toString()});
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Future<void> clearCart() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('cart')
          .get();
      for (var element in snapshot.docs) {
        element.reference.delete();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
