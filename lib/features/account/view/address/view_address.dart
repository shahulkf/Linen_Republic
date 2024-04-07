import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/features/account/controller/bloc/bloc/address_bloc.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';
import 'package:linen_republic/features/account/view/address/add_address.dart';
import 'package:linen_republic/features/account/view/address/widgets/single_address.dart';

class ViewAddressPage extends StatelessWidget {
  const ViewAddressPage({super.key});

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  if (state is GetAddressSuccessState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.adresses.length,
                      itemBuilder: (context, index) {
                        return SingleAddressWidget(
                          addresses: state.adresses[index],
                          selectedAddress: index == 1,
                        );
                      },
                    );
                  } else if (state is GetAddressErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
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
