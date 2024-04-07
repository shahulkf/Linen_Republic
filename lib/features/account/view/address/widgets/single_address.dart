import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';

import '../../../../../utils/responsive/responsive.dart';

class SingleAddressWidget extends StatelessWidget {
  const SingleAddressWidget({
    required this.addresses,
    required this.selectedAddress,
    super.key,
  });
  final bool selectedAddress;
  final AddressModel addresses;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: Responsive.width * 1,
      height: Responsive.height * 0.20,
      decoration: BoxDecoration(
        color: selectedAddress ? colorGrey5 : colorGrey7,
        border: Border.all(color: colorGrey4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 10,
            child: Icon(
              selectedAddress
                  ? Icons.check_circle_outline
                  : Icons.circle_outlined,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height20,
                Text(
                  addresses.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  addresses.phoneNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "  ${addresses.pincode} ${addresses.city}${addresses.state} ${addresses.locality} ${addresses.flatNo}${addresses.landmark}${addresses.typeOfAddress}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
