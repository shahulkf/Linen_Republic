import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/controller/bloc/address/address_bloc.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';
import 'package:linen_republic/features/authentication/view/widgets/buttons.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';
import 'package:linen_republic/utils/validation/validations.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key, this.addressModel});
  final AddressModel? addressModel;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

List<String> options = ['Home', 'Office', 'Other'];

class _AddAddressPageState extends State<AddAddressPage> {
  String currentOption = options[0];
  void initializeValues(BuildContext context) {
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    if (widget.addressModel != null) {
      addressBloc.fullNameController.text = widget.addressModel!.fullName;
      addressBloc.phoneNumberController.text = widget.addressModel!.phoneNumber;
      addressBloc.pincodeController.text = widget.addressModel!.pincode;
      addressBloc.cityController.text = widget.addressModel!.city;
      addressBloc.stateController.text = widget.addressModel!.state;
      addressBloc.localityController.text = widget.addressModel!.locality;
      addressBloc.landmarkController.text = widget.addressModel!.landmark;
      addressBloc.flatNoController.text = widget.addressModel!.flatNo;
      currentOption = options[findType(widget.addressModel!.typeOfAddress)];
    }
  }

  int findType(String type) {
    if (type == 'Home') {
      return 0;
    } else if (type == 'Office') {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.addressModel != null) {
      initializeValues(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${widget.addressModel == null ? 'Add' : 'Update'} Address',
        style: GoogleFonts.prata(),
      )),
      body: Form(
        key: addressBloc.formKey,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: Responsive.height * 0.35,
                    width: Responsive.width * 1,
                    decoration: BoxDecoration(
                        color: colorGrey7,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height10,
                          const AddressTitle(title: 'Contact Info'),
                          height10,
                          AddressFieldWidget(
                              labelText: 'Full Name',
                              controller: addressBloc.fullNameController),
                          height10,
                          AddressFieldWidget(
                            labelText: 'Phone Number (+91)',
                            keyboardType: TextInputType.phone,
                            controller: addressBloc.phoneNumberController,
                          )
                        ],
                      ),
                    ),
                  ),
                  height20,
                  Container(
                    height: Responsive.height * 0.70,
                    width: Responsive.width * 1,
                    decoration: const BoxDecoration(
                        color: colorGrey7,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height10,
                          const AddressTitle(title: 'Address Info'),
                          height10,
                          Row(
                            children: [
                              Expanded(
                                  child: AddressFieldWidget(
                                labelText: 'Pincode',
                                keyboardType: TextInputType.number,
                                controller: addressBloc.pincodeController,
                              )),
                              width10,
                              Expanded(
                                  child: AddressFieldWidget(
                                labelText: 'City',
                                controller: addressBloc.cityController,
                              )),
                            ],
                          ),
                          height10,
                          AddressFieldWidget(
                            labelText: 'State',
                            controller: addressBloc.stateController,
                          ),
                          height10,
                          AddressFieldWidget(
                            labelText: 'Locality / Area / Street',
                            controller: addressBloc.localityController,
                          ),
                          height10,
                          AddressFieldWidget(
                            labelText: 'Flat No / Building Name',
                            controller: addressBloc.flatNoController,
                          ),
                          height10,
                          AddressFieldWidget(
                            labelText: 'Landmark',
                            controller: addressBloc.landmarkController,
                          )
                        ],
                      ),
                    ),
                  ),
                  height10,
                  Container(
                    height: Responsive.height * 0.29,
                    width: Responsive.width * 1,
                    decoration: BoxDecoration(
                        color: colorGrey7,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AddressTitle(title: 'Type of Address'),
                          ListTile(
                            title: const Text('Home'),
                            leading: Radio(
                              value: options[0],
                              groupValue: currentOption,
                              onChanged: (String? value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Office'),
                            leading: Radio(
                              value: options[1],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Other'),
                            leading: Radio(
                              value: options[2],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  // currentOption = value.toString();
                                  currentOption = value ?? options[0];
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  height10,
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<AddressBloc, AddressState>(
        listenWhen: (previous, current) =>
            current is AddressErrorState || current is AddressSuccessState,
        buildWhen: (previous, current) =>
            current is AddressLoadingState || current is AddressErrorState,
        listener: (context, state) {
          if (state is AddressSuccessState) {
            Navigator.pop(context);
          } else if (state is AddressErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              width: Responsive.width,
              child: Text(
                '${widget.addressModel == null ? 'Add' : 'Update'} Address',
                style: GoogleFonts.prata(
                    color: ConstColor.whiteColor, fontSize: 18),
              ),
              onTap: () {
                //check conditions
                if (addressBloc.formKey.currentState!.validate()) {
                  //create model instance
                  final id = DateTime.now().millisecondsSinceEpoch.toString();
                  final AddressModel address = AddressModel(
                      id: widget.addressModel == null
                          ? id
                          : widget.addressModel!.id,
                      defaultAddress: false,
                      fullName: addressBloc.fullNameController.text.trim(),
                      phoneNumber:
                          addressBloc.phoneNumberController.text.trim(),
                      pincode: addressBloc.pincodeController.text.trim(),
                      city: addressBloc.cityController.text.trim(),
                      state: addressBloc.stateController.text.trim(),
                      flatNo: addressBloc.flatNoController.text.trim(),
                      landmark: addressBloc.landmarkController.text.trim(),
                      locality: addressBloc.localityController.text.trim(),
                      typeOfAddress: currentOption);
                  // //call event
                  if (widget.addressModel == null) {
                    context
                        .read<AddressBloc>()
                        .add(AddAddressEvent(addressModel: address));
                  } else {
                    context
                        .read<AddressBloc>()
                        .add(UpdateAddressEvent(addressModel: address));
                    Navigator.pop(context);
                  }
                  clearFields();
                } else {}
              },
            ),
          );
        },
      ),
    );
  }

  void clearFields() {
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    addressBloc.fullNameController.clear();
    addressBloc.phoneNumberController.clear();
    addressBloc.pincodeController.clear();
    addressBloc.cityController.clear();
    addressBloc.stateController.clear();
    addressBloc.localityController.clear();
    addressBloc.flatNoController.clear();
    addressBloc.landmarkController.clear();
  }
}

class AddressTitle extends StatelessWidget {
  final String title;
  const AddressTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.prata(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}

class AddressFieldWidget extends StatelessWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  const AddressFieldWidget({
    required this.labelText,
    this.keyboardType,
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return addressValidation(controller, context);
        } else if (controller ==
                context.read<AddressBloc>().phoneNumberController &&
            value.length != 10) {
          return 'Enter a valid phone number';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
