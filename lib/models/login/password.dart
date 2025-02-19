import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  final int _minLength = 8;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;

    if (value.length < _minLength) return PasswordValidationError.tooShort;

    return null;
  }
}
