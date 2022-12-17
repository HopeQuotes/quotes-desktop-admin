import '../../models/ui/user.dart';

abstract class DashboardRepository {
  Future<User> getUser();
}
