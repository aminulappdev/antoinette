class ProfileModel {
    ProfileModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final ProfileData? data;

    factory ProfileModel.fromJson(Map<String, dynamic> json){ 
        return ProfileModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
        );
    }

}

class ProfileData {
    ProfileData({
        required this.journalVerification,
        required this.id,
        required this.name,
        required this.email,
        required this.contactNumber,
        required this.homeAddress,
        required this.officeAddress,
        required this.deliveryAddress,
        required this.photoUrl,
        required this.age,
        required this.status,
        required this.documents,
        required this.isStudent,
        required this.dataId,
        required this.createdAt,
        required this.updatedAt,
    });

    final JournalVerification? journalVerification;
    final String? id;
    final String? name;
    final String? email;
    final String? contactNumber;
    final dynamic homeAddress;
    final dynamic officeAddress;
    final dynamic deliveryAddress;
    final dynamic photoUrl;
    final dynamic age;
    final String? status;
    final dynamic documents;
    final bool? isStudent;
    final String? dataId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory ProfileData.fromJson(Map<String, dynamic> json){ 
        return ProfileData(
            journalVerification: json["journalVerification"] == null ? null : JournalVerification.fromJson(json["journalVerification"]),
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            contactNumber: json["contactNumber"],
            homeAddress: json["homeAddress"],
            officeAddress: json["officeAddress"],
            deliveryAddress: json["deliveryAddress"],
            photoUrl: json["photoUrl"],
            age: json["age"],
            status: json["status"],
            documents: json["documents"],
            isStudent: json["isStudent"],
            dataId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class JournalVerification {
    JournalVerification({
        required this.password,
        required this.faceLock,
    });

    final FaceLock? password;
    final FaceLock? faceLock;

    factory JournalVerification.fromJson(Map<String, dynamic> json){ 
        return JournalVerification(
            password: json["password"] == null ? null : FaceLock.fromJson(json["password"]),
            faceLock: json["faceLock"] == null ? null : FaceLock.fromJson(json["faceLock"]),
        );
    }

}

class FaceLock {
    FaceLock({
        required this.key,
    });

    final dynamic key;

    factory FaceLock.fromJson(Map<String, dynamic> json){ 
        return FaceLock(
            key: json["key"],
        );
    }

}
