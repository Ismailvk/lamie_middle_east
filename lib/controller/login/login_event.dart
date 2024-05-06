part of 'login_bloc.dart';

sealed class LoginEvent {}

final class LoginButtonClickedEvent extends LoginEvent {
  final Map<String, String> loginData;
  BuildContext context;

  LoginButtonClickedEvent({required this.loginData, required this.context});
}

final class GetLoggedUserData extends LoginEvent {
  final int userId;
  final String token;

  GetLoggedUserData({required this.userId, required this.token});
}
