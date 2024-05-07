import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/constants/app_styles.dart';
import 'package:lamie_middle_east/constants/image_strings.dart';
import 'package:lamie_middle_east/controller/signup/signup_bloc.dart';
import 'package:lamie_middle_east/utils/snackbar.dart';
import 'package:lamie_middle_east/utils/validation.dart';
import 'package:lamie_middle_east/view/login_screen.dart';
import 'package:lamie_middle_east/widgets/button_widget.dart';
import 'package:lamie_middle_east/widgets/textformfied_widget.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImageStrings.signupBackgroundImage),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: signupKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create an account", style: AppFonts.welcomeStyle),
                    Text("Sign up to join", style: AppFonts.normalBold),
                    TextFormFieldWidget(
                      hintText: 'Email',
                      controller: emailController,
                      validator: (value) => Validation.isEmail(value?.trim()),
                      isLabel: true,
                    ),
                    TextFormFieldWidget(
                      hintText: 'User Name',
                      controller: usernameController,
                      validator: (value) =>
                          Validation.isEmpty(value?.trim(), 'User Name'),
                      isLabel: true,
                    ),
                    TextFormFieldWidget(
                      hintText: 'Password',
                      controller: passwordController,
                      validator: (value) =>
                          Validation.isPassword(value?.trim()),
                      isLabel: true,
                    ),
                    TextFormFieldWidget(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      validator: (value) => Validation.isPasswordMatch(
                          value, passwordController.text.trim()),
                      isLabel: true,
                    ),
                    const SizedBox(height: 20),
                    BlocListener<SignupBloc, SignupState>(
                      listener: (context, state) {
                        if (state is SignupFailedState) {
                          topSnackbar(context, state.message, AppColors.orange);
                        }
                      },
                      child: ButtonWidget(
                          title: 'Register',
                          onPress: () {
                            if (signupKey.currentState!.validate()) {
                              Map<String, dynamic> userData = {
                                'email': emailController.text,
                                'username': usernameController.text,
                                'password': passwordController.text,
                                'password2': confirmPasswordController.text,
                                'is_google': false,
                              };
                              context.read<SignupBloc>().add(
                                  SignupButtonClickedEvent(
                                      userData: userData, context: context));
                            }
                          }),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account?',
                          style: TextStyle(color: AppColors.black),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen())),
                          child: Text(
                            'Sign In',
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
            ),
          ),
        ),
      ),
    );
  }
}
