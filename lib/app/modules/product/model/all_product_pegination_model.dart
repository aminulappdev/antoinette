class AllProductPeginationModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<AllProductItemModel>? data;

  AllProductPeginationModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  AllProductPeginationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <AllProductItemModel>[];
      json['data'].forEach((v) {
        data!.add(AllProductItemModel.fromJson(v));
      });
    }
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
}

class AllProductItemModel {
  String? sId;
  String? name;
  List<Images>? images;
  String? description;
  Category? category;
  int? quantity;
  int? sold;
  double? amount;
  int? discount;
  String? faq;
  bool? restockAlert;
  bool? isStock;
  String? size;
  String? warrantyPolicy;
  String? returnAndRefundPolicy;
  String? replacementPolicy;
  bool? isDeleted;
  String? id;
  String? createdAt;
  String? updatedAt;

  AllProductItemModel(
      {this.sId,
      this.name,
      this.images,
      this.description,
      this.category,
      this.quantity,
      this.sold,
      this.amount,
      this.discount,
      this.faq,
      this.restockAlert,
      this.isStock,
      this.size,
      this.warrantyPolicy,
      this.returnAndRefundPolicy,
      this.replacementPolicy,
      this.isDeleted,
      this.id,
      this.createdAt,
      this.updatedAt});

  AllProductItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    description = json['description'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    quantity = json['quantity'];
    sold = json['sold'];
    amount = json['amount'];
    discount = json['discount'];
    faq = json['faq'];
    restockAlert = json['restockAlert'];
    isStock = json['isStock'];
    size = json['size'];
    warrantyPolicy = json['warrantyPolicy'];
    returnAndRefundPolicy = json['returnAndRefundPolicy'];
    replacementPolicy = json['replacementPolicy'];
    isDeleted = json['isDeleted'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class Images {
  String? key;
  String? url;
  String? sId;

  Images({this.key, this.url, this.sId});

  Images.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    sId = json['_id'];
  }
}

class Category {
  String? sId;
  String? title;
  String? thumbnail;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Category(
      {this.sId,
      this.title,
      this.thumbnail,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
