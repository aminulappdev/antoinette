class AllProductPeginationModel {
  AllProductPeginationModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.meta,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final Meta? meta;
  final List<AllProductItemModel> data;

  factory AllProductPeginationModel.fromJson(Map<String, dynamic> json) {
    return AllProductPeginationModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<AllProductItemModel>.from(
              json["data"].map((x) => AllProductItemModel.fromJson(x))),
    );
  }
}

class AllProductItemModel {
  AllProductItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.sold,
    required this.amount,
    required this.discount,
    required this.faq,
    required this.restockAlert,
    required this.isStock,
    required this.size,
    required this.warrantyPolicy,
    required this.returnAndRefundPolicy,
    required this.replacementPolicy,
    required this.isDeleted,
    required this.datumId,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? description;
  final Category? category;
  final int? quantity;
  final int? sold;
  final double? amount;
  final int? discount;
  final String? faq;
  final bool? restockAlert;
  final bool? isStock;
  final String? size;
  final String? warrantyPolicy;
  final String? returnAndRefundPolicy;
  final String? replacementPolicy;
  final bool? isDeleted;
  final String? datumId;
  final List<Image> images;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AllProductItemModel.fromJson(Map<String, dynamic> json) {
    return AllProductItemModel(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      quantity: json["quantity"],
      sold: json["sold"],
      amount: json["amount"] is int
          ? (json["amount"] as int).toDouble()
          : json["amount"],
      discount: json["discount"],
      faq: json["faq"],
      restockAlert: json["restockAlert"],
      isStock: json["isStock"],
      size: json["size"],
      warrantyPolicy: json["warrantyPolicy"],
      returnAndRefundPolicy: json["returnAndRefundPolicy"],
      replacementPolicy: json["replacementPolicy"],
      isDeleted: json["isDeleted"],
      datumId: json["id"],
      images: json["images"] == null
          ? []
          : List<Image>.from(
              json["images"].map((x) => Image.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? title;
  final String? thumbnail;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"],
      title: json["title"],
      thumbnail: json["thumbnail"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class Image {
  Image({
    required this.key,
    required this.url,
    required this.id,
  });

  final String? key;
  final String? url;
  final String? id;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      key: json["key"],
      url: json["url"],
      id: json["_id"],
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

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
