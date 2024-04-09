part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

 class FetchWishListSuccessState extends WishlistState{
 final List<ProductModel> products;
  FetchWishListSuccessState({required this.products});
}
class FetchWishListErrorState extends WishlistState{
  final String message;
  FetchWishListErrorState({required this.message});
}
class FetchWishListLoadingState extends WishlistState{}