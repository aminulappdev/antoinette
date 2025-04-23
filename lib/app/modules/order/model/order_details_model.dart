class OrderDetailsModel {
  OrderDetailsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final OrderDetailsData? data;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data:
          json["data"] == null ? null : OrderDetailsData.fromJson(json["data"]),
    );
  }
}

class OrderDetailsData {
  OrderDetailsData({
    required this.id,
    required this.user,
    required this.amount,
    required this.deliveryCharge,
    required this.status,
    required this.paymentStatus,
    required this.transactionId,
    required this.billingDetails,
    required this.isDeleted,
    required this.dataId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.items,
  });

  final String? id;
  final User? user;
  final int? amount;
  final int? deliveryCharge;
  final String? status;
  final String? paymentStatus;
  final dynamic transactionId;
  final BillingDetails? billingDetails;
  final bool? isDeleted;
  final String? dataId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Item> items;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    return OrderDetailsData(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      amount: json["amount"],
      deliveryCharge: json["deliveryCharge"],
      status: json["status"],
      paymentStatus: json["paymentStatus"],
      transactionId: json["transactionId"],
      billingDetails: json["billingDetails"] == null
          ? null
          : BillingDetails.fromJson(json["billingDetails"]),
      isDeleted: json["isDeleted"],
      dataId: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }
}

class BillingDetails {
  BillingDetails({
    required this.name,
    required this.pickupDate,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.id,
  });

  final String? name;
  final String? pickupDate;
  final String? address;
  final String? phoneNumber;
  final String? email;
  final String? id;

  factory BillingDetails.fromJson(Map<String, dynamic> json) {
    return BillingDetails(
      name: json["name"],
      pickupDate: json["pickupDate"],
      address: json["address"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      id: json["_id"],
    );
  }
}

class Item {
  Item({
    required this.id,
    required this.product,
    required this.order,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.discount,
    required this.size,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final Product? product;
  final String? order;
  final int? quantity;
  final int? price;
  final int? totalPrice;
  final String? discount;
  final dynamic size;
  final dynamic color;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["_id"],
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
      order: json["order"],
      quantity: json["quantity"],
      price: json["price"],
      totalPrice: json["totalPrice"],
      discount: json["discount"],
      size: json["size"],
      color: json["color"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class Product {
  Product({
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
    required this.productId,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? category;
  final int? quantity;
  final int? sold;
  final int? amount;
  final int? discount;
  final String? faq;
  final bool? restockAlert;
  final bool? isStock;
  final String? size;
  final String? warrantyPolicy;
  final String? returnAndRefundPolicy;
  final String? replacementPolicy;
  final bool? isDeleted;
  final String? productId;
  final List<dynamic> images;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      category: json["category"],
      quantity: json["quantity"],
      sold: json["sold"],
      amount: json["amount"],
      discount: json["discount"],
      faq: json["faq"],
      restockAlert: json["restockAlert"],
      isStock: json["isStock"],
      size: json["size"],
      warrantyPolicy: json["warrantyPolicy"],
      returnAndRefundPolicy: json["returnAndRefundPolicy"],
      replacementPolicy: json["replacementPolicy"],
      isDeleted: json["isDeleted"],
      productId: json["id"],
      images: json["images"] == null
          ? []
          : List<dynamic>.from(json["images"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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
    required this.userId,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? contactNumber;
  final String? photoUrl;
  final String? userId;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      contactNumber: json["contactNumber"],
      photoUrl: json["photoUrl"],
      userId: json["id"],
    );
  }
}
