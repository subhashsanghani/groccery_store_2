class SocietyModel {
  int? code;
  bool? success;
  String? message;
  Data? data;

  SocietyModel({this.code, this.success, this.message, this.data});

  SocietyModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Society>? society;

  Data({this.society});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['society'] != null) {
      society = <Society>[];
      json['society'].forEach((v) {
        society!.add(new Society.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.society != null) {
      data['society'] = this.society!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Society {
  int? socityId;
  String? socityName;
  String? pincode;
  int? deliveryCharge;

  Society({this.socityId, this.socityName, this.pincode, this.deliveryCharge});

  Society.fromJson(Map<String, dynamic> json) {
    socityId = json['socity_id'];
    socityName = json['socity_name'];
    pincode = json['pincode'];
    deliveryCharge = json['delivery_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socity_id'] = this.socityId;
    data['socity_name'] = this.socityName;
    data['pincode'] = this.pincode;
    data['delivery_charge'] = this.deliveryCharge;
    return data;
  }
}