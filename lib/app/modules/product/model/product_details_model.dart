class ProductDetailsModel {
    ProductDetailsModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final ProductModel? data;

    factory ProductDetailsModel.fromJson(Map<String, dynamic> json){ 
        return ProductDetailsModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? null : ProductModel.fromJson(json["data"]),
        );
    }

}

class ProductModel {
    ProductModel({
        required this.id,
        required this.name,
        required this.images,
        required this.description,
        required this.category,
        required this.quantity,
        required this.sold,
        required this.amount,
        required this.discount,
        required this.faq,
        required this.restockAlert,
        required this.isStock,
        required this.size,
        required this.storeAddress,
        required this.warrantyPolicy,
        required this.returnAndRefundPolicy,
        required this.replacementPolicy,
        required this.isDeleted,
        required this.dataId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? name;
    final List<Images> images;
    final String? description;
    final Category? category;
    final int? quantity;
    final int? sold;
    final double? amount;
    final int? discount;
    final String? faq;
    final bool? restockAlert;
    final bool? isStock;
    final String? size;
    final String? storeAddress;
    final String? warrantyPolicy;
    final String? returnAndRefundPolicy;
    final String? replacementPolicy;
    final bool? isDeleted;
    final String? dataId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ProductModel.fromJson(Map<String, dynamic> json){ 
        return ProductModel(
            id: json["_id"],
            name: json["name"],
            images: json["images"] == null ? [] : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
            description: json["description"],
            category: json["category"] == null ? null : Category.fromJson(json["category"]),
            quantity: json["quantity"],
            sold: json["sold"],
            amount: json["amount"],
            discount: json["discount"],
            faq: json["faq"],
            restockAlert: json["restockAlert"],
            isStock: json["isStock"],
            size: json["size"],
            storeAddress: json["storeAddress"],
            warrantyPolicy: json["warrantyPolicy"],
            returnAndRefundPolicy: json["returnAndRefundPolicy"],
            replacementPolicy: json["replacementPolicy"],
            isDeleted: json["isDeleted"],
            dataId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Category {
    Category({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? title;
    final String? thumbnail;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            id: json["_id"],
            title: json["title"],
            thumbnail: json["thumbnail"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Images {
    Images({
        required this.key,
        required this.url,
        required this.id,
    });

    final String? key;
    final String? url;
    final String? id;

    factory Images.fromJson(Map<String, dynamic> json){ 
        return Images(
            key: json["key"],
            url: json["url"],
            id: json["_id"],
        );
    }

}
