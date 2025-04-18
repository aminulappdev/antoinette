class AllBookmarkPodcastModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<AllBookmarkPodcastItemModel>? data;

  AllBookmarkPodcastModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  AllBookmarkPodcastModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <AllBookmarkPodcastItemModel>[];
      json['data'].forEach((v) {
        data!.add(AllBookmarkPodcastItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPage'] = totalPage;
    return data;
  }
}

class AllBookmarkPodcastItemModel {
  String? sId;
  User? user;
  String? modeType;
  Reference? reference;
  String? createdAt;
  String? updatedAt;

  AllBookmarkPodcastItemModel(
      {this.sId,
      this.user,
      this.modeType,
      this.reference,
      this.createdAt,
      this.updatedAt});

  AllBookmarkPodcastItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    modeType = json['modeType'];
    reference = json['reference'] != null
        ? Reference.fromJson(json['reference'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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

class Reference {
  String? sId;
  String? title;
  int? episodeNumber;
  Category? category; // Change from String? to Category
  String? thumbnail;
  String? author;
  String? duration;
  String? fileLink;
  String? embedLink;
  String? status;
  String? publishedAt;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reference(
      {this.sId,
      this.title,
      this.episodeNumber,
      this.category,
      this.thumbnail,
      this.author,
      this.duration,
      this.fileLink,
      this.embedLink,
      this.status,
      this.publishedAt,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Reference.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    episodeNumber = json['episodeNumber'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null; // Change here
    thumbnail = json['thumbnail'];
    author = json['author'];
    duration = json['duration'];
    fileLink = json['fileLink'];
    embedLink = json['embedLink'];
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
    data['episodeNumber'] = episodeNumber;
    if (category != null) {
      data['category'] = category!.toJson(); // Serialize Category object
    }
    data['thumbnail'] = thumbnail;
    data['author'] = author;
    data['duration'] = duration;
    data['fileLink'] = fileLink;
    data['embedLink'] = embedLink;
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
