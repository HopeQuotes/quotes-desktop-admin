import '../../di/injector.dart';
import '../api/dio.dart';

void initDataDependencies() {
  injector.registerSingleton<DioClient>(DioClient());
}
