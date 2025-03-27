class AllSessionModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<AllSessionItemModel>? data;

  AllSessionModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  AllSessionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <AllSessionItemModel>[];
      json['data'].forEach((v) {
        data!.add(AllSessionItemModel.fromJson(v));
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

class AllSessionItemModel {
  String? sId;
  String? title;
  String? thumbnail;
  String? description;
  int? fee;
  String? therapyType;
  String? location;
  String? locationLink;
  Therapist? therapist;
  String? status;
  bool? isDeleted;
  String? id;
  String? createdAt;
  String? updatedAt;

  AllSessionItemModel(
      {this.sId,
      this.title,
      this.thumbnail,
      this.description,
      this.fee,
      this.therapyType,
      this.location,
      this.locationLink,
      this.therapist,
      this.status,
      this.isDeleted,
      this.id,
      this.createdAt,
      this.updatedAt});

  AllSessionItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    fee = json['fee'];
    therapyType = json['therapyType'];
    location = json['location'];
    locationLink = json['locationLink'];
    therapist = json['therapist'] != null
        ? Therapist.fromJson(json['therapist'])
        : null;
    status = json['status'];
    isDeleted = json['isDeleted'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['description'] = description;
    data['fee'] = fee;
    data['therapyType'] = therapyType;
    data['location'] = location;
    data['locationLink'] = locationLink;
    if (therapist != null) {
      data['therapist'] = therapist!.toJson();
    }
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Therapist {
  String? sId;
  String? id;
  User? user;
  String? bio;
  String? achievement;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Therapist(
      {this.sId,
      this.id,
      this.user,
      this.bio,
      this.achievement,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Therapist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    bio = json['bio'];
    achievement = json['achievement'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['bio'] = bio;
    data['achievement'] = achievement;
    data['isDeleted'] = isDeleted;
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
  Null contactNumber;
  String? photoUrl;

  User({this.sId, this.name, this.email, this.contactNumber, this.photoUrl});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contactNumber'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['contactNumber'] = contactNumber;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
