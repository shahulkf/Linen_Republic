class AddressModel {
  String? id;
  String fullName;
  String phoneNumber;
  String pincode;
  String city;
  String state;
  String locality;
  String flatNo;
  String landmark;
  String typeOfAddress;
  AddressModel(
      {required this.fullName,
      required this.phoneNumber,
      required this.pincode,
      required this.city,
      required this.state,
      required this.flatNo,
      required this.landmark,
      required this.locality,
      required this.typeOfAddress,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'Full Name': fullName,
      'Phone Number': phoneNumber,
      'pincode': pincode,
      'city': city,
      'State': state,
      'locality': locality,
      'Flat No': flatNo,
      'landmark': landmark,
      'type of address': typeOfAddress
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
        fullName: map['Full Name'],
        phoneNumber: map['Phone Number'],
        pincode: map['pincode'],
        city: map['city'],
        state: map['State'],
        flatNo: map['Flat No'],
        landmark: map['landmark'],
        locality: map['locality'],
        typeOfAddress: map['type of address']);
  }
}
