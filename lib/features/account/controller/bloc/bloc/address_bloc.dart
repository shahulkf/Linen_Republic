import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/features/account/controller/repository/address_repo.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final AddressRepo _addressRepo;
  AddressBloc(this._addressRepo) : super(AddressInitial()) {
    on<AddAddressEvent>((event, emit) async {
      emit(AddressLoadingState());
      final reponse = await _addressRepo.addAddress(event.addressModel);
      reponse.fold((l) => emit(AddressErrorState(message: l)),
          (r) => emit(AddressSuccessState()));
    });

    on<GetAddressEvent>((event, emit) async {
      emit(AddressLoadingState());
      final response = await _addressRepo.getAddress();
      response.fold((l) => emit(GetAddressErrorState(message: l)),
          (r) => emit(GetAddressSuccessState(adresses: r)));
    });
  }
}
