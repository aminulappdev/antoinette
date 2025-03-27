import 'package:antoinette/app/modules/authentication/model/login_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class FacebookAuthController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _token;
  String? get token => _token;

  Future<bool> signInWithFacebook() async {
    _inProgress = true;
    update();

    try {
      final LoginResult result = await FacebookAuth.instance.login();

      // Check if login was successful
      if (result.status != LoginStatus.success) {
        _errorMessage = "Facebook sign-in was cancelled or failed";
        _inProgress = false;
        update();
        return false;
      }

      // Retrieve the token from the AccessToken
      final accessToken = result.accessToken;

      if (accessToken == null ) {
        _errorMessage = "No access token received";
        _inProgress = false;
        update();
        return false;
      }

      // Get user details from Facebook
      final userData = await FacebookAuth.instance.getUserData();

      final Map<String, dynamic> requestBody = {
        "name": userData['name'] ?? "User",
        "email": userData['email'] ?? "",
        "password": "user123", // fallback for backend
        "contactNumber": "+1987654321", // hardcoded for now
        "token": accessToken,
      };

      // Send the token and user data to your backend for further authentication
      final NetworkResponse response = await Get.find<NetworkCaller>()
          .postRequest(Urls.facebookAuth, requestBody);

      if (response.isSuccess) {
        _errorMessage = null;
        _inProgress = false;

        final loginModel = LoginModel.fromJson(response.responseData);
        box.write('user-login-access-token', loginModel.data!.accessToken);
        print(loginModel.data!.accessToken);

        update();
        return true;
      } else {
        _errorMessage = response.errorMessage;
        _inProgress = false;
        update();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _inProgress = false;
      update();
      return false;
    }
  }
}
