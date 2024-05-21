import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/controller/bloc/address/address_bloc.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';
import 'package:linen_republic/features/account/view/address/add_address.dart';

import '../../../../../utils/responsive/responsive.dart';

class SingleAddressWidget extends StatelessWidget {
  const SingleAddressWidget({
    required this.addresses,
    required this.selectedAddress,
    required this.onTap,
    this.buttonshow = true,
    super.key,
  });
  final bool selectedAddress;
  final AddressModel addresses;
  final VoidCallback onTap;
  final bool buttonshow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: Responsive.width * 1,
        height: Responsive.height * 0.36,
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Responsive.height * .020,
                    ),
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
                      '${addresses.locality}\n${addresses.city}\n${addresses.state}\n${addresses.pincode}\n${addresses.flatNo}\n${addresses.landmark}\n${addresses.typeOfAddress}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    height20,
                    if (buttonshow)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Update',
                                      style: GoogleFonts.prata(),
                                    ),
                                    content: Text(
                                      'Do you want to update address ?',
                                      style: GoogleFonts.prata(),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            // update function
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddAddressPage(
                                                    addressModel: addresses,
                                                  ),
                                                ));
                                          },
                                          child: Text(
                                            'Yes',
                                            style: GoogleFonts.prata(),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'No',
                                            style: GoogleFonts.prata(),
                                          ))
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: ConstColor.blackColor,
                              ),
                              label: const Text(
                                'Edit',
                                style: TextStyle(color: ConstColor.blackColor),
                              )),
                          TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Delete',
                                      style: GoogleFonts.prata(),
                                    ),
                                    content: Text(
                                      'Do you want to delete address ?',
                                      style: GoogleFonts.prata(),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            //Delete function
                                            context.read<AddressBloc>().add(
                                                DeleteAddressEvent(
                                                    id: addresses.id!));
                                            context
                                                .read<AddressBloc>()
                                                .add(GetAddressEvent());
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: GoogleFonts.prata(),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'No',
                                            style: GoogleFonts.prata(),
                                          ))
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete,
                                  color: ConstColor.blackColor),
                              label: const Text(
                                'Remove',
                                style: TextStyle(color: ConstColor.blackColor),
                              )),
                        ],
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
