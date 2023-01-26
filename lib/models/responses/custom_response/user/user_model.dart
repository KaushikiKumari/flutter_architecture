// ignore_for_file: prefer_collection_literals

class UserModel {
  String? token;
  int? isRegistered;

  UserModel({this.token, this.isRegistered});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isRegistered = json['is_registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['is_registered'] = isRegistered;
    return data;
  }
}
