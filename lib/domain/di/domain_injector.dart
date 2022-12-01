import 'package:admin/domain/repository/abstraction/auth_repository.dart';
import 'package:admin/domain/repository/abstraction/entrance_repository.dart';
import 'package:admin/domain/repository/abstraction/hashtag_repository.dart';
import 'package:admin/domain/repository/abstraction/quote_repository.dart';
import 'package:admin/domain/repository/implementation/auth_repository_impl.dart';
import 'package:admin/domain/repository/implementation/entrance_repository_impl.dart';
import 'package:admin/domain/repository/implementation/hashtag_repository_impl.dart';
import 'package:admin/domain/repository/implementation/quote_repository_impl.dart';

import '../../di/injector.dart';

void initDomainDependencies() {
  injector.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(client: injector()));
  injector.registerSingleton<QuoteRepository>(
      QuoteRepositoryImpl(client: injector()));
  injector.registerSingleton<EntranceRepository>(EntranceRepositoryImpl());
  injector.registerSingleton<HashtagRepository>(HashtagRepositoryImpl(client: injector()));

}
