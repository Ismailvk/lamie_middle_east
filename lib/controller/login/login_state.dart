part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class GetUserDataSuccessState extends LoginState {
  final List<Connection> chatList;

  GetUserDataSuccessState({required this.chatList});
}
