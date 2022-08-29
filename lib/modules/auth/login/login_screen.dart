import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:selftable_task/logic_helpers/validator.dart';
import 'package:selftable_task/models/auth_fields_validation_models/fields_objects.dart';
import 'package:selftable_task/modules/auth/auth_controller.dart';
import 'package:selftable_task/modules/auth/login/login_controller.dart';
import 'package:selftable_task/shared_widgets/app_state_handler_widget.dart';
import 'package:selftable_task/shared_widgets/build_profile_picture.dart';
import 'package:selftable_task/shared_widgets/input_widget.dart';
import 'package:selftable_task/ui_helpers/assets_constants.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final loginController = Get.find<LoginController>();

  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoginController>(builder: (_) {
        return AppStateHandlerWidget(
          state: loginController.loadingState,
          child: Form(
            key: loginController.loginFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetsConstants.catImage,),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.15),
                                BlendMode.darken),
                          ),
                          shape: BoxShape.circle,

                        ),
                      ),
                      InputWidget(
                          title: "Email",
                          hintText: 'mail@mail.com',
                          controller: loginController.emailController,

                          autoValidateMode:
                          AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            loginController.email = Email(value);
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
                        controller: loginController.passwordController,
                        obscureText: loginController.isPassHidden,
                        textInputAction: TextInputAction.go,
                        onSaved: (value) {},
                        onChanged: (value) {
                          loginController.password = LoginPassword(value);
                        },

                        validator: (input) {
                          Either<FieldValueError, String> value =
                          Validator.validateLoginPassword(input!);
                          return value.fold((fieldError) {
                            return fieldError.fieldValueErrorMsg;
                          }, (r) {
                            return null;
                          });
                        },
                        suffixIcon: IconButton(
                            icon: Icon(
                              loginController.isPassHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 18,
                              color: Colors.grey,
                            ),
                            onPressed: loginController.showPassword),
                      ),

                      const SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          loginController.validateForm();
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(height: 10,),
                      TextButton(onPressed: () {
                        Get.back();
                      }, child: Text("Do not have account? SignUp instead"))

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