class SessionSlotByIdModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<SessionSlotItemModel>? data;

  SessionSlotByIdModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  SessionSlotByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <SessionSlotItemModel>[];
      json['data'].forEach((v) {
        data!.add(SessionSlotItemModel.fromJson(v));
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

class SessionSlotItemModel {
  String? sId;
  String? session;
  String? date;
  String? startTime;
  String? endTime;
  bool? isBooked;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  SessionSlotItemModel(
      {this.sId,
      this.session,
      this.date,
      this.startTime,
      this.endTime,
      this.isBooked,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  SessionSlotItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    session = json['session'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isBooked = json['isBooked'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['session'] = session;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['isBooked'] = isBooked;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
