import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/controller/login/login_bloc.dart';
import 'package:lamie_middle_east/controller/signup/signup_bloc.dart';
import 'package:lamie_middle_east/data/shared_preference/shared_preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPref.instance.initStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
