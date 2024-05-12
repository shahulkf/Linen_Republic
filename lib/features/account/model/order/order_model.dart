import 'dart:core';

import 'package:linen_republic/features/account/model/address/address_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final List<String> orderedItemIds;
  final double totalPrice;
  final String status;
  final Map<String, dynamic> timestamp;
  final AddressModel? orderedAddress;
  final String paymentMethod;

  OrderModel({
    required this.orderedAddress,
    required this.orderId,
    required this.userId,
    required this.orderedItemIds,
    required this.totalPrice,
    required this.status,
    required this.timestamp,
    required this.paymentMethod
  });

  // Convert JSON data into OrderModel object
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      userId: json['userId'],
      orderedItemIds: List<String>.from(json['orderedItemIds']),
      totalPrice: json['totalPrice'].toDouble(),
      status: json['status'],
      timestamp: json['timestamp'],
      orderedAddress: AddressModel.fromMap(json['address']),
      paymentMethod: json['paymentMethod'],
    );
  }

  // Convert OrderModel object into JSON data
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'orderedItemIds': orderedItemIds,
      'totalPrice': totalPrice,
      'status': status,
      'timestamp': timestamp,
      'address': orderedAddress!.toMap(),
      'paymentMethod':paymentMethod,
    };
  }
}
