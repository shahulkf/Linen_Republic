import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/authentication/view/signup/signup.dart';
import 'package:linen_republic/features/authentication/view/widgets/buttons.dart';
import 'package:linen_republic/features/authentication/view/widgets/textfield.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.prata(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
              ),
              Text(
                AppStrings.welcome,
                style: GoogleFonts.prata(fontSize: 35),
              ),
              Text(
                AppStrings.loginSubtitle,
                style: GoogleFonts.prata(color: Colors.grey),
              ),
              height30,
              TextFieldWidget(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.mail_outline,
              ),
              height20,
              TextFieldWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.visibility_off_outlined),
              height10,
              Row(
                children: [
                  const Text(
                    'Already have an account ?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      child: const Text('signUp')),
                ],
              ),
              height20,
              CustomButton(
                width: Responsive.width,
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
                onTap: () {},
              ),
              height20,
              CustomButton(
                  backgroundColor: textColors,
                  width: Responsive.width,
                  child: const Text(
                    'Continue with google',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                  onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
