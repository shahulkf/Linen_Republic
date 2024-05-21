import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';
import 'package:linen_republic/features/cart/controller/cart_services/cart_services.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';
import 'package:linen_republic/features/cart/view/cart.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) async {
      final response = await CartServices().getCart();
      List<CartModel> cartedItems = [];
      response.fold((l) {}, (r) {
        cartedItems.addAll(r);
      });
      final deliveryAddress = await fetchDefaultAddress();
      emit(
        CheckOutSuccess(
          cartedItems: cartedItems,
          totalItems: getTotalItems(cartedItems),
          totalPrice: getPrice(cartedItems),
          paymentMethod: true,
          deliveryAddress: deliveryAddress,
        ),
      );
    });
  }
}

Future<AddressModel?> fetchDefaultAddress() async {
  final snapShot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Address')
      .where('default', isEqualTo: true)
      .get();
  if (snapShot.docs.isEmpty) {
    return null;
  }
  final address = AddressModel.fromMap(snapShot.docs.first.data());
  return address;
}
