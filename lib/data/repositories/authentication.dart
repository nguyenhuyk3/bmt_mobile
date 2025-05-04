import 'package:rt_mobile/data/models/models.dart';
import 'package:rt_mobile/data/services/authentication/register.dart';

class AuthenticationRepositoryy {
  final RegisterService registerService;

  AuthenticationRepositoryy({required this.registerService});

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
}
