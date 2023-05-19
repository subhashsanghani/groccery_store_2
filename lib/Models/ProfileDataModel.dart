class ProfileDataModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  ProfileDataModel({this.success, this.code, this.message, this.data});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? userId;
  String? userPhone;
  String? userFullname;
  String? userEmail;
  String? userImage;
  String? gender;
  int? pincode;
  int? socityId;
  String? houseNo;
  int? status;
  String? profileUrl;

  User(
      {this.userId,
        this.userPhone,
        this.userFullname,
        this.userEmail,
        this.userImage,
        this.gender,
        this.pincode,
        this.socityId,
        this.houseNo,
        this.status,
        this.profileUrl});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userPhone = json['user_phone'];
    userFullname = json['user_fullname'];
    userEmail = json['user_email'];
    userImage = json['user_image'];
    gender = json['gender'];
    pincode = json['pincode'];
    socityId = json['socity_id'];
    houseNo = json['house_no'];
    status = json['status'];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_phone'] = this.userPhone;
    data['user_fullname'] = this.userFullname;
    data['user_email'] = this.userEmail;
    data['user_image'] = this.userImage;
    data['gender'] = this.gender;
    data['pincode'] = this.pincode;
    data['socity_id'] = this.socityId;
    data['house_no'] = this.houseNo;
    data['status'] = this.status;
    data['profile_url'] = this.profileUrl;
    return data;
  }
}