class AddressListModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  AddressListModel({this.success, this.message, this.code, this.data});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['Message'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['Message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Userlocation>? userlocation;

  Data({this.userlocation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['userlocation'] != null) {
      userlocation = <Userlocation>[];
      json['userlocation'].forEach((v) {
        userlocation!.add(new Userlocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userlocation != null) {
      data['userlocation'] = this.userlocation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userlocation {
  int? locationId;
  int? userId;
  String? pincode;
  int? socityId;
  String? houseNo;
  String? receiverName;
  String? receiverMobile;
  List<Socity>? socity;

  Userlocation(
      {this.locationId,
        this.userId,
        this.pincode,
        this.socityId,
        this.houseNo,
        this.receiverName,
        this.receiverMobile,
        this.socity});

  Userlocation.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    userId = json['user_id'];
    pincode = json['pincode'];
    socityId = json['socity_id'];
    houseNo = json['house_no'];
    receiverName = json['receiver_name'];
    receiverMobile = json['receiver_mobile'];
    if (json['socity'] != null) {
      socity = <Socity>[];
      json['socity'].forEach((v) {
        socity!.add(new Socity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    data['user_id'] = this.userId;
    data['pincode'] = this.pincode;
    data['socity_id'] = this.socityId;
    data['house_no'] = this.houseNo;
    data['receiver_name'] = this.receiverName;
    data['receiver_mobile'] = this.receiverMobile;
    if (this.socity != null) {
      data['socity'] = this.socity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Socity {
  int? socityId;
  String? socityName;
  String? pincode;
  int? deliveryCharge;

  Socity({this.socityId, this.socityName, this.pincode, this.deliveryCharge});

  Socity.fromJson(Map<String, dynamic> json) {
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