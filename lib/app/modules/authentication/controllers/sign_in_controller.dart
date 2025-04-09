import 'package:antoinette/app/modules/authentication/model/login_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
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
      "email": email,
      "password": password
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.signIn, requestBody);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

     final  loginModel = LoginModel.fromJson(response.responseData);
     box.write('user-login-access-token', loginModel.data!.accessToken);
   

     print(loginModel.data!.accessToken);

    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
} 
