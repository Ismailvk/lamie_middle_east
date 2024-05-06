part of 'signup_bloc.dart';

sealed class SignupEvent {}

final class SignupButtonClickedEvent extends SignupEvent {
  final Map<String, dynamic> userData;
  final BuildContext context;

  SignupButtonClickedEvent({required this.context, required this.userData});
}
