import 'package:bottom_bar_matu/components/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/view/address/view_address.dart';
import 'package:linen_republic/features/authentication/view/login/login_screen.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: GoogleFonts.prata(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Responsive.height * 0.12,
                  width: Responsive.width * 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorGrey4),
                    color: colorGrey7,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'User Name',
                        style:
                            GoogleFonts.prata(color: colorGrey1, fontSize: 20),
                      ),
                      Text(
                        'username123@gmail.com',
                        style:
                            GoogleFonts.prata(color: colorGrey1, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                height30,
                Container(
                  height: Responsive.height * 0.27,
                  width: Responsive.width * 1,
                  decoration: BoxDecoration(
                    color: colorGrey7,
                    border: Border.all(
                      color: colorGrey5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Personal Details',
                                  style: GoogleFonts.prata(
                                      color: colorGrey2, fontSize: 19)),
                              const Icon(Icons.chevron_right_outlined,
                                  size: 26, color: colorGrey2)
                            ],
                          ),
                        ),
                        height10,
                        const Divider(),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('My Orders',
                                  style: GoogleFonts.prata(
                                      color: colorGrey2, fontSize: 19)),
                              const Icon(Icons.chevron_right_outlined,
                                  size: 26, color: colorGrey2)
                            ],
                          ),
                        ),
                        height10,
                        const Divider(),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('My Favorites',
                                  style: GoogleFonts.prata(
                                      color: colorGrey2, fontSize: 19)),
                              const Icon(Icons.chevron_right_outlined,
                                  size: 26, color: colorGrey2)
                            ],
                          ),
                        ),
                        height10,
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ViewAddressPage(),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('My Address',
                                  style: GoogleFonts.prata(
                                      color: colorGrey2, fontSize: 19)),
                              const Icon(Icons.chevron_right_outlined,
                                  size: 26, color: colorGrey2)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                height10,
                Container(
                  height: Responsive.height * 0.21,
                  width: Responsive.width * 1,
                  decoration: BoxDecoration(
                    color: colorGrey7,
                    border: Border.all(
                      color: colorGrey5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Privacy Policy',
                                  style: GoogleFonts.prata(
                                      color: colorGrey2, fontSize: 19)),
                              const Icon(Icons.chevron_right_outlined,
                                  size: 26, color: colorGrey2)
                            ],
                          ),
                        ),
                        height10,
                        const Divider(),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('About Us',
                                  style: GoogleFonts.prata(
                                      color: colorGrey2, fontSize: 19)),
                              const Icon(Icons.chevron_right_outlined,
                                  size: 26, color: colorGrey2)
                            ],
                          ),
                        ),
                        height10,
                        const Divider(),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Terms and Conditions',
                                  style: GoogleFonts.prata(
                                      color: colorGrey2, fontSize: 19)),
                              const Icon(Icons.chevron_right_outlined,
                                  size: 26, color: colorGrey2)
                            ],
                          ),
                        ),
                        height10,
                      ],
                    ),
                  ),
                ),
                height20,
                InkWell(
                  onTap: () {
                    _showDailogue(context);
                  },
                  child: Container(
                    height: Responsive.height * 0.060,
                    width: Responsive.width * 0.99,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'Log Out',
                        style: GoogleFonts.prata(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showDailogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Logout !',
            style: GoogleFonts.prata(),
          ),
          content: Text(
            'Do you want to LogOut ?',
            style: GoogleFonts.prata(),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              child: Text(
                'Yes',
                style: GoogleFonts.prata(),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: GoogleFonts.prata(),
              ),
            )
          ],
        );
      },
    );
  }
}
