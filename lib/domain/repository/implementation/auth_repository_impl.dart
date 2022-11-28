import 'package:admin/data/api/dio.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/repository/abstraction/auth_repository.dart';

import '../../models/request/login_request.dart';

class AuthRepositoryImpl extends AuthRepository {
  final DioClient _client;

  @override
  Stream<DomainResult> login(String email, String password) async* {
    try {
      yield DomainLoading();
      if (email.trim().isEmpty || password.trim().isEmpty) {
        yield DomainError(message: 'Malumotlarni oxirigacha toldiring.');
      } else {
        var response = await (await _client.request()).post('v1/login',
            data: LoginRequest(email: email, password: password).toJson());
        if (response.statusCode == 200) {
          yield DomainSuccess();
        } else {
          yield DomainError(message: 'Xatolik yuz berdi...');
        }
      }
    } catch (e) {
      yield DomainError(message: 'Nomalum xatolik yuz berdi');
    }
  }

  AuthRepositoryImpl({
    required DioClient client,
  }) : _client = client;
}
