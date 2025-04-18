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

    factory AllOrderModel.fromJson(Map<String, dynamic> json){ 
        return AllOrderModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? [] : List<AllOrderItemModel>.from(json["data"]!.map((x) => AllOrderItemModel.fromJson(x))),
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

    factory AllOrderItemModel.fromJson(Map<String, dynamic> json){ 
        return AllOrderItemModel(
            id: json["_id"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            amount: json["amount"],
            deliveryCharge: json["deliveryCharge"],
            status: json["status"],
            paymentStatus: json["paymentStatus"],
            transactionId: json["transactionId"],
            billingDetails: json["billingDetails"] == null ? null : BillingDetails.fromJson(json["billingDetails"]),
            isDeleted: json["isDeleted"],
            datumId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
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

    factory BillingDetails.fromJson(Map<String, dynamic> json){ 
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

    factory User.fromJson(Map<String, dynamic> json){ 
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
