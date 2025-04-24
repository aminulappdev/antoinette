// import 'dart:convert';

// // This will represent the full booking data response
// class AllBookingModel {
//   AllBookingModel({
//     required this.success,
//     required this.statusCode,
//     required this.message,
//     required this.meta,
//     required this.data,
//   });

//   final bool success;
//   final int statusCode;
//   final String message;
//   final Meta meta;
//   final List<AllBookingItemModel> data;

//   factory AllBookingModel.fromJson(Map<String, dynamic> json) {
//     return AllBookingModel(
//       success: json["success"],
//       statusCode: json["statusCode"],
//       message: json["message"],
//       meta: Meta.fromJson(json["meta"]),
//       data: List<AllBookingItemModel>.from(
//         json["data"].map((x) => AllBookingItemModel.fromJson(x)),
//       ),
//     );
//   }
// }

// class AllBookingItemModel {
//   AllBookingItemModel({
//     required this.id,
//     required this.user,
//     required this.session,
//     required this.slot,
//     required this.amount, // Change this to double
//     required this.transactionId,
//     required this.therapyType,
//     required this.emotionState,
//     required this.paymentStatus,
//     required this.status,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final String id;
//   final String user;
//   final Session? session;
//   final Slot? slot;
//   final double amount; // Change the type to double
//   final dynamic transactionId;
//   final String therapyType;
//   final String emotionState;
//   final String paymentStatus;
//   final String status;
//   final bool isDeleted;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   factory AllBookingItemModel.fromJson(Map<String, dynamic> json) {
//     return AllBookingItemModel(
//       id: json["_id"],
//       user: json["user"],
//       session: json["session"] == null ? null : Session.fromJson(json["session"]),
//       slot: json["slot"] == null ? null : Slot.fromJson(json["slot"]),
//       amount: json["amount"].toDouble(), // Convert to double
//       transactionId: json["transactionId"],
//       therapyType: json["therapyType"],
//       emotionState: json["emotionState"],
//       paymentStatus: json["paymentStatus"],
//       status: json["status"],
//       isDeleted: json["isDeleted"],
//       createdAt: DateTime.parse(json["createdAt"]),
//       updatedAt: DateTime.parse(json["updatedAt"]),
//     );
//   }
// }


// // Session information for the booking
// class Session {
//   Session({
//     required this.id,
//     required this.title,
//     required this.thumbnail,
//     required this.description,
//     required this.fee,
//     required this.therapyType,
//     required this.location,
//     required this.locationLink,
//     required this.therapist,
//     required this.status,
//     required this.isDeleted,
//     required this.sessionId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   final String id;
//   final String title;
//   final String thumbnail;
//   final String description;
//   final int fee;
//   final String therapyType;
//   final String location;
//   final String locationLink;
//   final String therapist;
//   final String status;
//   final bool isDeleted;
//   final String sessionId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   factory Session.fromJson(Map<String, dynamic> json) {
//     return Session(
//       id: json["_id"],
//       title: json["title"],
//       thumbnail: json["thumbnail"],
//       description: json["description"],
//       fee: json["fee"],
//       therapyType: json["therapyType"],
//       location: json["location"],
//       locationLink: json["locationLink"],
//       therapist: json["therapist"],
//       status: json["status"],
//       isDeleted: json["isDeleted"],
//       sessionId: json["id"],
//       createdAt: DateTime.parse(json["createdAt"]),
//       updatedAt: DateTime.parse(json["updatedAt"]),
//       v: json["__v"],
//     );
//   }
// }

// // Slot for the booking
// class Slot {
//   Slot({
//     required this.id,
//     required this.session,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//     required this.isBooked,
//     required this.isDeleted,
//     required this.v,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final String id;
//   final String session;
//   final DateTime date;
//   final String startTime;
//   final String endTime;
//   final bool isBooked;
//   final bool isDeleted;
//   final int v;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   factory Slot.fromJson(Map<String, dynamic> json) {
//     return Slot(
//       id: json["_id"],
//       session: json["session"],
//       date: DateTime.parse(json["date"]),
//       startTime: json["startTime"],
//       endTime: json["endTime"],
//       isBooked: json["isBooked"],
//       isDeleted: json["isDeleted"],
//       v: json["__v"],
//       createdAt: DateTime.parse(json["createdAt"]),
//       updatedAt: DateTime.parse(json["updatedAt"]),
//     );
//   }
// }

// // Metadata information for pagination
// class Meta {
//   Meta({
//     required this.page,
//     required this.limit,
//     required this.total,
//     required this.totalPage,
//   });

//   final int page;
//   final int limit;
//   final int total;
//   final int totalPage;

//   factory Meta.fromJson(Map<String, dynamic> json) {
//     return Meta(
//       page: json["page"],
//       limit: json["limit"],
//       total: json["total"],
//       totalPage: json["totalPage"],
//     );
//   }
// }

class AllBookingModel {
    AllBookingModel({
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
    final List<AllBookingItemModel> data;

    factory AllBookingModel.fromJson(Map<String, dynamic> json){ 
        return AllBookingModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllBookingItemModel>.from(json["data"]!.map((x) => AllBookingItemModel.fromJson(x))),
        );
    }

}

class AllBookingItemModel {
    AllBookingItemModel({
        required this.id,
        required this.user,
        required this.session,
        required this.slot,
        required this.amount,
        required this.transactionId,
        required this.therapyType,
        required this.emotionState,
        required this.paymentStatus,
        required this.status,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? user;
    final Session? session;
    final Slot? slot;
    final dynamic amount;
    final dynamic transactionId;
    final String? therapyType;
    final String? emotionState;
    final String? paymentStatus;
    final String? status;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory AllBookingItemModel.fromJson(Map<String, dynamic> json){ 
        return AllBookingItemModel(
            id: json["_id"],
            user: json["user"],
            session: json["session"] == null ? null : Session.fromJson(json["session"]),
            slot: json["slot"] == null ? null : Slot.fromJson(json["slot"]),
            amount: json["amount"],
            transactionId: json["transactionId"],
            therapyType: json["therapyType"],
            emotionState: json["emotionState"],
            paymentStatus: json["paymentStatus"],
            status: json["status"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class Session {
    Session({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.description,
        required this.fee,
        required this.therapyType,
        required this.location,
        required this.locationLink,
        required this.therapist,
        required this.status,
        required this.isDeleted,
        required this.sessionId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? title;
    final String? thumbnail;
    final String? description;
    final int? fee;
    final String? therapyType;
    final String? location;
    final String? locationLink;
    final String? therapist;
    final String? status;
    final bool? isDeleted;
    final String? sessionId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Session.fromJson(Map<String, dynamic> json){ 
        return Session(
            id: json["_id"],
            title: json["title"],
            thumbnail: json["thumbnail"],
            description: json["description"],
            fee: json["fee"],
            therapyType: json["therapyType"],
            location: json["location"],
            locationLink: json["locationLink"],
            therapist: json["therapist"],
            status: json["status"],
            isDeleted: json["isDeleted"],
            sessionId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Slot {
    Slot({
        required this.id,
        required this.session,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.isBooked,
        required this.isDeleted,
        required this.v,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? session;
    final DateTime? date;
    final String? startTime;
    final String? endTime;
    final bool? isBooked;
    final bool? isDeleted;
    final int? v;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Slot.fromJson(Map<String, dynamic> json){ 
        return Slot(
            id: json["_id"],
            session: json["session"],
            date: DateTime.tryParse(json["date"] ?? ""),
            startTime: json["startTime"],
            endTime: json["endTime"],
            isBooked: json["isBooked"],
            isDeleted: json["isDeleted"],
            v: json["__v"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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


