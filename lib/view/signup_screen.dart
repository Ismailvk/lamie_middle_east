import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_styles.dart';
import 'package:lamie_middle_east/constants/image_strings.dart';
import 'package:lamie_middle_east/utils/validation.dart';
import 'package:lamie_middle_east/widgets/button_widget.dart';
import 'package:lamie_middle_east/widgets/textformfied_widget.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create an account", style: AppFonts.welcomeStyle),
                  Text("Sign up to join", style: AppFonts.normalBold),
                  TextFormFieldWidget(
                    hintText: 'Email',
                    controller: emailController,
                    validator: (value) => Validation.isEmail(value),
                    isLabel: true,
                  ),
                  TextFormFieldWidget(
                    hintText: 'User Name',
                    controller: usernameController,
                    validator: (value) =>
                        Validation.isEmpty(value, 'User Name'),
                    isLabel: true,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Password',
                    controller: passwordController,
                    validator: (value) => Validation.isPassword(value),
                    isLabel: true,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Confirm Password',
                    controller: confirmPasswordController,
                    validator: (value) => Validation.isPasswordMatch(
                        value, passwordController.text),
                    isLabel: true,
                  ),
                  const SizedBox(height: 10),
                  ButtonWidget(title: 'Register', onPress: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
