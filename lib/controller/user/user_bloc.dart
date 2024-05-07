import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lamie_middle_east/constants/app_colors.dart';
import 'package:lamie_middle_east/model/user_model.dart';
import 'package:lamie_middle_east/repositories/user_repo.dart';
import 'package:lamie_middle_east/utils/loading.dart';
import 'package:lamie_middle_east/utils/snackbar.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserSearchingEvent>(userSearching);
  }

  Timer? _debounceTimer;

  FutureOr<void> userSearching(
      UserSearchingEvent event, Emitter<UserState> emit) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(seconds: 2), () async {
      // LoadingController.showLoadingDialog(event.context);
      try {
        final response = await UserRepo().searchingUser(event.searchValue);
        response.fold((error) {
          // LoadingController.hideLoadingDialog(event.context);
          return topSnackbar(
              event.context, 'Something Went Wrong', AppColors.red);
        }, (response) {
          // LoadingController.hideLoadingDialog(event.context);
          List data = response as List;
          List<User> users = data.map((e) => User.fromJson(e)).toList();
          List<User> searchData = users
              .where((user) => user.username
                  .toString()
                  .toLowerCase()
                  .contains(event.searchValue.toString().toLowerCase()))
              .toList();
          emit(UserSearchingSuccessState(userList: searchData));
        });
      } catch (e) {
        //
      }
    });
  }
}
