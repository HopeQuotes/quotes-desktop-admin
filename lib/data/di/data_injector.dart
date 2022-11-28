import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../di/injector.dart';
import '../api/dio.dart';

void initDataDependencies() async {
  injector.registerSingleton<DioClient>(DioClient());
  Hive.init((await getApplicationDocumentsDirectory()).path);
}
