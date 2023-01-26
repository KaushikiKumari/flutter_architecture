// ignore_for_file: use_rethrow_when_possible

import 'dart:io';

import 'package:flutter_architecture/data/network/base_api_services.dart';
import 'package:flutter_architecture/data/network/network_api_services.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/provider/api_provider.dart';

class UserRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> getUserDetailApi(dynamic data) async {
    try {
      dynamic response = await apiServices.getPostApiResponse(
          NetworkConstant.BASE_URL + NetworkConstant.END_POINT_GET_USER_PROFILE,
          data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Future<dynamic> updateUserDetailApi(dynamic data, File? file) async {
  //   try {
  //     if (file == null) {
  //       dynamic response = await ApiProvider().postAfterAUth(

  //         ApiUrls.updateUserDetailUrl,
  //          data,

  //       );
  //       return response;
  //     } else {
  //       dynamic response = await ApiProvider().postAfterAuthMultiPart(
  //         data,
  //         file,
  //         ApiUrls.updateUserDetailUrl,
  //       );
  //       return response;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<GetWishlistModel> getWishlistListApi() async {
  //   try {
  //     dynamic response =
  //         await apiServices.getGetApiResponse(ApiUrls.getWishlistUrl);
  //     return response = GetWishlistModel.fromJson(response);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
