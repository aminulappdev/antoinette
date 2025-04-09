class ContentModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<ContentItemModel>? data;

  ContentModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  ContentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <ContentItemModel>[];
      json['data'].forEach((v) {
        data!.add(ContentItemModel.fromJson(v));
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

class ContentItemModel {
  String? sId;
  String? aboutUs;
  String? termsAndConditions;
  String? privacyPolicy;
  String? supports;
  String? faq;
  bool? isDeleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  ContentItemModel(
      {this.sId,
      this.aboutUs,
      this.termsAndConditions,
      this.privacyPolicy,
      this.supports,
      this.faq,
      this.isDeleted,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  ContentItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    aboutUs = json['aboutUs'];
    termsAndConditions = json['termsAndConditions'];
    privacyPolicy = json['privacyPolicy'];
    supports = json['supports'];
    faq = json['faq'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['aboutUs'] = aboutUs;
    data['termsAndConditions'] = termsAndConditions;
    data['privacyPolicy'] = privacyPolicy;
    data['supports'] = supports;
    data['faq'] = faq;
    data['isDeleted'] = isDeleted;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
