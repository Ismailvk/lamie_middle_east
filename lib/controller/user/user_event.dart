part of 'user_bloc.dart';

sealed class UserEvent {}

final class UserSearchingEvent extends UserEvent {
  final String searchValue;
  BuildContext context;

  UserSearchingEvent({required this.searchValue, required this.context});
}
