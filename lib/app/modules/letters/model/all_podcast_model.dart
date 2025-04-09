class AllPodcastModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<AllPodcastItemModel>? data;

  AllPodcastModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  AllPodcastModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <AllPodcastItemModel>[];
      json['data'].forEach((v) {
        data!.add(AllPodcastItemModel.fromJson(v));
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

class AllPodcastItemModel {
  String? sId;
  String? title;
  int? episodeNumber;
  Category? category;
  String? thumbnail;
  String? author;
  String? duration;
  String? fileLink;
  Null embedLink;
  String? status;
  String? publishedAt;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  AllPodcastItemModel(
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
      this.updatedAt});

  AllPodcastItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    episodeNumber = json['episodeNumber'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['episodeNumber'] = episodeNumber;
    if (category != null) {
      data['category'] = category!.toJson();
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
