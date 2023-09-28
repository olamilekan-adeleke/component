import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!])(?!.*\s).{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (_passwordRegex.hasMatch(value)) {
      return null;
    } else {
      return PasswordValidationError.invalid;
    }
  }
}
