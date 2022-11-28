import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/state/domain_result.dart';
import '../../../domain/repository/abstraction/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthBloc(this._repository)
      : super(AuthState(authStatus: AuthStatus.initial)) {
    on<TryLogin>(_tryLogin);
  }

  Future<void> _tryLogin(TryLogin event, Emitter emitter) async {
    return emitter.forEach(
        _repository.login(emailController.text, passwordController.text),
        onData: (data) {
      if (data is DomainLoading) {
        return state.copyWith(authStatus: AuthStatus.loading);
      }
      if (data is DomainSuccess) {
        return state.copyWith(authStatus: AuthStatus.success);
      }
      if (data is DomainError) {
        return state.copyWith(
            authStatus: AuthStatus.fail, message: data.message);
      }
      return state.copyWith(authStatus: AuthStatus.initial);
    });
  }
}
