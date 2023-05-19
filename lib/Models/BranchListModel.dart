class BranchListModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  BranchListModel({this.success, this.message, this.code, this.data});

  BranchListModel.fromJson(Map<String, dynamic> json) {
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
  List<Branches>? branches;

  Data({this.branches});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Branches'] != null) {
      branches = <Branches>[];
      json['Branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branches != null) {
      data['Branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branches {
  int? id;
  String? name;
  String? phone;
  String? openingTime;
  String? closingTime;
  int? pincode;
  String? address;
  String? area;
  int? deleveryKm;
  int? active;
  String? createdAt;
  String? updatedAt;

  Branches(
      {this.id,
        this.name,
        this.phone,
        this.openingTime,
        this.closingTime,
        this.pincode,
        this.address,
        this.area,
        this.deleveryKm,
        this.active,
        this.createdAt,
        this.updatedAt});

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    pincode = json['pincode'];
    address = json['address'];
    area = json['area'];
    deleveryKm = json['delevery_km'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['pincode'] = this.pincode;
    data['address'] = this.address;
    data['area'] = this.area;
    data['delevery_km'] = this.deleveryKm;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}