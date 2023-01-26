class GetUserDetailModel {
  bool? approved;
  String? sId;
  String? mobileNumber;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? city;
  String? dob;
  String? dobTime;
  String? firstName;
  String? gender;
  String? image;
  String? lastName;
  String? state;

  GetUserDetailModel(
      {this.approved,
      this.sId,
      this.mobileNumber,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.city,
      this.dob,
      this.dobTime,
      this.firstName,
      this.gender,
      this.image,
      this.lastName,
      this.state});

  GetUserDetailModel.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    sId = json['_id'];
    mobileNumber = json['mobile_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    city = json['city'];
    dob = json['dob'];
    dobTime = json['dob_time'];
    firstName = json['first_name'];
    gender = json['gender'];
    image = json['image'];
    lastName = json['last_name'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approved'] = this.approved;
    data['_id'] = this.sId;
    data['mobile_number'] = this.mobileNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['city'] = this.city;
    data['dob'] = this.dob;
    data['dob_time'] = this.dobTime;
    data['first_name'] = this.firstName;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['last_name'] = this.lastName;
    data['state'] = this.state;
    return data;
  }
}
