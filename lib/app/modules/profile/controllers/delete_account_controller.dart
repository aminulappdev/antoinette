import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteProfile(String myUserId) async {
    bool isSuccess = false;

    _inProgress = true;

    update();
    print('Access token : ${box.read('user-login-access-token')}');
    final NetworkResponse response = await Get.find<NetworkCaller>().deleteRequest(
        Urls.deleteUserById(myUserId),
        accesToken: box.read('user-login-access-token'));

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
