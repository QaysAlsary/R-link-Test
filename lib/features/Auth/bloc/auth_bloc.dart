import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rlink_test/features/Auth/model/auth_model.dart';
import 'package:rlink_test/src/core/local_storage.dart';
import 'package:rlink_test/src/di/services_locator.dart';
import 'package:rlink_test/src/network_services/dio.dart';
import 'package:rlink_test/src/network_services/end_points.dart';
import 'package:rlink_test/src/validation/phone_validator.dart';
import 'package:rlink_test/src/validation/username_validator.dart';
import 'dart:developer' as dev;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()){
  on<LoginWithEmailEvent>(_loginWithEmail);
  on<LoginWithPhoneEvent>(_loginWithPhone);
  on<RegisterEvent>(_register);
  }
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfController = TextEditingController();
  final UserNameValidator userNameValidator =  UserNameValidator();
  final PhoneValidator phoneValidator = PhoneValidator();

  var selectedImage=null;
  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 960,
        imageQuality: 50,
      );
      if(image == null) return;
      final path = File(image.path);
      selectedImage = path;
      emit(SelectImageState());
    } on PlatformException catch (exception){
      print(exception.message);
    }
  }

AuthModel? authModel;

  FutureOr<void> _loginWithEmail(LoginWithEmailEvent event, Emitter<AuthState> emit)async {
  emit(state.copyWith(isLoading: true));
  try {
    final response = await DioHelper.postData(
      path: loginPath,
      map: {
        'email': userNameController.text.trim(),
        'password': passwordController.text,
      },
    );

    authModel = authModelFromJson(response.data);
    token = response.data['access_token'];
    LocalStorage.storeToken(token);
    print(token);
    emit(SuccessState());
  } catch (error) {
    dev.log(error.toString());
    emit(ErrorState());
  }
  emit(state.copyWith(isLoading: false));

  }

  FutureOr<void> _loginWithPhone(LoginWithPhoneEvent event, Emitter<AuthState> emit)async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await DioHelper.postData(
        path: loginPath,
        map: {
          'phone': userNameController.text.trim(),
          'password': passwordController.text,
        },
      );

      authModel = authModelFromJson(response.data);
      token = response.data['access_token'];
      LocalStorage.storeToken(token);
      print(token);
      emit(SuccessState());
    } catch (error) {
      dev.log(error.toString());
      emit(ErrorState());
    }
    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> _register(RegisterEvent event, Emitter<AuthState> emit)async {
    emit(state.copyWith(isLoading: true));
    try {
      final imagePath = selectedImage?.path;

      final data = FormData.fromMap({
        'files': [
          if (imagePath != null)
            await MultipartFile.fromFile(imagePath, filename: imagePath)
        ],
        'name': nameController.text,
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'password_confirmation': passwordConfController.text
      });

      final response = await Dio().request(
        registerPath,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        authModel = authModelFromJson(response.data);
        token = response.data['access_token'];
        LocalStorage.storeToken(token);
        emit(SuccessState());
      } else {
        emit(ErrorState());
      }
    } catch (error) {
      if (error is DioError) {
        print('DioError: ${error.response?.statusCode}');
        print('Response data: ${error.response?.data}');
      } else {
        dev.log(error.toString());
      }
      emit(ErrorState());
    }
    emit(state.copyWith(isLoading: false));
  }

}
