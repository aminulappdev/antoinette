import 'package:antoinette/app/modules/authentication/model/sign_up_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _token;
  String? get token => _token;

  Future<bool> signUp(
      String name, String email, String password, String number) async {
    bool isSuccess = false;

    _inProgress = true; 

    update();

    Map<String, dynamic> requestBody = {
      "name": name,
      "email": email,
      "password": password,
      "contactNumber": number
    };

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.signUp, requestBody);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      
      final signInModel = SignInModel.fromJson(response.responseData);
      _token = signInModel.data?.otpToken?.token;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
