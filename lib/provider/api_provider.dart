import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/models/responses/base_response.dart';
import 'package:flutter_architecture/networking/custom_exception.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/shared_preference/shared_pref_constant.dart';
import 'package:flutter_architecture/widgets/toast.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(NetworkConstant.BASE_URL + url));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postBeforeAuth(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(NetworkConstant.BASE_URL + url),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: parameter);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuth(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(NetworkConstant.BASE_URL + url),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: parameter);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postBeforeAuthMultiPart(
      Map parameter, String url, File _image) async {
    var responseJson;

    try {
      final response = http.MultipartRequest(
          "POST", Uri.parse(NetworkConstant.BASE_URL + url));
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }

      if (_image != null) {
        var stream = http.ByteStream(Stream.castFrom(_image.openRead()));
        var length = await _image.length();
        var multipartFile = http.MultipartFile(
            NetworkConstant.API_PARAM_PROFILE_PIC, stream, length,
            filename: Path.basename(_image.path));
        response.files.add(multipartFile);
      }

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          responseJson = _response(response);
        });
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthMultiPart(
      Map parameter, String url, File _image) async {
    var responseJson;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(SharedPrefConstant.TOKEN) ?? '';
    try {
      final response = http.MultipartRequest(
        "POST",
        Uri.parse(NetworkConstant.BASE_URL + url),
      );
      response.headers['authorization'] = "Bearer" + token;
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }

      if (_image != null) {
        var stream = http.ByteStream(Stream.castFrom(_image.openRead()));
        var length = await _image.length();
        var multipartFile = http.MultipartFile(
            NetworkConstant.API_PARAM_PROFILE_PIC, stream, length,
            filename: _image.path.toString());
        response.files.add(multipartFile);
      }

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          if (response.statusCode == 200) {
            showSuccessToast('Image Uploaded Successfully Done!');
            return jsonDecode(response.body);
          } else {
            showErrorToast("Something Went Wrong!");
            return NetworkConstant.ERROR;
          }
        });
      });
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _responseFromStream(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> postApiBeforeAuth(Map parameter, url) async {
    if (kDebugMode) {
      print(NetworkConstant.BASE_URL + url);
    }
    final response = await http.post(Uri.parse(NetworkConstant.BASE_URL + url),
        body: parameter);
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return BaseResponseModel(message: response.body, statusCode: 200);
    } else {
      return BaseResponseModel(message: response.body, statusCode: 200);
    }
  }

  Future<dynamic> postApi(Map parameter, url) async {
    if (kDebugMode) {
      print(NetworkConstant.BASE_URL + url);
    }
    final response = await http.post(Uri.parse(NetworkConstant.BASE_URL + url),
        body: parameter);
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 401) {
      showSuccessToast(response.body);
      return '0';
    } else {
      showSuccessToast('Something went wrong, Please Try Again');
      return '0';
    }
  }

  Future<dynamic> cmsPostApi(Map parameter, url) async {
    if (kDebugMode) {
      print(NetworkConstant.BASE_URL + url);
    }
    final response = await http.post(Uri.parse(NetworkConstant.BASE_URL + url),
        body: parameter);
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 401) {
      response.body;
      return '0';
    } else {
      showSuccessToast('Something went wrong, Please Try Again');
      return '0';
    }
  }
}
