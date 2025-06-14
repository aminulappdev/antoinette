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
        required this.studentVerify,
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
        required this.dataId,
        required this.createdAt,
        required this.updatedAt,
    });

    final JournalVerification? journalVerification;
    final StudentVerify? studentVerify;
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
    final String? documents;
    final String? dataId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory ProfileData.fromJson(Map<String, dynamic> json){ 
        return ProfileData(
            journalVerification: json["journalVerification"] == null ? null : JournalVerification.fromJson(json["journalVerification"]),
            studentVerify: json["studentVerify"] == null ? null : StudentVerify.fromJson(json["studentVerify"]),
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

class StudentVerify {
    StudentVerify({
        required this.status,
        required this.expireAt,
    });

    final String? status;
    final DateTime? expireAt;

    factory StudentVerify.fromJson(Map<String, dynamic> json){ 
        return StudentVerify(
            status: json["status"],
            expireAt: DateTime.tryParse(json["expireAt"] ?? ""),
        );
    }

}
