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
      if (email.trim().isEmpty) {
        yield DomainValidationError(message: 'Emailingizni yozing.');
      } else {
        var response = await (await _client.request()).post('login',
            data: LoginRequest(email: email, password: password).toJson());
        if (response.statusCode == 200) {
          yield DomainSuccess();
        } else {
          yield DomainError(message: 'Xatolik yuz berdi...');
        }
      }
    } catch (e) {
      yield DomainError();
    }
  }

  AuthRepositoryImpl({
    required DioClient client,
  }) : _client = client;
}
