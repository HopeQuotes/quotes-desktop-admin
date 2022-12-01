import 'package:admin/data/api/dio.dart';
import 'package:admin/data/di/data_injector.dart';
import 'package:admin/domain/di/domain_injector.dart';
import 'package:admin/screens/auth/bloc/auth_bloc.dart';
import 'package:admin/screens/entrance/bloc/splash_bloc.dart';
import 'package:admin/screens/hashtag/bloc/hashtag_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/cache/adapters.dart';

GetIt injector = GetIt.instance;

void initDependencies() {
  registerAdapters();
  initDataDependencies();
  initDomainDependencies();
  injector.registerFactory<AuthBloc>(() => AuthBloc(injector()));
  injector.registerFactory<SplashBloc>(() => SplashBloc(injector()));
  injector.registerFactory<HashtagBloc>(() => HashtagBloc(injector()));
}