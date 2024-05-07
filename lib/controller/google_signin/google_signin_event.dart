part of 'google_signin_bloc.dart';

abstract class GoogleSigninEvent {}

final class GoogleUserSigninEvent extends GoogleSigninEvent {}

final class PassLoginDetailsToApiEvent extends GoogleSigninEvent {
  final Map<String, dynamic> map;
  PassLoginDetailsToApiEvent({required this.map});
}

final class GoogleUserSignOutEvent extends GoogleSigninEvent {}
