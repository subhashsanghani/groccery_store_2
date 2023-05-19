class OrderListModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  OrderListModel({this.success, this.message, this.code, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
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
  List<Myoder>? myoder;
  Ongoing? ongoing;

  Data({this.myoder, this.ongoing});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['myoder'] != null) {
      myoder = <Myoder>[];
      json['myoder'].forEach((v) {
        myoder!.add(new Myoder.fromJson(v));
      });
    }
    ongoing =
    json['ongoing'] != null ? new Ongoing.fromJson(json['ongoing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myoder != null) {
      data['myoder'] = this.myoder!.map((v) => v.toJson()).toList();
    }
    if (this.ongoing != null) {
      data['ongoing'] = this.ongoing!.toJson();
    }
    return data;
  }
}

class Myoder {
  int? saleId;
  int? userId;
  String? onDate;
  int? status;
  int? paymentStatus;
  String? orderType;
  String? paidBy;
  String? note;
  int? totalAmount;
  double? totalKg;
  int? totalItems;
  int? socityId;
  String? deliveryAddress;
  int? locationId;
  int? deliveryCharge;
  String? createdAt;
  int? branchId;
  String? imageUrl;

  Myoder(
      {this.saleId,
        this.userId,
        this.onDate,
        this.status,
        this.paymentStatus,
        this.orderType,
        this.paidBy,
        this.note,
        this.totalAmount,
        this.totalKg,
        this.totalItems,
        this.socityId,
        this.deliveryAddress,
        this.locationId,
        this.deliveryCharge,
        this.createdAt,
        this.branchId,
        this.imageUrl});

  Myoder.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    userId = json['user_id'];
    onDate = json['on_date'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    orderType = json['order_type'];
    paidBy = json['paid_by'];
    note = json['note'];
    totalAmount = json['total_amount'];
    totalKg = double.tryParse(json['total_kg'].toString());
    totalItems = json['total_items'];
    socityId = json['socity_id'];
    deliveryAddress = json['delivery_address'];
    locationId = json['location_id'];
    deliveryCharge = json['delivery_charge'];
    createdAt = json['created_at'];
    branchId = json['branch_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['user_id'] = this.userId;
    data['on_date'] = this.onDate;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['order_type'] = this.orderType;
    data['paid_by'] = this.paidBy;
    data['note'] = this.note;
    data['total_amount'] = this.totalAmount;
    data['total_kg'] = this.totalKg;
    data['total_items'] = this.totalItems;
    data['socity_id'] = this.socityId;
    data['delivery_address'] = this.deliveryAddress;
    data['location_id'] = this.locationId;
    data['delivery_charge'] = this.deliveryCharge;
    data['created_at'] = this.createdAt;
    data['branch_id'] = this.branchId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Ongoing {
  int? saleId;
  int? userId;
  String? onDate;
  int? status;
  int? paymentStatus;
  String? orderType;
  String? paidBy;
  String? note;
  num? totalAmount;
  double? totalKg;
  int? totalItems;
  int? socityId;
  String? deliveryAddress;
  int? locationId;
  int? deliveryCharge;
  String? createdAt;
  int? branchId;
  String? imageUrl;

  Ongoing(
      {this.saleId,
        this.userId,
        this.onDate,
        this.status,
        this.paymentStatus,
        this.orderType,
        this.paidBy,
        this.note,
        this.totalAmount,
        this.totalKg,
        this.totalItems,
        this.socityId,
        this.deliveryAddress,
        this.locationId,
        this.deliveryCharge,
        this.createdAt,
        this.branchId,
        this.imageUrl});

  Ongoing.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    userId = json['user_id'];
    onDate = json['on_date'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    orderType = json['order_type'];
    paidBy = json['paid_by'];
    note = json['note'];
    totalAmount = json['total_amount'];
    totalKg = json['total_kg'];
    totalItems = json['total_items'];
    socityId = json['socity_id'];
    deliveryAddress = json['delivery_address'];
    locationId = json['location_id'];
    deliveryCharge = json['delivery_charge'];
    createdAt = json['created_at'];
    branchId = json['branch_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['user_id'] = this.userId;
    data['on_date'] = this.onDate;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['order_type'] = this.orderType;
    data['paid_by'] = this.paidBy;
    data['note'] = this.note;
    data['total_amount'] = this.totalAmount;
    data['total_kg'] = this.totalKg;
    data['total_items'] = this.totalItems;
    data['socity_id'] = this.socityId;
    data['delivery_address'] = this.deliveryAddress;
    data['location_id'] = this.locationId;
    data['delivery_charge'] = this.deliveryCharge;
    data['created_at'] = this.createdAt;
    data['branch_id'] = this.branchId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}