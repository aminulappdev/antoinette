class ArticlesDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  ArticleModel? data;

  ArticlesDetailsModel(
      {this.success, this.statusCode, this.message, this.data});

  ArticlesDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ArticleModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ArticleModel {
  String? sId;
  String? title;
  Category? category;
  String? thumbnail;
  String? description;
  String? author;
  String? status;
  String? publishedAt;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ArticleModel(
      {this.sId,
      this.title,
      this.category,
      this.thumbnail,
      this.description,
      this.author,
      this.status,
      this.publishedAt,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    thumbnail = json['thumbnail'];
    description = json['description'];
    author = json['author'];
    status = json['status'];
    publishedAt = json['publishedAt']; 
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['thumbnail'] = thumbnail;
    data['description'] = description;
    data['author'] = author;
    data['status'] = status;
    data['publishedAt'] = publishedAt;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Category {
  String? sId;
  String? title;
  String? categoryType;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Category(
      {this.sId,
      this.title,
      this.categoryType,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    categoryType = json['categoryType'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['categoryType'] = categoryType;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
