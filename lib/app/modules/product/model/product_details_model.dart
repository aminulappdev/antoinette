class ProductDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  ProductModel? data;

  ProductDetailsModel({this.success, this.statusCode, this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ProductModel.fromJson(json['data']) : null;
  }
}

class ProductModel {
  String? sId;
  String? name;
  List<Images>? images;
  String? description;
  Category? category;
  int? quantity;
  int? sold;
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
  int? iV;
  double? amount;

  ProductModel({
    this.sId,
    this.name,
    this.images,
    this.description,
    this.category,
    this.quantity,
    this.sold,
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
    this.updatedAt,
    this.iV,
    this.amount,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    description = json['description'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    quantity = json['quantity'];
    sold = json['sold'];
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
    iV = json['__v'];
    
    // Handle int or double for amount
    amount = json['amount'] != null
        ? (json['amount'] is int
            ? (json['amount'] as int).toDouble()
            : json['amount'])
        : null;
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

  Category({
    this.sId,
    this.title,
    this.thumbnail,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

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
