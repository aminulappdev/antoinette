class SessionDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  SessionDataModel? data;

  SessionDetailsModel({this.success, this.statusCode, this.message, this.data});

  SessionDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? SessionDataModel.fromJson(json['data']) : null;
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

class SessionDataModel {
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
  int? iV;

  SessionDataModel(
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
      this.updatedAt,
      this.iV});

  SessionDataModel.fromJson(Map<String, dynamic> json) {
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
    iV = json['__v'];
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
    data['__v'] = iV;
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
  Null age;

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
