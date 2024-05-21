import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/features/account/controller/bloc/address/address_bloc.dart';
import 'package:linen_republic/features/account/view/address/add_address.dart';
import 'package:linen_republic/features/account/view/address/widgets/single_address.dart';
import 'package:linen_republic/features/checkout/controller/bloc/checkout_bloc.dart';

class ViewAddressPage extends StatefulWidget {
  const ViewAddressPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ViewAddressPageState createState() => _ViewAddressPageState();
}

class _ViewAddressPageState extends State<ViewAddressPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AddressBloc>().add(GetAddressEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Address',
          style: GoogleFonts.prata(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            log(state.toString());
            if (state is GetAddressSuccessState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.adresses.length,
                itemBuilder: (context, index) {
                  final address = state.adresses[index];

                  return SingleAddressWidget(
                    onTap: () async {
                      await updateAllAddressesToFalse();
                      await updateAddressToTrue(address.id!).whenComplete(() {
                        context.read<CheckoutBloc>().add(CheckoutEvent());
                      });
                      setState(() {});
                    },
                    addresses: address,
                    selectedAddress: address.defaultAddress,
                  );
                },
              );
            } else if (state is GetAddressErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddressPage(),
            ),
          );
        },
        backgroundColor: ConstColor.blackColor,
        child: Icon(
          Icons.add,
          color: ConstColor.greyColor,
        ),
      ),
    );
  }
}

Future<void> updateAddressToTrue(String addressId) async {
  // Get a reference to the specific document
  final addressDoc = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Address')
      .doc(addressId);

  // Update 'default' field to true for the specific document
  await addressDoc.update({'default': true});
}

Future<void> updateAllAddressesToFalse() async {
  // Get a reference to the collection of addresses
  final addressesCollection = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Address');

  // Fetch all documents in the collection
  final querySnapshot = await addressesCollection.get();

  // Iterate through each document and update 'default' field to false
  for (final doc in querySnapshot.docs) {
    await doc.reference.update({'default': false});
  }
}
