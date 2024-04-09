import 'package:dartz/dartz.dart';
import 'package:linen_republic/features/home/model/product_model.dart';

abstract class WishlistRepo {
  Future<List<dynamic>> getfavoriteIds();
  Future<List<ProductModel>> getWishListProducts();
}
