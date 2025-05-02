class PaymentByBookingIdModel {
    PaymentByBookingIdModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final PaymentByBookingIdItemModel? data;

    factory PaymentByBookingIdModel.fromJson(Map<String, dynamic> json){ 
        return PaymentByBookingIdModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? null : PaymentByBookingIdItemModel.fromJson(json["data"]),
        );
    }

}

class PaymentByBookingIdItemModel {
    PaymentByBookingIdItemModel({
        required this.id,
        required this.modelType,
        required this.account,
        required this.reference,
        required this.transactionId,
        required this.amount,
        required this.status,
        required this.paymentIntentId,
        required this.isPaid,
        required this.isDeleted,
        required this.dataId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? modelType;
    final Account? account;
    final dynamic reference;
    final String? transactionId;
    final int? amount;
    final String? status;
    final String? paymentIntentId;
    final bool? isPaid;
    final bool? isDeleted;
    final String? dataId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory PaymentByBookingIdItemModel.fromJson(Map<String, dynamic> json){ 
        return PaymentByBookingIdItemModel(
            id: json["_id"],
            modelType: json["modelType"],
            account: json["account"] == null ? null : Account.fromJson(json["account"]),
            reference: json["reference"],
            transactionId: json["transactionId"],
            amount: json["amount"],
            status: json["status"],
            paymentIntentId: json["paymentIntentId"],
            isPaid: json["isPaid"],
            isDeleted: json["isDeleted"],
            dataId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Account {
    Account({
        required this.id,
        required this.name,
        required this.email,
        required this.contactNumber,
        required this.photoUrl,
        required this.age,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? contactNumber;
    final String? photoUrl;
    final dynamic age;

    factory Account.fromJson(Map<String, dynamic> json){ 
        return Account(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            contactNumber: json["contactNumber"],
            photoUrl: json["photoUrl"],
            age: json["age"],
        );
    }

}
