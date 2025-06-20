class MySubscriptionModel {
  MySubscriptionModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.meta,
    required this.data,
  });

  final bool success;
  final int statusCode;
  final String message;
  final Meta? meta;
  final List<MySubscriptionItemModel> data;

  factory MySubscriptionModel.fromJson(Map<String, dynamic> json) {
    return MySubscriptionModel(
      success: json["success"] ?? false,
      statusCode: json["statusCode"] ?? 0,
      message: json["message"] ?? "",
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<MySubscriptionItemModel>.from(
              json["data"].map((x) => MySubscriptionItemModel.fromJson(x))),
    );
  }
}

class MySubscriptionItemModel {
  MySubscriptionItemModel({
    required this.id,
    required this.user,
    required this.package,
    required this.packageId,
    required this.transactionId,
    required this.amount,
    required this.paymentStatus,
    required this.status,
    required this.expiredAt,
    required this.isExpired,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final User? user;
  final Package? package;
  final String packageId;
  final String transactionId;
  final int amount;
  final String paymentStatus;
  final String status;
  final DateTime expiredAt;
  final bool isExpired;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory MySubscriptionItemModel.fromJson(Map<String, dynamic> json) {
    return MySubscriptionItemModel(
      id: json["_id"] ?? "",
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      package: json["package"] == null ? null : Package.fromJson(json["package"]),
      packageId: json["packageId"] ?? "",
      transactionId: json["transactionId"] ?? "",
      amount: json["amount"] ?? 0,
      paymentStatus: json["paymentStatus"] ?? "",
      status: json["status"] ?? "",
      expiredAt: DateTime.tryParse(json["expiredAt"] ?? "") ?? DateTime.now(),
      isExpired: json["isExpired"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
    );
  }
}

class Package {
  Package({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.billingCycle,
    required this.description,
    required this.price,
    required this.popularity,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String title;
  final String subtitle;
  final String billingCycle;
  final List<String> description;
  final int price;
  final int popularity;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      billingCycle: json["billingCycle"] ?? "",
      description: json["description"] == null
          ? []
          : List<String>.from(json["description"].map((x) => x.toString())),
      price: json["price"] ?? 0,
      popularity: json["popularity"] ?? 0,
      isDeleted: json["isDeleted"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      v: json["__v"] ?? 0,
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.photoUrl,
  });

  final String id;
  final String name;
  final String email;
  final String contactNumber;
  final String? photoUrl;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      contactNumber: json["contactNumber"] ?? "",
      photoUrl: json["photoUrl"],
    );
  }
}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int page;
  final int limit;
  final int total;
  final int totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"] ?? 0,
      limit: json["limit"] ?? 0,
      total: json["total"] ?? 0,
      totalPage: json["totalPage"] ?? 0,
    );
  }
}