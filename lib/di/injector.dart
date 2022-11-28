import 'package:admin/data/api/dio.dart';
import 'package:admin/data/di/data_injector.dart';
import 'package:admin/domain/di/domain_injector.dart';
import 'package:admin/screens/auth/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

void initDependencies() {
  injector.registerFactory<AuthBloc>(() => AuthBloc(injector()));
  initDataDependencies();
  initDomainDependencies();
}
