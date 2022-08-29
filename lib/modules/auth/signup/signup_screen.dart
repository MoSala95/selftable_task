import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:selftable_task/logic_helpers/validator.dart';
import 'package:selftable_task/models/auth_fields_validation_models/fields_objects.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';
import 'package:selftable_task/modules/auth/login/login_controller.dart';
import 'package:selftable_task/modules/auth/signup/signup_controller.dart';
import 'package:selftable_task/routes/route_constants.dart';
import 'package:selftable_task/shared_widgets/app_state_handler_widget.dart';
import 'package:selftable_task/shared_widgets/build_profile_picture.dart';
import 'package:selftable_task/shared_widgets/input_widget.dart';


class SignUpScreen extends StatelessWidget {
  final signUpController = Get.find<SignUpController>();

  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SignUpController>(builder: (_) {
        return   AppStateHandlerWidget(
            state: signUpController.loadingState,
            child: Form(
              key: signUpController.signUpFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        BuildProfilePicture(
                          onTap: signUpController.addNewProfileImage,
                          pickedImage: signUpController.pikedImageFile,
                        ),
                       const SizedBox(height: 20.0),
                        InputWidget(
                            title: "User Name",
                            hintText: 'Ex: Mo sala',
                            controller: signUpController.nameController,

                            autoValidateMode:
                            AutovalidateMode.onUserInteraction,

                            onChanged: (value) {
                              signUpController.name = Name(value);
                            },
                            validator: (input) {
                              Either<FieldValueError, String> value =
                              Validator.validateName(input!);
                              return value.fold((fieldError) {
                                 return fieldError.fieldValueErrorMsg;
                              }, (r) {
                                 return null;
                              });
                            }
                        ),
                        const SizedBox(height: 10.0),
                        InputWidget(
                            title: "Age",
                            hintText: 'Ex: 22',
                            controller: signUpController.ageController,

                            autoValidateMode:
                            AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              signUpController.age = Age(value);
                            },
                            validator: (input) {
                              Either<FieldValueError, String> value =
                              Validator.validateAge(input!);
                              return value.fold((fieldError) {
                                 return fieldError.fieldValueErrorMsg;
                              }, (r) {
                                 return null;
                              });
                            }
                        ),
                        const SizedBox(height: 10.0),
                        InputWidget(
                          title: "Email",
                            hintText: 'mail@mail.com',
                            controller: signUpController.emailController,

                            autoValidateMode:
                            AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              signUpController.email = Email(value);
                            },
                            validator: (input) {
                              Either<FieldValueError, String> value =
                              Validator.validateEmail(input!);
                              return value.fold((fieldError) {
                                 return fieldError.fieldValueErrorMsg;
                              }, (r) {
                                 return null;
                              });
                            }
                        ),
                        const SizedBox(height: 10.0),
                        InputWidget(
                          title: 'password',
                          hintText: '****',
                          autoValidateMode:
                          AutovalidateMode.onUserInteraction,
                          controller: signUpController.passwordController,
                          obscureText: signUpController.isPassHidden,
                          textInputAction: TextInputAction.go,
                          onSaved: (value) {},
                          onChanged: (value) {
                            signUpController.password = SignUpPassword(value);
                          },

                          validator: (input) {
                            Either<FieldValueError, String> value =
                            Validator.validateSignupPassword(input!);
                            return value.fold((fieldError) {
                               return fieldError.fieldValueErrorMsg;
                            }, (r) {
                               return null;
                            });
                          },
                          suffixIcon: IconButton(
                              icon: Icon(
                                signUpController.isPassHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 18,
                                color: Colors.grey,
                              ),
                              onPressed: signUpController.showPassword),
                        ),

                        const SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () {
                            signUpController.validateForm();
                          },
                          child: const Text('Submit'),
                        ),
                        const SizedBox(height: 10,),
                        TextButton(onPressed: (){
                          Get.toNamed(RoutesConstants.loginScreen);

                        }, child: Text("Already have account? Login instead"))
                      ],
                    ),
                  ),
                ),
              ),
            ),

        );
      }),
    );
  }
}