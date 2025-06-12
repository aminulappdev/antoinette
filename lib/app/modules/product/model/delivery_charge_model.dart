class DeliveryChargeModel {
    DeliveryChargeModel({
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
    final List<DeliveryChargeItemModel> data;

    factory DeliveryChargeModel.fromJson(Map<String, dynamic> json){ 
        return DeliveryChargeModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<DeliveryChargeItemModel>.from(json["data"]!.map((x) => DeliveryChargeItemModel.fromJson(x))),
        );
    }

}

class DeliveryChargeItemModel {
    DeliveryChargeItemModel({
        required this.id,
        required this.type,
        required this.charge,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? type;
    final int? charge;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory DeliveryChargeItemModel.fromJson(Map<String, dynamic> json){ 
        return DeliveryChargeItemModel(
            id: json["_id"],
            type: json["type"],
            charge: json["charge"],
            isDeleted: json["isDeleted"],
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
