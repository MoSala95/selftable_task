import 'package:dartz/dartz.dart';

import 'package:get/get.dart';
import 'package:selftable_task/models/auth_fields_validation_models/fields_objects.dart';

class Validator {


  static Either<FieldValueError, String> validateName(String input) {
    String namePattern =
        r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z\s]*$"; // RegExp regex = RegExp(pattern);


    if (input.length < 3) {
      return left(FieldValueError(fieldValueErrorMsg: "Name should be at least 3 characters"));
    }

    if (input.length > 2 &&
        RegExp(namePattern).hasMatch(input)) {
      return right(input);
    } else {
      return left(FieldValueError(fieldValueErrorMsg: "Enter valid name"));
    }
  }


  static Either<FieldValueError, String> validateAge(String value) {
    int? age = int.tryParse(value);
    if(age==null){
      return left(FieldValueError(fieldValueErrorMsg: "Enter valid age"));

    }
    else if (age>4&& age<120) {
      return right(value);
    } else {
      return left(FieldValueError(fieldValueErrorMsg: "valid age range between 5 and 120 year"));
    }
  }



  static Either<FieldValueError, String> validateEmail(String input) {

     String emailPattern =
        r'^(?=.{6,50}$)[a-zA-Z0-9.\d@$!%*#?&^_-]+@[a-zA-Z0-9\-]+\.[a-zA-Z]+';

     if(input.isEmpty){
       return left(FieldValueError(fieldValueErrorMsg: "Email can not be empty"));

     }
    else if (RegExp(emailPattern).hasMatch(input)) {
      return right(input);
    } else {
      return left(FieldValueError(fieldValueErrorMsg: "Invalid Email"));
    }
  }


  static Either<FieldValueError, String> validateSignupPassword(String input) {
    RegExp regex =
        RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{8,30}$');

    if (!regex.hasMatch(input)) {
      return left(FieldValueError(fieldValueErrorMsg: "should contains characters,numbers,special characters with length between 8 to 30 max"));
    } else {
      return right(input);
    }
  }

  static Either<FieldValueError, String> validateLoginPassword(String input) {
    if (input.isEmpty) {
      return left(FieldValueError(fieldValueErrorMsg: "Field can not be empty"));
    } else {
      return right(input);
    }
  }
}
