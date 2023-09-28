import 'package:formz/formz.dart';

enum RequiredPinValidationError { invalid }

class RequiredPin extends FormzInput<String, RequiredPinValidationError> {
  const RequiredPin.pure([String value = '']) : super.pure(value);
  const RequiredPin.dirty([String value = '']) : super.dirty(value);

  @override
  RequiredPinValidationError? validator(String value) {
    if (value.isNotEmpty && value.length == 4) {
      return null;
    } else {
      return RequiredPinValidationError.invalid;
    }
  }
}
