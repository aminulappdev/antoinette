class AllCheckInModel {
    AllCheckInModel({
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
    final List<CheckInItemModel> data;

    factory AllCheckInModel.fromJson(Map<String, dynamic> json){ 
        return AllCheckInModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<CheckInItemModel>.from(json["data"]!.map((x) => CheckInItemModel.fromJson(x))),
        );
    }

}

class CheckInItemModel {
    CheckInItemModel({
        required this.id,
        required this.user,
        required this.timer,
        required this.quickCheckIn,
        required this.trustedContracts,
        required this.checkInTime,
        required this.locationUrl,
        required this.isSafe,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final User? user;
    final String? timer;
    final String? quickCheckIn;
    final List<TrustedContract> trustedContracts;
    final DateTime? checkInTime;
    final String? locationUrl;
    final bool? isSafe;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory CheckInItemModel.fromJson(Map<String, dynamic> json){ 
        return CheckInItemModel(
            id: json["_id"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            timer: json["timer"],
            quickCheckIn: json["quickCheckIn"],
            trustedContracts: json["trustedContracts"] == null ? [] : List<TrustedContract>.from(json["trustedContracts"]!.map((x) => TrustedContract.fromJson(x))),
            checkInTime: DateTime.tryParse(json["checkInTime"] ?? ""),
            locationUrl: json["locationUrl"],
            isSafe: json["isSafe"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class TrustedContract {
    TrustedContract({
        required this.id,
        required this.name,
        required this.contractNumber,
    });

    final String? id;
    final String? name;
    final String? contractNumber;

    factory TrustedContract.fromJson(Map<String, dynamic> json){ 
        return TrustedContract(
            id: json["_id"],
            name: json["name"],
            contractNumber: json["contractNumber"],
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

    final String? id;
    final String? name;
    final String? email;
    final String? contactNumber;
    final String? photoUrl;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            contactNumber: json["contactNumber"],
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

    final int? page;
    final int? limit;
    final int? total;
    final int? totalPage;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPage: json["totalPage"],
        );
    }

}
