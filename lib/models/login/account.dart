import 'package:formz/formz.dart';

enum AccountValidationError { empty, invalid }

class Account extends FormzInput<String, AccountValidationError> {
  const Account.pure() : super.pure('');
  const Account.dirty([super.value = '']) : super.dirty();

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  AccountValidationError? validator(String value) {
    // TODO: implement validator
    if (value.isEmpty) return AccountValidationError.empty;

    if (!_emailRegex.hasMatch(value)) return AccountValidationError.invalid;

    return null;
  }
}
