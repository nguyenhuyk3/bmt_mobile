import 'package:dio/dio.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/models.dart';

class SessionService {
  final Dio dio;

  SessionService({required this.dio});

  Future<APIReponse> logIn({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/user_service/auth/login',
      data: {'email': email, 'password': password},
      options: VALIDATE_ALL_STATUSES,
    );

    return APIReponse.fromJson(json: response.data);
  }
}
