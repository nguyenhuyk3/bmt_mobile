import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/models.dart';
import 'package:rt_mobile/data/services/authentication/register.dart';
import 'package:rt_mobile/data/services/authentication/session.dart';

class AuthenticationRepository {
  final RegisterService registerService;
  final SessionService sessionService;

  AuthenticationRepository({
    required this.registerService,
    required this.sessionService,
  });

  Future<APIReponse> sendRegistrationOtp({required String email}) {
    return registerService.sendRegistrationOtp(email: email);
  }

  Future<APIReponse> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) {
    return registerService.verifyRegistrationOtp(email: email, otp: otp);
  }

  Future<APIReponse> completeRegistration({
    required Map<String, dynamic> request,
  }) {
    return registerService.completeRegistration(resquest: request);
  }

  Future<APIReponse> logIn({
    required String email,
    required String password,
  }) async {
    final response = await sessionService.logIn(
      email: email,
      password: password,
    );

    storage.write(ACCESS_TOKEN, response.data[ACCESS_TOKEN]);
    storage.write(REFRESH_TOKEN, response.data[REFRESH_TOKEN]);

    return APIReponse(statusCode: response.statusCode);
  }
}
