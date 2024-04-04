import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/authentication/view/widgets/buttons.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

List<String> options = ['option1', 'option2', 'option3'];

class _AddAddressPageState extends State<AddAddressPage> {
  String currentOption = options[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Add Address',
          style: GoogleFonts.prata(),
        )),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: Responsive.height * 0.27,
                    width: Responsive.width * 1,
                    decoration: BoxDecoration(
                        color: colorGrey7,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height10,
                          AddressTitle(title: 'Contact Info'),
                          height10,
                          AddressFieldWidget(labelText: 'Full Name'),
                          height10,
                          AddressFieldWidget(
                            labelText: 'Phone Number (+91)',
                            keyboardType: TextInputType.phone,
                          )
                        ],
                      ),
                    ),
                  ),
                  height20,
                  Container(
                    height: Responsive.height * 0.55,
                    width: Responsive.width * 1,
                    decoration: const BoxDecoration(
                        color: colorGrey7,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height10,
                          AddressTitle(title: 'Address Info'),
                          height10,
                          Row(
                            children: [
                              Expanded(
                                  child: AddressFieldWidget(
                                labelText: 'Pincode',
                                keyboardType: TextInputType.number,
                              )),
                              width10,
                              Expanded(
                                  child: AddressFieldWidget(
                                labelText: 'City',
                              )),
                            ],
                          ),
                          height10,
                          AddressFieldWidget(labelText: 'State'),
                          height10,
                          AddressFieldWidget(
                              labelText: 'Locality / Area / Street'),
                          height10,
                          AddressFieldWidget(
                              labelText: 'Flat No / Building Name'),
                          height10,
                          AddressFieldWidget(labelText: 'Landmark')
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
                              onChanged: (value) {
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
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  height10,
                  CustomButton(
                      width: Responsive.width,
                      child: Text(
                        'Add Address',
                        style: GoogleFonts.prata(
                            color: ConstColor.whiteColor, fontSize: 18),
                      ),
                      onTap: () {})
                ],
              ),
            );
          },
        ));
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
  const AddressFieldWidget({
    required this.labelText,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
