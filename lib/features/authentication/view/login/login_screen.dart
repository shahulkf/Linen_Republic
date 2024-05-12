import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/authentication/controller/bloc/bloc/auth_bloc.dart';
import 'package:linen_republic/features/authentication/model/login_model.dart';
import 'package:linen_republic/features/authentication/view/signup/signup.dart';
import 'package:linen_republic/features/authentication/view/widgets/buttons.dart';
import 'package:linen_republic/features/authentication/view/widgets/textfield.dart';
import 'package:linen_republic/features/home/view/main_page.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

final formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBlocBloc>(context);
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
              height100,
              Text(
                AppStrings.welcome,
                style: GoogleFonts.prata(fontSize: 35),
              ),
              Text(
                AppStrings.loginSubtitle,
                style: GoogleFonts.prata(color: Colors.grey),
              ),
              height30,
              _buildInputFields(authBloc),
              height10,
              _buildSignUpLInk(context),
              height20,
              _buildLoginButton(authBloc),
              height20,
              _buildGoogleSignupButton()
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSignUpLInk(BuildContext context) {
    return Row(
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
                    builder: (context) => const SignUpScreen(),
                  ));
            },
            child: const Text('signUp')),
      ],
    );
  }

  Widget _buildInputFields(AuthBlocBloc authBloc) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldWidget(
            controller: authBloc.loginEmailController,
            hintText: 'Email',
            prefixIcon: Icons.mail_outline,
          ),
          height20,
          TextFieldWidget(
              controller: authBloc.loginPasswordController,
              hintText: 'Password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: Icons.visibility_off_outlined),
        ],
      ),
    );
  }

  BlocConsumer<AuthBlocBloc, AuthBlocState> _buildGoogleSignupButton() {
    return BlocConsumer<AuthBlocBloc, AuthBlocState>(
      listenWhen: (previous, current) =>
          current is GoogleAuthSuccessState || current is GoogleAuthErrorState,
      buildWhen: (previous, current) => current is GoogleAuthLoadingState,
      listener: (context, state) {
        if (state is GoogleAuthSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
              (route) => false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is GoogleAuthErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return CustomButton(
            backgroundColor: textColors,
            width: Responsive.width,
            child: state is GoogleAuthLoadingState
                ? const CircularProgressIndicator()
                : const Text(
                    'Continue with google',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
            onTap: () {
              context.read<AuthBlocBloc>().add(GoogleAuthEvent());
            });
      },
    );
  }

  BlocConsumer<AuthBlocBloc, AuthBlocState> _buildLoginButton(
      AuthBlocBloc authBloc) {
    return BlocConsumer<AuthBlocBloc, AuthBlocState>(
      listenWhen: (previous, current) =>
          current is LoginErrorState || current is LoginSuccessState,
      buildWhen: (previous, current) =>
          current is LoginLoadingState || current is LoginErrorState,
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false,
          );
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return CustomButton(
          width: Responsive.width,
          child: state is LoginLoadingState
              ? const CircularProgressIndicator()
              : const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
          onTap: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthBlocBloc>().add(LoginClickedEvent(
                  loginModel: LoginModel(
                      email: authBloc.loginEmailController.text.trim(),
                      password: authBloc.loginPasswordController.text.trim())));
            }
          },
        );
      },
    );
  }
}
