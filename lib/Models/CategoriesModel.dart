class CategoriesModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  CategoriesModel({this.success, this.message, this.code, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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
  List<Category>? category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
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
  List<SubCat>? subCat;

  Category(
      {this.id,
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
        this.subCat});

  Category.fromJson(Map<String, dynamic> json) {
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
    if (json['sub_cat'] != null) {
      subCat = <SubCat>[];
      json['sub_cat'].forEach((v) {
        subCat!.add(new SubCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.subCat != null) {
      data['sub_cat'] = this.subCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCat {
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

  SubCat(
      {this.id,
        this.title,
        this.slug,
        this.parent,
        this.leval,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.imageUrl});

  SubCat.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}