import 'dart:async';

import 'package:admin/domain/models/ui/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/abstraction/dashboard_repository.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc(this.repository) : super(DashboardState()) {
    on<GetProfile>(_getProfile);
  }

  Future<void> _getProfile(GetProfile event, Emitter emitter) async {
    var user = await repository.getUser();
    emitter(state.copyWith(user: user));
  }
}
