part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

class AddressSuccessState extends AddressState {}

class AddressErrorState extends AddressState {
  final String message;

  AddressErrorState({required this.message});
}

class AddressLoadingState extends AddressState {}

class GetAddressSuccessState extends AddressState {
  final List<AddressModel> adresses;
  GetAddressSuccessState({required this.adresses});
}

class GetAddressErrorState extends AddressState {
  final String message;
  GetAddressErrorState({required this.message});
}

class DeleteAddressSuccessState extends AddressState{
  final String message;
  DeleteAddressSuccessState({required this.message});
}

class DeleteAddressErrorState extends AddressState{
  final String message;
  DeleteAddressErrorState({required this.message});
}

class UpdateAddressSuccessState extends AddressState{
  final String message;
  UpdateAddressSuccessState({required this.message});
}
class UpdateAddressErrorState extends AddressState{
  final String message;
  UpdateAddressErrorState({required this.message});
}
