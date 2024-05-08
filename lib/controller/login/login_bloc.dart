// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/data/shared_preference/shared_preference.dart';
import 'package:lamie_middle_east/model/user_model.dart';
import 'package:lamie_middle_east/repositories/user_repo.dart';
import 'package:lamie_middle_east/utils/loading.dart';
import 'package:lamie_middle_east/utils/snackbar.dart';
import 'package:lamie_middle_east/view/home_screen.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(login);
    on<GetLoggedUserData>(getLoggedUserData);
  }

  FutureOr<void> login(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    LoadingController.showLoadingDialog(event.context);
    try {
      final response = await UserRepo().login(event.loginData);
      response.fold((error) {
        LoadingController.hideLoadingDialog(event.context);
        return topSnackbar(event.context, error.message, AppColors.red);
      }, (response) {
        LoadingController.hideLoadingDialog(event.context);
        SharedPref.instance.storeToken(response['access']);
        Navigator.of(event.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      });
    } catch (e) {
      topSnackbar(event.context, 'Something Went Wrong', AppColors.red);
      LoadingController.hideLoadingDialog(event.context);
    }
  }

  FutureOr<void> getLoggedUserData(
      GetLoggedUserData event, Emitter<LoginState> emit) async {
    try {
      final response =
          await UserRepo().getLoggedUserData(event.userId, event.token);
      response.fold((error) {
        topSnackbar(event.context, error.message, AppColors.red);
      }, (response) {
        final loggedUserData = User.fromJson(response);
        List<Connection> connectionData = [];
        if (loggedUserData.connections!.isNotEmpty) {
          connectionData = loggedUserData.connections!;
        }
        emit(GetUserDataSuccessState(chatList: connectionData));
      });
    } catch (e) {
      //
    }
  }
}
