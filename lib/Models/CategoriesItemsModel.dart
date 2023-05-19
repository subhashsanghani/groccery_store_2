class CategoriesItemsModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  CategoriesItemsModel({this.success, this.message, this.code, this.data});

  CategoriesItemsModel.fromJson(Map<String, dynamic> json) {
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
  List<Product>? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
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
  int? id;
  String? title;
  String? slug;
  int? parent;
  int? leval;
  String? description;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  List<ProductPrices>? productPrices;
  ProductPrices? selectedPrice;

  Product(
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
        this.id,
        this.title,
        this.slug,
        this.parent,
        this.leval,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.imageUrl,
        this.productPrices});

  Product.fromJson(Map<String, dynamic> json) {
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
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    parent = json['parent'];
    leval = json['leval'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['parent'] = this.parent;
    data['leval'] = this.leval;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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