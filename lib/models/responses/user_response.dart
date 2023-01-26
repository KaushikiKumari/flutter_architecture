import 'package:flutter_architecture/models/user_data.dart';

class UserResponseModel {
  late int status;
  late String message;
  UserData? data;

  UserResponseModel({required this.status, required this.message, this.data});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
