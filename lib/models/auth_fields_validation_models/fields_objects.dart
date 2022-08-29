import 'package:dartz/dartz.dart';
import 'package:selftable_task/logic_helpers/validator.dart';

import 'abstract_field_object.dart';

// import 'field_value_error.dart';


class FieldValueError{
  late String fieldValueErrorMsg;
  FieldValueError({required this.fieldValueErrorMsg});
}
class Name extends AbstractFieldObject {
  final Either<FieldValueError, String> value;

  factory Name(String input) {
    return Name._(
      Validator.validateName(input),
    );
  }
  Name._(this.value);
}
class Age extends AbstractFieldObject {
  final Either<FieldValueError, String> value;

  factory Age(String input) {
    return Age._(
      Validator.validateAge(input),
    );
  }
  Age._(this.value);
}
class Email extends AbstractFieldObject {
  final Either<FieldValueError, String> value;

  factory Email(String input) {
    return Email._(
      Validator.validateEmail(input),
    );
  }
  Email._(this.value);
}



class LoginPassword extends AbstractFieldObject {
  final Either<FieldValueError, String> value;

  factory LoginPassword(String input) {
    return LoginPassword._(
      Validator.validateLoginPassword(input),
    );
  }
  LoginPassword._(this.value);
}
class SignUpPassword extends AbstractFieldObject {
  final Either<FieldValueError, String> value;

  factory SignUpPassword(String input) {
    return SignUpPassword._(
      Validator.validateSignupPassword(input),
    );
  }
  SignUpPassword._(this.value);
}
