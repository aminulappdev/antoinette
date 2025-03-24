
import 'package:antoinette/app/modules/authentication/model/otp_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class ResendOTPController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<bool> resendOTP(String email) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {"email": email};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.resendOTP, requestBody);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      final otpModel =
          OtpModel.fromJson(response.responseData);
      _accessToken = otpModel.data?.token;

     
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
