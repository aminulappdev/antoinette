class SessionBookingResponseModel {
  SessionBookingResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final List<SessionBookingResponseItemModel> data;

  factory SessionBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return SessionBookingResponseModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : (json["data"] as List<dynamic>)
              .map((x) => SessionBookingResponseItemModel.fromJson(x))
              .toList(), // ✅ এখানে .toList() যোগ করেছি
    );
  }
}

class SessionBookingResponseItemModel {
  SessionBookingResponseItemModel({
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
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? user;
  final String? session;
  final String? slot;
  final int? amount;
  final dynamic transactionId;
  final String? therapyType;
  final String? emotionState;
  final String? paymentStatus;
  final String? status;
  final bool? isDeleted;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory SessionBookingResponseItemModel.fromJson(Map<String, dynamic> json) {
    return SessionBookingResponseItemModel(
      user: json["user"],
      session: json["session"],
      slot: json["slot"],
      amount: json["amount"],
      transactionId: json["transactionId"],
      therapyType: json["therapyType"],
      emotionState: json["emotionState"],
      paymentStatus: json["paymentStatus"],
      status: json["status"],
      isDeleted: json["isDeleted"],
      id: json["_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}
