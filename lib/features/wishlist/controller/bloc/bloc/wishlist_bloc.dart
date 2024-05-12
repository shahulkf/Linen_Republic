import 'package:bloc/bloc.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/features/wishlist/controller/wishlist_repo/wishlist_repo.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepo wishlistRepo;
  WishlistBloc(this.wishlistRepo) : super(WishlistInitial()) {
    on<FetchWishListEvent>((event, emit) async {
      emit(FetchWishListLoadingState());
      final response = await wishlistRepo.getWishListProducts();
      if (response.isEmpty) {
        emit(FetchWishListEmptyState());
      } else {
        emit(FetchWishListSuccessState(products: response));
      }
    });
  }
}
