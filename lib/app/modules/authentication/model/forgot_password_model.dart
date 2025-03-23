class ForgotPasswordModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ForgotPasswordModel({this.success, this.statusCode, this.message, this.data});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? verifyToken;

  Data({this.verifyToken});

  Data.fromJson(Map<String, dynamic> json) {
    verifyToken = json['verifyToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verifyToken'] = verifyToken;
    return data;
  }
}
