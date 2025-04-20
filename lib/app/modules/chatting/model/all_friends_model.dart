class AllFriendsModel {
    AllFriendsModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final List<AllFriendsItemModel> data;

    factory AllFriendsModel.fromJson(Map<String, dynamic> json){ 
        return AllFriendsModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? [] : List<AllFriendsItemModel>.from(json["data"]!.map((x) => AllFriendsItemModel.fromJson(x))),
        );
    }

}

class AllFriendsItemModel {
    AllFriendsItemModel({
        required this.id,
        required this.participants,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final List<Participant> participants;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory AllFriendsItemModel.fromJson(Map<String, dynamic> json){ 
        return AllFriendsItemModel(
            id: json["_id"],
            participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
            status: json["status"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Participant {
    Participant({
        required this.id,
        required this.name,
        required this.email,
        required this.contactNumber,
        required this.photoUrl,
    });

    final String? id;
    final String? name;
    final String? email;
    final dynamic contactNumber;
    final String? photoUrl;

    factory Participant.fromJson(Map<String, dynamic> json){ 
        return Participant(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            contactNumber: json["contactNumber"],
            photoUrl: json["photoUrl"],
        );
    }

}
