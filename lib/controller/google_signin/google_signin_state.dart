part of 'google_signin_bloc.dart';

abstract class GoogleSigninState {}

final class GoogleSigninInitial extends GoogleSigninState {}

final class GoogleSigninSuccessState extends GoogleSigninState {
  final String accessToken;
  final String email;
  GoogleSigninSuccessState({required this.accessToken, required this.email});
}

final class GoogleSigninFailedState extends GoogleSigninState {
  final String errorMessage;
  GoogleSigninFailedState({required this.errorMessage});
}

final class GoogleSigninLoadingState extends GoogleSigninState {}

final class GoogleSignOutSuccessState extends GoogleSigninState {}

final class GoogleSignOutFailedState extends GoogleSigninState {}

final class PassLoginDetailsToApiSuccessState extends GoogleSigninState {}

final class PassLoginDetailsToApiFailedState extends GoogleSigninState {
  final String errorMessage;
  PassLoginDetailsToApiFailedState({required this.errorMessage});
}
