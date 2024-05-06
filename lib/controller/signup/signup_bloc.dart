import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/repositories/user_repo.dart';
import 'package:lamie_middle_east/utils/loading.dart';
import 'package:lamie_middle_east/utils/snackbar.dart';
import 'package:lamie_middle_east/view/login_screen.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonClickedEvent>(signup);
  }

  FutureOr<void> signup(
      SignupButtonClickedEvent event, Emitter<SignupState> emit) {
    LoadingController.showLoadingDialog(event.context);
    try {
      final response = UserRepo().signupUser(event.userData);
      response.fold((error) {
        emit(SignupFailedState(message: error.message));
      }, (response) {
        if (response['Text'] == 'registered') {
          LoadingController.hideLoadingDialog(event.context);
          topSnackbar(event.context,
              'Please Activate and Login back your account', AppColors.green);
          Navigator.of(event.context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        } else {
          LoadingController.hideLoadingDialog(event.context);
          String message = '';

          if (response['Text']['email'] != null) {
            if (response['Text']['email'][0] != null) {
              message += response['Text']['email'][0];
            } else {
              message += response['Text']['email'][0];
            }
          }
          if (response['Text']['username'][0] != null) {
            message += response['Text']['username'][0];
          }
          topSnackbar(event.context, message, Colors.orange);
        }
      });
    } catch (e) {
      LoadingController.hideLoadingDialog(event.context);
    }
  }
}
