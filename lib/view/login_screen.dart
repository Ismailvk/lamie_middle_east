// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/constants/app_styles.dart';
import 'package:lamie_middle_east/constants/image_strings.dart';
import 'package:lamie_middle_east/controller/google_signin/google_signin_bloc.dart';
import 'package:lamie_middle_east/controller/login/login_bloc.dart';
import 'package:lamie_middle_east/utils/snackbar.dart';
import 'package:lamie_middle_east/utils/validation.dart';
import 'package:lamie_middle_east/view/home_screen.dart';
import 'package:lamie_middle_east/view/signup_screen.dart';
import 'package:lamie_middle_east/widgets/button_widget.dart';
import 'package:lamie_middle_east/widgets/google_button_widget.dart';
import 'package:lamie_middle_east/widgets/textformfied_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Form(
                key: loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppImageStrings.loginImage),
                    Text('Welcome Back!', style: AppFonts.welcomeStyle),
                    const Text('Login your Account'),
                    const SizedBox(height: 2),
                    Text('Username or Email', style: AppFonts.normalBoldBlack),
                    TextFormFieldWidget(
                      hintText: 'Email',
                      controller: emailController,
                      validator: (value) =>
                          Validation.isEmpty(value?.trim(), 'email'),
                      isLabel: false,
                    ),
                    Text('Password', style: AppFonts.normalBoldBlack),
                    TextFormFieldWidget(
                      hintText: 'Password',
                      controller: passwordController,
                      validator: (value) =>
                          Validation.isPassword(value?.trim()),
                      isLabel: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {},
                        child: ButtonWidget(
                          title: 'LOGIN',
                          onPress: () {
                            if (loginKey.currentState!.validate()) {
                              final loginData = {
                                'email': emailController.text,
                                'password': passwordController.text,
                              };
                              context.read<LoginBloc>().add(
                                  LoginButtonClickedEvent(
                                      loginData: loginData, context: context));
                            }
                          },
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('OR')],
                    ),
                    BlocListener<GoogleSigninBloc, GoogleSigninState>(
                      listener: (context, state) {
                        if (state is GoogleSigninSuccessState) {
                          Map<String, String> signinData = {
                            'email': state.email,
                            'access_token': state.accessToken,
                          };
                          context
                              .read<GoogleSigninBloc>()
                              .add(PassLoginDetailsToApiEvent(map: signinData));
                        } else if (state is GoogleSigninFailedState) {
                          return topSnackbar(
                              context, state.errorMessage, AppColors.red);
                        } else if (state is PassLoginDetailsToApiSuccessState) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false);
                        } else if (state is PassLoginDetailsToApiFailedState) {
                          return topSnackbar(
                              context, state.errorMessage, AppColors.red);
                        }
                      },
                      child: GoogleButtonWidget(
                          title: 'Signup With Google',
                          onPress: () {
                            context
                                .read<GoogleSigninBloc>()
                                .add(GoogleUserSigninEvent());
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You don't Have an account?",
                          style: TextStyle(color: AppColors.black),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen())),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
