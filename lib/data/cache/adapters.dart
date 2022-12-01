import 'dart:developer';

import 'package:admin/domain/models/cache/user_cache.dart';
import 'package:hive/hive.dart';

void registerAdapters() {
  Hive.registerAdapter<UserCache>(UserCacheAdapter());
}
