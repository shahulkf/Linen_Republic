import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/features/account/view/address/add_address.dart';
import 'package:linen_republic/features/account/view/address/widgets/single_address.dart';

class ViewAddressPage extends StatelessWidget {
  const ViewAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Address',
          style: GoogleFonts.prata(),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleAddressWidget(selectedAddress: false),
              SingleAddressWidget(selectedAddress: true),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAddressPage(),
              ));
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
