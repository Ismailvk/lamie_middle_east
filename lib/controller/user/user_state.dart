part of 'user_bloc.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class UserSearchingSuccessState extends UserState {
  final List<User> userList;

  UserSearchingSuccessState({required this.userList});
}
