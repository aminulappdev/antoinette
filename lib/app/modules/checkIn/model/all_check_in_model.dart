class AllCheckInModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<CheckInItemModel>? data;

  AllCheckInModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  AllCheckInModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <CheckInItemModel>[];
      json['data'].forEach((v) {
        data!.add(CheckInItemModel.fromJson(v));
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

class CheckInItemModel {
  String? sId;
  User? user;
  String? timer;
  String? quickCheckIn;
  List<String>? trustedContracts;
  bool? isSafe;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  CheckInItemModel(
      {this.sId,
      this.user,
      this.timer,
      this.quickCheckIn,
      this.trustedContracts,
      this.isSafe,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  CheckInItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    timer = json['timer'];
    quickCheckIn = json['quickCheckIn'];
    trustedContracts = json['trustedContracts'].cast<String>();
    isSafe = json['isSafe'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['timer'] = timer;
    data['quickCheckIn'] = quickCheckIn;
    data['trustedContracts'] = trustedContracts;
    data['isSafe'] = isSafe;
    data['isDeleted'] = isDeleted;
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
