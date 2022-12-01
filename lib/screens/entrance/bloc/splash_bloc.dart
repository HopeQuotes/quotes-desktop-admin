import 'dart:async';

import 'package:admin/domain/models/state/domain_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/abstraction/entrance_repository.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final EntranceRepository _repository;

  SplashBloc(this._repository) : super(SplashState()) {
    on<CheckUserStatus>(_checkUserStatus);
  }

  Future<void> _checkUserStatus(CheckUserStatus evsent, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getUserStatus(),
        onData: (data) {
      if (data is DomainSuccess) {
        return state.copyWith(status: SplashStatus.authorized);
      } else {
        return state.copyWith(status: SplashStatus.unAuthorized);
      }
    });
  }
}
