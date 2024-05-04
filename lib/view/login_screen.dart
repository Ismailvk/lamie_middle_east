import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lamie_middle_east/constants/app_styles.dart';
import 'package:lamie_middle_east/constants/image_strings.dart';
import 'package:lamie_middle_east/utils/validation.dart';
import 'package:lamie_middle_east/widgets/button_widget.dart';
import 'package:lamie_middle_east/widgets/textformfied_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppImageStrings.loginImage),
                    Text(
                      'Welcome Back!',
                      style: AppFonts.welcomeStyle,
                    ),
                    const Text('Login your Account'),
                    SizedBox(height: size.height / 28),
                    Text('Username or Email', style: AppFonts.normalBold),
                    TextFormFieldWidget(
                      hintText: 'Email',
                      controller: emailController,
                      validator: (value) => Validation.isEmpty(value, 'email'),
                      isLabel: false,
                    ),
                    Text('Password', style: AppFonts.normalBold),
                    TextFormFieldWidget(
                      hintText: 'Password',
                      controller: passwordController,
                      validator: (value) => Validation.isPassword(value),
                      isLabel: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ButtonWidget(
                        title: 'LOGIN',
                        onPress: () {},
                      ),
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
