import 'package:admin/data/api/dio.dart';
import 'package:admin/data/cache/box.dart';
import 'package:admin/data/cache/keys.dart';
import 'package:admin/domain/models/cache/user_cache.dart';
import 'package:admin/domain/models/ui/user.dart';
import 'package:admin/domain/repository/abstraction/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DioClient _client;

  @override
  Future<User> getUser() async {
    var box = (await getBox<UserCache>(HiveKeys.profile)).get(HiveKeys.profile);
    return User(name: box?.name ?? "", email: box?.email ?? "");
  }

  DashboardRepositoryImpl({
    required DioClient client,
  }) : _client = client;
}
