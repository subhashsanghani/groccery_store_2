class OrderDetailsModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  OrderDetailsModel({this.success, this.message, this.code, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Orderdetail? orderdetail;

  Data({this.orderdetail});

  Data.fromJson(Map<String, dynamic> json) {
    orderdetail = json['orderdetail'] != null
        ? new Orderdetail.fromJson(json['orderdetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderdetail != null) {
      data['orderdetail'] = this.orderdetail!.toJson();
    }
    return data;
  }
}

class Orderdetail {
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
  Null? branchId;
  Null? imageUrl;
  List<Saleitems>? saleitems;

  Orderdetail(
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
        this.imageUrl,
        this.saleitems});

  Orderdetail.fromJson(Map<String, dynamic> json) {
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
    if (json['saleitems'] != null) {
      saleitems = <Saleitems>[];
      json['saleitems'].forEach((v) {
        saleitems!.add(new Saleitems.fromJson(v));
      });
    }
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
    if (this.saleitems != null) {
      data['saleitems'] = this.saleitems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Saleitems {
  int? saleItemId;
  int? saleId;
  int? productId;
  int? priceId;
  String? productName;
  int? qty;
  String? unit;
  int? unitValue;
  int? price;
  double? qtyInKg;
  String? createdAt;
  String? updatedAt;
  Products? products;

  Saleitems(
      {this.saleItemId,
        this.saleId,
        this.productId,
        this.priceId,
        this.productName,
        this.qty,
        this.unit,
        this.unitValue,
        this.price,
        this.qtyInKg,
        this.createdAt,
        this.updatedAt,
        this.products});

  Saleitems.fromJson(Map<String, dynamic> json) {
    saleItemId = json['sale_item_id'];
    saleId = json['sale_id'];
    productId = json['product_id'];
    priceId = json['price_id'];
    productName = json['product_name'];
    qty = json['qty'];
    unit = json['unit'];
    unitValue = json['unit_value'];
    price = json['price'];
    qtyInKg = double.tryParse(json['qty_in_kg'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_item_id'] = this.saleItemId;
    data['sale_id'] = this.saleId;
    data['product_id'] = this.productId;
    data['price_id'] = this.priceId;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['unit'] = this.unit;
    data['unit_value'] = this.unitValue;
    data['price'] = this.price;
    data['qty_in_kg'] = this.qtyInKg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  int? productId;
  String? productName;
  String? productDescription;
  String? productImage;
  int? categoryId;
  int? inStock;
  int? unitValue;
  String? unit;
  String? productWeight;
  int? isPopular;
  int? increament;
  String? imageUrl;

  Products(
      {this.productId,
        this.productName,
        this.productDescription,
        this.productImage,
        this.categoryId,
        this.inStock,
        this.unitValue,
        this.unit,
        this.productWeight,
        this.isPopular,
        this.increament,
        this.imageUrl});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productImage = json['product_image'];
    categoryId = json['category_id'];
    inStock = json['in_stock'];
    unitValue = json['unit_value'];
    unit = json['unit'];
    productWeight = json['product_weight'];
    isPopular = json['is_popular'];
    increament = json['increament'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_image'] = this.productImage;
    data['category_id'] = this.categoryId;
    data['in_stock'] = this.inStock;
    data['unit_value'] = this.unitValue;
    data['unit'] = this.unit;
    data['product_weight'] = this.productWeight;
    data['is_popular'] = this.isPopular;
    data['increament'] = this.increament;
    data['image_url'] = this.imageUrl;
    return data;
  }
}