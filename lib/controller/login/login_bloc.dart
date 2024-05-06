import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/data/shared_preference/shared_preference.dart';
import 'package:lamie_middle_east/repositories/user_repo.dart';
import 'package:lamie_middle_east/utils/loading.dart';
import 'package:lamie_middle_east/utils/snackbar.dart';
import 'package:lamie_middle_east/view/home_screen.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(login);
  }

  FutureOr<void> login(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) {
    LoadingController.showLoadingDialog(event.context);
    try {
      final response = UserRepo().login(event.loginData);
      response.fold((error) {
        topSnackbar(event.context, error.message, AppColors.red);
      }, (response) {
        SharedPref.instance.storeToken(response['access']);
        Navigator.of(event.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (conntext) => const HomeScreen()),
            (route) => false);
      });
    } catch (e) {
      topSnackbar(event.context, 'Something Went Wrong', AppColors.red);
    }
  }
}
