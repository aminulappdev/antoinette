import 'package:antoinette/app/urls.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "email": "emonhasan7650@gmail.com",
      "password": "user123"
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.signIn, requestBody);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      // final signInModel = SignInModel.fromJson(response.responseData);
      // _token = signInModel.data?.otpToken?.token;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
} 
