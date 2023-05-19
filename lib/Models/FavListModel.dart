class FavListModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  FavListModel({this.success, this.message, this.code, this.data});

  FavListModel.fromJson(Map<String, dynamic> json) {
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
  List<Favorite>? favorite;

  Data({this.favorite});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['favorite'] != null) {
      favorite = <Favorite>[];
      json['favorite'].forEach((v) {
        favorite!.add(new Favorite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favorite != null) {
      data['favorite'] = this.favorite!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorite {
  int? id;
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;
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
  List<Productprice>? productprice;

  Favorite(
      {this.id,
        this.userId,
        this.productId,
        this.createdAt,
        this.updatedAt,
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
        this.imageUrl,
        this.productprice});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    if (json['productprice'] != null) {
      productprice = <Productprice>[];
      json['productprice'].forEach((v) {
        productprice!.add(new Productprice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    if (this.productprice != null) {
      data['productprice'] = this.productprice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productprice {
  int? id;
  int? productId;
  int? productPrice;
  int? unitValue;
  String? title;
  int? inStock;
  String? unit;
  String? createdAt;
  String? updatedAt;

  Productprice(
      {this.id,
        this.productId,
        this.productPrice,
        this.unitValue,
        this.title,
        this.inStock,
        this.unit,
        this.createdAt,
        this.updatedAt});

  Productprice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productPrice = json['product_price'];
    unitValue = json['unit_value'];
    title = json['title'];
    inStock = json['in_stock'];
    unit = json['unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_price'] = this.productPrice;
    data['unit_value'] = this.unitValue;
    data['title'] = this.title;
    data['in_stock'] = this.inStock;
    data['unit'] = this.unit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}