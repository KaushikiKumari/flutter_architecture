import 'dart:io';

import 'package:flutter_architecture/models/responses/base_response.dart';
import 'package:flutter_architecture/models/responses/user_response.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/provider/api_provider.dart';

class AuthRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<BaseResponseModel> callLoginApi(Map parameter) async {
    final response = await apiProvider.postApiBeforeAuth(
        parameter, NetworkConstant.END_POINT_LOGIN);
    return response;
  }

  Future<dynamic> callVerifyOtpApi(Map parameter) async {
    final response = await apiProvider.postApi(
        parameter, NetworkConstant.END_POINT_VERIFY_OTP);
    return response;
  }

  Future<UserResponseModel> signUpWithProfile(Map parameter, File file) async {
    final response = await apiProvider.postAfterAuthMultiPart(
        parameter, NetworkConstant.END_POINT_REGISTER, file);
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> signUpWithoutProfile(Map parameter) async {
    final response = await apiProvider.postBeforeAuth(
      parameter,
      NetworkConstant.END_POINT_REGISTER,
    );
    return UserResponseModel.fromJson(response);
  }
}
