part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class AddAddressEvent extends AddressEvent {
  final AddressModel addressModel;
  AddAddressEvent({required this.addressModel});
}
 class GetAddressEvent extends AddressEvent{}
