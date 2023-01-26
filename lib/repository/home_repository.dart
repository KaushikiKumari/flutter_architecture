import 'dart:io';
import 'package:flutter_architecture/models/responses/user_response.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/provider/api_provider.dart';

class HomeRepository {
  ApiProvider _apiProvider = ApiProvider();

  // Future<dynamic> getSlidersList() async {
  //   var response = await provider.getAfterAuth(NetworkConstant.getSliders);
  //   return response;
  // }
}
