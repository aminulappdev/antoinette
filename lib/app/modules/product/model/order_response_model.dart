// class OrderResponseModel {
//     OrderResponseModel({
//         required this.success,
//         required this.statusCode,
//         required this.message,
//         required this.data,
//     });

//     final bool? success;
//     final int? statusCode;
//     final String? message;
//     final OrderResponseItemModel? data;

//     factory OrderResponseModel.fromJson(Map<String, dynamic> json){ 
//         return OrderResponseModel(
//             success: json["success"],
//             statusCode: json["statusCode"],
//             message: json["message"],
//             data: json["data"] == null ? null : OrderResponseItemModel.fromJson(json["data"]),
//         );
//     }

// }

// class OrderResponseItemModel {
//     OrderResponseItemModel({
//         required this.id,
//         required this.user,
//         required this.amount,
//         required this.deliveryCharge,
//         required this.status,
//         required this.paymentStatus,
//         required this.transactionId,
//         required this.billingDetails,
//         required this.isDeleted,
//         required this.dataId,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     final String? id;
//     final User? user;
//     final int? amount;
//     final int? deliveryCharge;
//     final String? status;
//     final String? paymentStatus;
//     final dynamic transactionId;
//     final BillingDetails? billingDetails;
//     final bool? isDeleted;
//     final String? dataId;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final int? v;

//     factory OrderResponseItemModel.fromJson(Map<String, dynamic> json){ 
//         return OrderResponseItemModel(
//             id: json["_id"],
//             user: json["user"] == null ? null : User.fromJson(json["user"]),
//             amount: json["amount"],
//             deliveryCharge: json["deliveryCharge"],
//             status: json["status"],
//             paymentStatus: json["paymentStatus"],
//             transactionId: json["transactionId"],
//             billingDetails: json["billingDetails"] == null ? null : BillingDetails.fromJson(json["billingDetails"]),
//             isDeleted: json["isDeleted"],
//             dataId: json["id"],
//             createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//             updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//             v: json["__v"],
//         );
//     }

// }

// class BillingDetails {
//     BillingDetails({
//         required this.name,
//         required this.pickupDate,
//         required this.address,
//         required this.phoneNumber,
//         required this.email,
//         required this.id,
//     });

//     final String? name;
//     final DateTime? pickupDate;
//     final String? address;
//     final String? phoneNumber;
//     final String? email;
//     final String? id;

//     factory BillingDetails.fromJson(Map<String, dynamic> json){ 
//         return BillingDetails(
//             name: json["name"],
//             pickupDate: DateTime.tryParse(json["pickupDate"] ?? ""),
//             address: json["address"],
//             phoneNumber: json["phoneNumber"],
//             email: json["email"],
//             id: json["_id"],
//         );
//     }

// }

// class User {
//     User({
//         required this.verification,
//         required this.journalVerification,
//         required this.documents,
//         required this.isStudent,
//         required this.id,
//         required this.name,
//         required this.email,
//         required this.password,
//         required this.contactNumber,
//         required this.city,
//         required this.homeAddress,
//         required this.officeAddress,
//         required this.deliveryAddress,
//         required this.photoUrl,
//         required this.role,
//         required this.age,
//         required this.registerWith,
//         required this.needsPasswordChange,
//         required this.passwordChangedAt,
//         required this.status,
//         required this.packageExpiry,
//         required this.isDeleted,
//         required this.userId,
//         required this.packages,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//         required this.freeTrialExpiry,
//         required this.isFreeTrial,
//     });

//     final Verification? verification;
//     final JournalVerification? journalVerification;
//     final dynamic documents;
//     final bool? isStudent;
//     final String? id;
//     final String? name;
//     final String? email;
//     final String? password;
//     final String? contactNumber;
//     final dynamic city;
//     final dynamic homeAddress;
//     final dynamic officeAddress;
//     final dynamic deliveryAddress;
//     final dynamic photoUrl;
//     final String? role;
//     final dynamic age;
//     final String? registerWith;
//     final bool? needsPasswordChange;
//     final dynamic passwordChangedAt;
//     final String? status;
//     final DateTime? packageExpiry;
//     final bool? isDeleted;
//     final String? userId;
//     final List<dynamic> packages;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final int? v;
//     final DateTime? freeTrialExpiry;
//     final bool? isFreeTrial;

//     factory User.fromJson(Map<String, dynamic> json){ 
//         return User(
//             verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
//             journalVerification: json["journalVerification"] == null ? null : JournalVerification.fromJson(json["journalVerification"]),
//             documents: json["documents"],
//             isStudent: json["isStudent"],
//             id: json["_id"],
//             name: json["name"],
//             email: json["email"],
//             password: json["password"],
//             contactNumber: json["contactNumber"],
//             city: json["city"],
//             homeAddress: json["homeAddress"],
//             officeAddress: json["officeAddress"],
//             deliveryAddress: json["deliveryAddress"],
//             photoUrl: json["photoUrl"],
//             role: json["role"],
//             age: json["age"],
//             registerWith: json["registerWith"],
//             needsPasswordChange: json["needsPasswordChange"],
//             passwordChangedAt: json["passwordChangedAt"],
//             status: json["status"],
//             packageExpiry: DateTime.tryParse(json["packageExpiry"] ?? ""),
//             isDeleted: json["isDeleted"],
//             userId: json["id"],
//             packages: json["packages"] == null ? [] : List<dynamic>.from(json["packages"]!.map((x) => x)),
//             createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//             updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//             v: json["__v"],
//             freeTrialExpiry: DateTime.tryParse(json["freeTrialExpiry"] ?? ""),
//             isFreeTrial: json["isFreeTrial"],
//         );
//     }

// }

// class JournalVerification {
//     JournalVerification({
//         required this.faceLock,
//         required this.password,
//     });

//     final FaceLock? faceLock;
//     final FaceLock? password;

//     factory JournalVerification.fromJson(Map<String, dynamic> json){ 
//         return JournalVerification(
//             faceLock: json["faceLock"] == null ? null : FaceLock.fromJson(json["faceLock"]),
//             password: json["password"] == null ? null : FaceLock.fromJson(json["password"]),
//         );
//     }

// }

// class FaceLock {
//     FaceLock({
//         required this.key,
//     });

//     final String? key;

//     factory FaceLock.fromJson(Map<String, dynamic> json){ 
//         return FaceLock(
//             key: json["key"],
//         );
//     }

// }

// class Verification {
//     Verification({
//         required this.otp,
//         required this.expiresAt,
//         required this.status,
//     });

//     final int? otp;
//     final DateTime? expiresAt;
//     final bool? status;

//     factory Verification.fromJson(Map<String, dynamic> json){ 
//         return Verification(
//             otp: json["otp"],
//             expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
//             status: json["status"],
//         );
//     }

// }
