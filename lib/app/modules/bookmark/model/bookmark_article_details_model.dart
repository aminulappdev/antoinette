class BookmarkArticleDetalsModel {
  bool? success;
  int? statusCode;
  String? message;
  BookmarkArticleDetailsItemModel? data;

  BookmarkArticleDetalsModel(
      {this.success, this.statusCode, this.message, this.data});

  BookmarkArticleDetalsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? BookmarkArticleDetailsItemModel.fromJson(json['data']) : null;
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

class BookmarkArticleDetailsItemModel {
  String? sId;
  User? user;
  String? modeType;
  Reference? reference;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BookmarkArticleDetailsItemModel(
      {this.sId,
      this.user,
      this.modeType,
      this.reference,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BookmarkArticleDetailsItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    modeType = json['modeType'];
    reference = json['reference'] != null
        ? Reference.fromJson(json['reference'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['modeType'] = modeType;
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? contactNumber;
  String? photoUrl;
  String? age;

  User(
      {this.sId,
      this.name,
      this.email,
      this.contactNumber,
      this.photoUrl,
      this.age});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contactNumber'];
    photoUrl = json['photoUrl'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['contactNumber'] = contactNumber;
    data['photoUrl'] = photoUrl;
    data['age'] = age;
    return data;
  }
}

// Create Category class to handle category field as an object
class Category {
  String? sId;
  String? title;

  Category({this.sId, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    return data;
  }
}

// Modify Reference class to handle category as a Category object
class Reference {
  String? sId;
  String? title;
  String? thumbnail;
  Category? category;  // Now category is a Category object
  String? description;
  String? author;
  String? status;
  String? publishedAt;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reference(
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

  Reference.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])  // Handle category as Category object
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
      data['category'] = category!.toJson();  // Serialize category as Category object
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
