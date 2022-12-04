import 'dart:async';

import 'package:admin/data/cache/box.dart';
import 'package:admin/domain/models/cache/user_cache.dart';
import 'package:admin/screens/settings/bloc/settings_event.dart';
import 'package:admin/screens/settings/bloc/settings_state.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../data/cache/keys.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<LogOut>(_logOut);
  }

  Future<void> _logOut(LogOut event, Emitter emitter) async {
    await (await getBox<UserCache>(HiveKeys.profile)).clear();
  }
}
