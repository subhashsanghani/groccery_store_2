class PopularListModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  PopularListModel({this.success, this.message, this.code, this.data});

  PopularListModel.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;

  Data({this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? popular;
  int? productId;
  String? productName;
  String? productImage;
  List<ProductPrice>? productPrice;
  ProductPrice? selectedPrice;
  String? imageUrl;

  Products(
      {this.popular,
        this.productId,
        this.productName,
        this.productImage,
        this.productPrice,
        this.selectedPrice,
        this.imageUrl});

  Products.fromJson(Map<String, dynamic> json) {
    popular = json['popular'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    if (json['product_price'] != null) {
      productPrice = <ProductPrice>[];
      json['product_price'].forEach((v) {
        productPrice!.add(new ProductPrice.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popular'] = this.popular;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    if (this.productPrice != null) {
      data['product_price'] =
          this.productPrice!.map((v) => v.toJson()).toList();
    }
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class ProductPrice {
  int? id;
  int? productId;
  int? productPrice;
  int? unitValue;
  String? title;
  int? inStock;
  String? unit;
  String? createdAt;
  String? updatedAt;

  ProductPrice(
      {this.id,
        this.productId,
        this.productPrice,
        this.unitValue,
        this.title,
        this.inStock,
        this.unit,
        this.createdAt,
        this.updatedAt});

  ProductPrice.fromJson(Map<String, dynamic> json) {
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