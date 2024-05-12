import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/features/wishlist/controller/wishlist_repo/wishlist_repo.dart';

class WishListServices implements WishlistRepo {
  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  // getfavoriteIds
  @override
  Future<List<dynamic>> getfavoriteIds() async {
    final userId = _auth.currentUser!.uid;
    final favoritesSnapshot =
        await _firebase.collection('Users').doc(userId).get();
    final favoriteIds = favoritesSnapshot.data()!['wishlist'] as List;
    return favoriteIds;
  }

  Future<Either<String, String>> addToWishlist(String id) async {
    try {
      _firebase.collection('Users').doc(_auth.currentUser!.uid).update({
        'wishlist': FieldValue.arrayUnion([id])
      });
      return right('product added to wishlist');
    } on FirebaseAuthException catch (e) {
      return left(e.message.toString());
    }
  }

  Future<Either<String, String>> deleteWishlist(String id) async {
    try {
      await _firebase.collection('Users').doc(_auth.currentUser!.uid).update({
        'wishlist': FieldValue.arrayRemove([id])
      });
      return right('product removed from wishlist');
    } on FirebaseAuthException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<List<ProductModel>> getWishListProducts() async {
    final document =
        await _firebase.collection('Users').doc(_auth.currentUser!.uid).get();
    if (document.exists) {
      final itemsIds = document.data()!['wishlist'] as List;
      if (itemsIds.isEmpty) {
        return [];
      }
      final wishlistProductsQuerySnapshot = await _firebase
          .collection('products')
          .where('id', whereIn: itemsIds)
          .get();
      final wishlistProducts = wishlistProductsQuerySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return wishlistProducts;
    } else {
      return [];
    }
  }
}
