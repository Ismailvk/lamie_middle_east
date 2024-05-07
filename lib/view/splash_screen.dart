// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lamie_middle_east/controller/login/login_bloc.dart';
import 'package:lamie_middle_east/data/shared_preference/shared_preference.dart';
import 'package:lamie_middle_east/view/home_screen.dart';
import 'package:lamie_middle_east/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loginCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Lamie Middle East'),
      ),
    );
  }

  loginCheck() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = SharedPref.instance.getToken();
    if (token != null) {
      Map<String, dynamic> decodeJwtToken = JwtDecoder.decode(token);
      int decodedToken = decodeJwtToken['user_id'];
      context.read<LoginBloc>().add(GetLoggedUserData(
          userId: decodedToken, token: token, context: context));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
  }
}
