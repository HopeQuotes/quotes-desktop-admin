import 'package:admin/domain/repository/abstraction/auth_repository.dart';
import 'package:admin/domain/repository/abstraction/entrance_repository.dart';
import 'package:admin/domain/repository/abstraction/hashtag_repository.dart';
import 'package:admin/domain/repository/abstraction/quote_repository.dart';
import 'package:admin/domain/repository/abstraction/quotes_repository.dart';
import 'package:admin/domain/repository/implementation/auth_repository_impl.dart';
import 'package:admin/domain/repository/implementation/entrance_repository_impl.dart';
import 'package:admin/domain/repository/implementation/hashtag_repository_impl.dart';
import 'package:admin/domain/repository/implementation/create_quote_repository_impl.dart';
import 'package:admin/domain/repository/implementation/quotes_repository_impl.dart';

import '../../data/api/dio.dart';
import '../../di/injector.dart';
import '../repository/abstraction/dashboard_repository.dart';
import '../repository/implementation/dashboard_repository_impl.dart';

void initDomainDependencies() {
  injector.registerSingleton<DioClient>(DioClient());
  injector.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(client: injector()));
  injector.registerSingleton<QuoteRepository>(
      CreateQuoteRepositoryImpl(client: injector()));
  injector.registerSingleton<EntranceRepository>(EntranceRepositoryImpl());
  injector.registerSingleton<HashtagRepository>(
      HashtagRepositoryImpl(client: injector()));
  injector.registerSingleton<QuotesRepository>(
      QuotesRepositoryImpl(client: injector()));
  injector.registerSingleton<DashboardRepository>(
      DashboardRepositoryImpl(client: injector()));
}
