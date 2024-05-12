part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class AddAddressEvent extends AddressEvent {
  final AddressModel addressModel;
  AddAddressEvent({required this.addressModel});
}
 class GetAddressEvent extends AddressEvent{}

 class DeleteAddressEvent extends AddressEvent{
 final String id;

  DeleteAddressEvent({required this.id});
 
 }
 class UpdateAddressEvent extends AddressEvent{
  final AddressModel addressModel;
  UpdateAddressEvent({required this.addressModel});
 }

