class AllOrderModel {
  AllOrderModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final List<AllOrderItemModel> data;

  factory AllOrderModel.fromJson(Map<String, dynamic> json) {
    return AllOrderModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<AllOrderItemModel>.from(
              json["data"].map((x) => AllOrderItemModel.fromJson(x))),
    );
  }
}

class AllOrderItemModel {
  AllOrderItemModel({
    required this.id,
    required this.user,
    required this.amount,
    required this.deliveryCharge,
    required this.status,
    required this.paymentStatus,
    required this.transactionId,
    required this.billingDetails,
    required this.isDeleted,
    required this.datumId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.items,
  });

  final String? id;
  final User? user;
  final double? amount;
  final int? deliveryCharge;
  final String? status;
  final String? paymentStatus;
  final dynamic transactionId;
  final BillingDetails? billingDetails;
  final bool? isDeleted;
  final String? datumId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Item> items;

  factory AllOrderItemModel.fromJson(Map<String, dynamic> json) {
    return AllOrderItemModel(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      amount: (json["amount"] is int)
          ? (json["amount"] as int).toDouble()
          : json["amount"],
      deliveryCharge: json["deliveryCharge"],
      status: json["status"],
      paymentStatus: json["paymentStatus"],
      transactionId: json["transactionId"],
      billingDetails: json["billingDetails"] == null
          ? null
          : BillingDetails.fromJson(json["billingDetails"]),
      isDeleted: json["isDeleted"],
      datumId: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
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
    required this.product,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  final Product? product;
  final int? quantity;
  final double? price;
  final double? totalPrice;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
      quantity: json["quantity"],
      price: (json["price"] is int)
          ? (json["price"] as int).toDouble()
          : json["price"],
      totalPrice: (json["totalPrice"] is int)
          ? (json["totalPrice"] as int).toDouble()
          : json["totalPrice"],
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.images,
  });

  final String? id;
  final String? name;
  final List<Image> images;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      images: json["images"] == null
          ? []
          : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
