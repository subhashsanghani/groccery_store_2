class ProductDetailsModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  ProductDetailsModel({this.success, this.message, this.code, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Produt? produt;
  List<Related>? related;

  Data({this.produt, this.related});

  Data.fromJson(Map<String, dynamic> json) {
    produt =
    json['produt'] != null ? new Produt.fromJson(json['produt']) : null;
    if (json['related'] != null) {
      related = <Related>[];
      json['related'].forEach((v) {
        related!.add(new Related.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.produt != null) {
      data['produt'] = this.produt!.toJson();
    }
    if (this.related != null) {
      data['related'] = this.related!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Produt {
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
  int? isFavourite;
  String? imageUrl;
  List<ProductPrices>? productPrices;

  Produt(
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
        this.isFavourite,
        this.imageUrl,
        this.productPrices});

  Produt.fromJson(Map<String, dynamic> json) {
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
    isFavourite = json['is_favourite'];
    imageUrl = json['image_url'];
    if (json['product_prices'] != null) {
      productPrices = <ProductPrices>[];
      json['product_prices'].forEach((v) {
        productPrices!.add(new ProductPrices.fromJson(v));
      });
    }
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
    data['is_favourite'] = this.isFavourite;
    data['image_url'] = this.imageUrl;
    if (this.productPrices != null) {
      data['product_prices'] =
          this.productPrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductPrices {
  int? id;
  int? productId;
  int? productPrice;
  int? unitValue;
  String? title;
  int? inStock;
  String? unit;
  String? createdAt;
  String? updatedAt;

  ProductPrices(
      {this.id,
        this.productId,
        this.productPrice,
        this.unitValue,
        this.title,
        this.inStock,
        this.unit,
        this.createdAt,
        this.updatedAt});

  ProductPrices.fromJson(Map<String, dynamic> json) {
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

class Related {
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
  int? parentCategoryId;
  String? imageUrl;
  List<ProductPrices>? productPrices;

  Related(
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
        this.parentCategoryId,
        this.imageUrl,
        this.productPrices});

  Related.fromJson(Map<String, dynamic> json) {
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
    parentCategoryId = json['parent_category_id'];
    imageUrl = json['image_url'];
    if (json['product_prices'] != null) {
      productPrices = <ProductPrices>[];
      json['product_prices'].forEach((v) {
        productPrices!.add(new ProductPrices.fromJson(v));
      });
    }
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
    data['parent_category_id'] = this.parentCategoryId;
    data['image_url'] = this.imageUrl;
    if (this.productPrices != null) {
      data['product_prices'] =
          this.productPrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}