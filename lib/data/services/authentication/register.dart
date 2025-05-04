import 'package:dio/dio.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/models.dart';

class RegisterService {
  final Dio dio;

  RegisterService({required this.dio});

  Future<APIReponse> sendRegistrationOtp({required String email}) async {
    final response = await dio.post(
      '/user_service/auth/register/send_otp',
      data: {'email': email},
      options: VALIDATE_NON_5XX_STATUS,
    );

    return APIReponse(statusCode: response.statusCode);
  }

  Future<APIReponse> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) async {
    final response = await dio.post(
      '/user_service/auth/register/verify_registration_otp',
      data: {'email': email, 'otp': otp},
      options: VALIDATE_NON_5XX_STATUS,
    );

    logger.i(email + " " + otp);

    return APIReponse(statusCode: response.statusCode);
  }

  Future<APIReponse> completeRegistration({
    required Map<String, dynamic> resquest,
  }) async {
    final response = await dio.post(
      '/user_service/auth/register/complete_registration',
      data: resquest,
      options: VALIDATE_NON_5XX_STATUS,
    );

    return APIReponse(statusCode: response.statusCode);
  }
}
