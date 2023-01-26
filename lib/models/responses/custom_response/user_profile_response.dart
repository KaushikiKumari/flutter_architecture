class UserProfileResponse {
  UserProfileResponse({
    required this.approved,
    required this.id,
    required this.mobileNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.city,
    required this.dob,
    required this.dobTime,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.state,
    required this.image,
  });
  late final bool approved;
  late final String id;
  late final String mobileNumber;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final String city;
  late final String dob;
  late final String dobTime;
  late final String firstName;
  late final String gender;
  late final String lastName;
  late final String state;
  late final String image;

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    id = json['_id'];
    mobileNumber = json['mobile_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    V = json['__v'];
    city = json['city'].toString();
    dob = json['dob'].toString();
    dobTime = json['dob_time'].toString();
    firstName = json['first_name'].toString();
    gender = json['gender'].toString();
    lastName = json['last_name'].toString();
    state = json['state'].toString();
    image = json['image'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['approved'] = approved;
    _data['_id'] = id;
    _data['mobile_number'] = mobileNumber;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['__v'] = V;
    _data['city'] = city;
    _data['dob'] = dob;
    _data['dob_time'] = dobTime;
    _data['first_name'] = firstName;
    _data['gender'] = gender;
    _data['last_name'] = lastName;
    _data['state'] = state;
    _data['image'] = image;
    return _data;
  }
}
