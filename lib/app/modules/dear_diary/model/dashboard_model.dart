class DashboardModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  DashboardItemModel? data;

  DashboardModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? DashboardItemModel.fromJson(json['data']) : null;
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
      data['data'] = this.data!.toJson();
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

class DashboardItemModel {
  FeelingsStatusData? feelingsStatusData;
  List<DairyData>? dairyData;

  DashboardItemModel({this.feelingsStatusData, this.dairyData});

  DashboardItemModel.fromJson(Map<String, dynamic> json) {
    feelingsStatusData = json['feelingsStatusData'] != null
        ? FeelingsStatusData.fromJson(json['feelingsStatusData'])
        : null;
    if (json['dairyData'] != null) {
      dairyData = <DairyData>[];
      json['dairyData'].forEach((v) {
        dairyData!.add(DairyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feelingsStatusData != null) {
      data['feelingsStatusData'] = feelingsStatusData!.toJson();
    }
    if (dairyData != null) {
      data['dairyData'] = dairyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeelingsStatusData {
  int? happy;
  int? calm;
  int? sad;
  int? anxious;
  int? angry;
  int? motivated;

  FeelingsStatusData(
      {this.happy,
      this.calm,
      this.sad,
      this.anxious,
      this.angry,
      this.motivated});

  FeelingsStatusData.fromJson(Map<String, dynamic> json) {
    happy = json['happy'];
    calm = json['calm'];
    sad = json['sad'];
    anxious = json['anxious'];
    angry = json['angry'];
    motivated = json['motivated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['happy'] = happy;
    data['calm'] = calm;
    data['sad'] = sad;
    data['anxious'] = anxious;
    data['angry'] = angry;
    data['motivated'] = motivated;
    return data;
  }
}

class DairyData {
  String? sId;
  User? user;
  String? date;
  String? time;
  String? description;
  String? feelings;
  String? themeMode;
  bool? isPined;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  DairyData(
      {this.sId,
      this.user,
      this.date,
      this.time,
      this.description,
      this.feelings,
      this.themeMode,
      this.isPined,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  DairyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    date = json['date'];
    time = json['time'];
    description = json['description'];
    feelings = json['feelings'];
    themeMode = json['themeMode'];
    isPined = json['isPined'];
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
    data['date'] = date;
    data['time'] = time;
    data['description'] = description;
    data['feelings'] = feelings;
    data['themeMode'] = themeMode;
    data['isPined'] = isPined;
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
