part of 'auth_bloc.dart';

enum AuthStatus { success, fail, loading, initial }

class AuthState extends Equatable {
  final AuthStatus? authStatus;
  final String? message;

  @override
  List<Object?> get props => [authStatus, message];

  AuthState({this.authStatus, this.message});

  AuthState copyWith({
    AuthStatus? authStatus,
    String? message,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      message: message ?? this.message,
    );
  }
}
