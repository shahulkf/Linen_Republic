import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/authentication/view/widgets/buttons.dart';
import 'package:linen_republic/features/authentication/view/widgets/textfield.dart';
import 'package:linen_republic/features/home/view/main_page.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(AppStrings.signUp, style: GoogleFonts.prata(fontSize: 35)),
              Text(AppStrings.signUpTitle,
                  style: GoogleFonts.prata(color: textColors)),
              height30,
              TextFieldWidget(
                  hintText: 'Username',
                  prefixIcon: Icons.account_circle_outlined,
                  controller: _userNameController),
              height20,
              TextFieldWidget(
                  hintText: 'Email',
                  prefixIcon: Icons.mail_outline_outlined,
                  controller: _emailController),
              height20,
              TextFieldWidget(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.visibility_off_outlined,
                  controller: _passwordController),
              height20,
              TextFieldWidget(
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                controller: _confirmPasswordcontroller,
                obscureText: true,
              ),
              height30,
              CustomButton(
                  width: Responsive.width,
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
