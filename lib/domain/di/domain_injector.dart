import 'package:admin/domain/repository/abstraction/auth_repository.dart';
import 'package:admin/domain/repository/implementation/auth_repository_impl.dart';
import 'package:admin/domain/repository/implementation/quote_repository_impl.dart';

import '../../di/injector.dart';

void initDomainDependencies() {
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl(client: injector()));
  injector.registerSingleton<QuoteRepositoryImpl>(QuoteRepositoryImpl(client: injector()));
}
