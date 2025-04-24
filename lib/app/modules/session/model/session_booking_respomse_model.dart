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
  final SessionBookingResponseItemModel data; // Change from List to a single object

  factory SessionBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return SessionBookingResponseModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null
          ? SessionBookingResponseItemModel.empty() // Handle null case
          : SessionBookingResponseItemModel.fromJson(json["data"]),
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
  final num? amount; // Change to `num` to handle both int and double
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
      amount: json["amount"], // This will now accept both int and double
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

  // Empty constructor to handle null cases
  factory SessionBookingResponseItemModel.empty() {
    return SessionBookingResponseItemModel(
      user: null,
      session: null,
      slot: null,
      amount: 0,
      transactionId: null,
      therapyType: null,
      emotionState: null,
      paymentStatus: null,
      status: null,
      isDeleted: false,
      id: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0,
    );
  }
}
