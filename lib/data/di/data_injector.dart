import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../di/injector.dart';
import '../api/dio.dart';

Future<void> initDataDependencies() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
}
