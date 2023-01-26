// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/models/responses/api_response.dart';
import 'package:flutter_architecture/models/responses/custom_response/user/get_user_detail_model.dart';
import 'package:flutter_architecture/models/responses/custom_response/user/user_model.dart';
import 'package:flutter_architecture/repository/auth_repository.dart';
import 'package:flutter_architecture/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  final myRepo = AuthRepository();
  final userRepo = UserRepository();
  bool _userUpdateProfileLoading = false;
  bool get userUpdateProfileLoading => _userUpdateProfileLoading;
  setRegisterLoading(bool value) {
    _userUpdateProfileLoading = value;
    notifyListeners();
  }

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    sp.setString('is_registered', user.isRegistered.toString());
    if (kDebugMode) {
      print(user.token.toString());
    }
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    //final String? isRegistered = sp.getBool('isRegistered');

    return UserModel(token: token.toString());
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    sp.remove('is_registered');
    return true;
  }

  ApiResponse<GetUserDetailModel> getWishlistList = ApiResponse.loading();
  setWishlist(ApiResponse<GetUserDetailModel> response) {
    getWishlistList = response;
    notifyListeners();
  }
}
