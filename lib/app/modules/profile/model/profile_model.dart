class ProfileModel {
  bool? success;
  int? statusCode;
  String? message;
  ProfileData? data;

  ProfileModel({this.success, this.statusCode, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? sId;
  String? name;
  String? email;
  String? contactNumber;
  String? homeAddress;
  String? officeAddress;
  String? deliveryAddress;
  String? photoUrl;
  String? age;
  String? status;
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isStudent; // ✅ New field added

  ProfileData({
    this.sId,
    this.name,
    this.email,
    this.contactNumber,
    this.homeAddress,
    this.officeAddress,
    this.deliveryAddress,
    this.photoUrl,
    this.age,
    this.status,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isStudent, // ✅ Include in constructor
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contactNumber'];
    homeAddress = json['homeAddress'];
    officeAddress = json['officeAddress'];
    deliveryAddress = json['deliveryAddress'];
    photoUrl = json['photoUrl'];
    age = json['age'];
    status = json['status'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isStudent = json['isStudent']; // ✅ Parse from JSON
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['contactNumber'] = contactNumber;
    data['homeAddress'] = homeAddress;
    data['officeAddress'] = officeAddress;
    data['deliveryAddress'] = deliveryAddress;
    data['photoUrl'] = photoUrl;
    data['age'] = age;
    data['status'] = status;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isStudent'] = isStudent; // ✅ Include in toJson
    return data;
  }
}
