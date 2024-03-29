import 'package:admin/data/di/data_injector.dart';
import 'package:admin/domain/di/domain_injector.dart';
import 'package:admin/screens/auth/bloc/auth_bloc.dart';
import 'package:admin/screens/entrance/bloc/splash_bloc.dart';
import 'package:admin/screens/hashtag/bloc/hashtag_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../data/cache/adapters.dart';
import '../screens/create_quote/bloc/create_quote_bloc.dart';
import '../screens/quotes/bloc/quotes_bloc.dart';

GetIt injector = GetIt.instance;

void initDependencies() async {
  await initDataDependencies();
  if (!kIsWeb) registerAdapters();
  initDomainDependencies();
}
