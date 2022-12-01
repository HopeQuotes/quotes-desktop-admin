import 'package:admin/data/cache/box.dart';
import 'package:admin/domain/models/cache/user_cache.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/repository/abstraction/entrance_repository.dart';

import '../../../data/cache/keys.dart';

class EntranceRepositoryImpl extends EntranceRepository {
  @override
  Stream<DomainResult> getUserStatus() async* {
    var box = await (getBox<UserCache>(HiveKeys.profile));
    if (box.get(HiveKeys.profile) != null) {
      yield DomainSuccess();
    } else {
      yield DomainError();
    }
  }
}
