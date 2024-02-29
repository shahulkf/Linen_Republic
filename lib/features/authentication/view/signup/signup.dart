import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/authentication/controller/bloc/bloc/auth_bloc.dart';
import 'package:linen_republic/features/authentication/model/sign_up_model.dart';
import 'package:linen_republic/features/authentication/view/widgets/buttons.dart';
import 'package:linen_republic/features/authentication/view/widgets/textfield.dart';
import 'package:linen_republic/features/home/view/main_page.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBlocBloc>(context);
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
                  controller: authBloc.userNameController),
              height20,
              TextFieldWidget(
                  hintText: 'Email',
                  prefixIcon: Icons.mail_outline_outlined,
                  controller: authBloc.emailController),
              height20,
              TextFieldWidget(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.visibility_off_outlined,
                  controller: authBloc.passwordController),
              height20,
              TextFieldWidget(
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                controller: authBloc.confirmPasswordcontroller,
                obscureText: true,
              ),
              height30,
              BlocConsumer<AuthBlocBloc, AuthBlocState>(
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is SignUpErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                      width: Responsive.width,
                      child: state is SignUpLoadingState
                          ? const CircularProgressIndicator()
                          : const Text(
                              'SignUp',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                      onTap: () {
                        // call the signup event
                        print('sign up ');
                        final signUpModel = SignUpModel(
                            userName: authBloc.userNameController.text.trim(),
                            email: authBloc.emailController.text.trim(),
                            password: authBloc.passwordController.text.trim());
                        context
                            .read<AuthBlocBloc>()
                            .add(SingUpClickedEvent(signUpModel: signUpModel));
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
