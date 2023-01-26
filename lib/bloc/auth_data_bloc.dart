import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/models/responses/base_response.dart';
import 'package:flutter_architecture/repository/auth_repository.dart';

class AuthDataBloc {
  late AuthRepository authRepository;
  late StreamController<BaseResponseModel> _streamController;
  late StreamController<dynamic> _otpStreamController;
  late StreamController<dynamic> _registerStreamController;
  AuthDataBloc() {
    _streamController = StreamController<BaseResponseModel>();
    _otpStreamController = StreamController<dynamic>();
    _registerStreamController = StreamController<dynamic>();
    authRepository = AuthRepository();
  }

  StreamSink<BaseResponseModel> get loginDataSink => _streamController.sink;

  Stream<BaseResponseModel> get loginDataStream => _streamController.stream;

  StreamSink<dynamic> get otpDataSink => _otpStreamController.sink;

  Stream<dynamic> get otpDataStream => _otpStreamController.stream;

  StreamSink<dynamic> get registerSink => _registerStreamController.sink;

  Stream<dynamic> get registerStream => _registerStreamController.stream;

  callLoginApi(Map parameter) async {
    try {
      final response = await authRepository.callLoginApi(parameter);
      if (kDebugMode) {
        print("----Login with otp api----");
      }
      if (kDebugMode) {
        print(response);
      }
      loginDataSink.add(response);
    } catch (e) {
      loginDataSink.add(BaseResponseModel(
          message: 'Login Faild, Please Try Again', statusCode: 0));
    }
  }

  callVerifyOtpApi(Map parameter) async {
    try {
      final response = await authRepository.callVerifyOtpApi(parameter);
      if (kDebugMode) {
        print("----Otp Verify api----");
      }
      if (kDebugMode) {
        print(response);
      }
      otpDataSink.add(response);
    } catch (e) {
      otpDataSink.add('Invalid Otp');
    }
  }

  callSignUpApiWithProfile(Map parameter, File file) async {
    try {
      // debugger();
      final response = await authRepository.signUpWithProfile(parameter, file);
      if (kDebugMode) {
        print("---- Register Api With Profile ----");
      }
      if (kDebugMode) {
        print(response);
      }
      registerSink.add(response);
    } catch (e) {
      registerSink.add(BaseResponseModel(
          message: 'SignUp Faild, Please Try Again', statusCode: 0));
    }
  }

  callSignUpApiWithoutProfile(Map parameter) async {
    try {
      debugger();
      final response = await authRepository.signUpWithoutProfile(parameter);
      if (kDebugMode) {
        print("----Register Api Without Profile----");
      }
      if (kDebugMode) {
        print(response);
      }
      registerSink.add(response);
    } catch (e) {
      registerSink.add(BaseResponseModel(
          message: 'SignUp Faild, Please Try Again', statusCode: 0));
    }
  }

  dispose() {
    _streamController.close();
    _otpStreamController.close();
    _registerStreamController.close();
  }
}
