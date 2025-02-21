import 'package:rent_transport_fe/global/global.dart';
import 'package:rent_transport_fe/models/login/login.dart';

class ValidationErrorMessage {
  static String? getAccountErrorMessage(AccountValidationError? error) {
    switch (error) {
      case AccountValidationError.empty:
        return "Email không được để trống!!";
      case AccountValidationError.invalid:
        return "Email không hợp lệ!!";
      default:
        return null;
    }
  }

  static String? getPasswordErrorMessage(PasswordValidationError? error) {
    switch (error) {
      case PasswordValidationError.empty:
        return "Mật khẩu không được để trống!!";
      case PasswordValidationError.tooShort:
        return "Mật khẩu không được ngắn hơn $MINIMUM_LENGTH_FOR_PASSWORD kí tự!!";
      default:
        return null;
    }
  }
}
