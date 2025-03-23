class SignInModel {
  bool? success;
  int? statusCode;
  String? message;
  DataModel? data;

  SignInModel({this.success, this.statusCode, this.message, this.data});

  SignInModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
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

class DataModel {
  UserModel? user;
  OtpToken? otpToken;

  DataModel({this.user, this.otpToken});

  DataModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    otpToken = json['otpToken'] != null
        ? OtpToken.fromJson(json['otpToken'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (otpToken != null) {
      data['otpToken'] = otpToken!.toJson();
    }
    return data;
  }
}

class UserModel {
  String? sId;
  String? id;
  String? name;
  String? email;
  Null photoUrl;
  String? contactNumber;
  Null age;

  UserModel(
      {this.sId,
      this.id,
      this.name,
      this.email,
      this.photoUrl,
      this.contactNumber,
      this.age});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    contactNumber = json['contactNumber'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['contactNumber'] = contactNumber;
    data['age'] = age;
    return data;
  }
}

class OtpToken {
  String? token;

  OtpToken({this.token});

  OtpToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
