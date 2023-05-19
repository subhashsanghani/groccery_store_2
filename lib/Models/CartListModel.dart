class CartListModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  CartListModel({this.success, this.message, this.code, this.data});

  CartListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['Message'];
    code = json['code'];
    data = json['data'] != null && json['data'].isNotEmpty? new Data.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['success'] = this.success;
  //   data['Message'] = this.message;
  //   data['code'] = this.code;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
Map<String , dynamic> toJson()=> {
    'success' : success==null?null:success,
    'code' : code==null?null:code,
    'data' : data==null?null:data!.toJson(),
    'message' : message==null?null:message,
    };
}

class Data {
  List<Cart>? cart;
  int? totalIteams;
  int? finaltotal;

  Data({this.cart, this.totalIteams, this.finaltotal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    totalIteams = json['total iteams'];
    finaltotal = json['finaltotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['total iteams'] = this.totalIteams;
    data['finaltotal'] = this.finaltotal;
    return data;
  }
}

class Cart {
  int? id;
  int? productId;
  int? userId;
  int? priceId;
  int? qty;
  String? createdAt;
  String? updatedAt;
  int? productPrice;
  String? title;
  int? total;
  Null? imageUrl;

  Cart(
      {this.id,
        this.productId,
        this.userId,
        this.priceId,
        this.qty,
        this.createdAt,
        this.updatedAt,
        this.productPrice,
        this.title,
        this.total,
        this.imageUrl});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    priceId = json['price_id'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productPrice = json['product_price'];
    title = json['title'];
    total = json['total'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['price_id'] = this.priceId;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_price'] = this.productPrice;
    data['title'] = this.title;
    data['total'] = this.total;
    data['image_url'] = this.imageUrl;
    return data;
  }
}