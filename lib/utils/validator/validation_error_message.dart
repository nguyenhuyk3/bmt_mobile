import 'package:rent_transport_fe/global/other.dart';
import 'package:rent_transport_fe/models/authentication/export.dart';

class ValidationErrorMessage {
  static String? getAccountErrorMessage({EmailValidationError? error}) {
    switch (error) {
      case EmailValidationError.empty:
        return "Email không được để trống!!";
      case EmailValidationError.invalid:
        return "Email không hợp lệ!!";
      default:
        return null;
    }
  }

  static String? getPasswordErrorMessage({
    required PasswordValidationError? error,
  }) {
    switch (error) {
      case PasswordValidationError.empty:
        return "Mật khẩu không được để trống!!";
      case PasswordValidationError.tooShort:
        return "Mật khẩu không được ngắn hơn $MINIMUM_LENGTH_FOR_PASSWORD kí tự!!";
      default:
        return null;
    }
  }

  static String? getOtpErrorMessage({OtpValidationError? error}) {
    switch (error) {
      case OtpValidationError.empty:
        return "Otp không được để trống!!";
      case OtpValidationError.incorrectSixDigits:
        return "Mã Otp phải có đúng $LENGTH_OF_OTP kí tự!!";
      case OtpValidationError.noTextAllowed:
        return "Mã otp không được có chữ cái";
      default:
        return null;
    }
  }
}
