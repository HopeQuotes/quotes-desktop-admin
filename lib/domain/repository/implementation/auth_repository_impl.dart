import 'dart:convert';

import 'package:admin/data/api/dio.dart';
import 'package:admin/data/cache/box.dart';
import 'package:admin/data/cache/keys.dart';
import 'package:admin/domain/mappers/ui/user_mapper.dart';
import 'package:admin/domain/models/base/base_response.dart';
import 'package:admin/domain/models/cache/user_cache.dart';
import 'package:admin/domain/models/response/user_response.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/repository/abstraction/auth_repository.dart';
import 'package:hive/hive.dart';

import '../../models/request/login_request.dart';
import '../../models/ui/user.dart';

class AuthRepositoryImpl extends AuthRepository {
  final DioClient _client;

  AuthRepositoryImpl({
    required DioClient client,
  }) : _client = client;

  @override
  Stream<DomainResult> login(String email, String password) async* {
    try {
      yield DomainLoading();
      if (email.trim().isEmpty || password.trim().isEmpty) {
        yield DomainError(message: 'Malumotlarni oxirigacha toldiring.');
      } else {
        var response = await _client.post('v1/login',
            data: LoginRequest(email: email, password: password).toJson());

        var decoded = BaseResponse<UserResponse>.fromJson(
            jsonDecode(response.data), (p0) => UserResponse.fromJson(p0));
        await saveUser(decoded.data.toCache());

        yield DomainSuccess();
      }
    } catch (e) {
      yield DomainError(message: 'Nomalum xatolik yuz berdi');
    }
  }

  @override
  Future<void> saveUser(UserCache user) async {
    await (await getBox<UserCache>(HiveKeys.profile))
        .put(HiveKeys.profile, user);
  }
}
