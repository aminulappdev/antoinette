import 'package:antoinette/app/urls.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<bool> resetPassword(
      String email, String password, String confirmPassword, String token) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "newPassword": password,
      "confirmPassword": confirmPassword
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.resetPassword, requestBody, accesToken: token);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

     
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
