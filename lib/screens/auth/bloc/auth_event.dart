part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class TryLogin extends AuthEvent {
  TryLogin();
}
