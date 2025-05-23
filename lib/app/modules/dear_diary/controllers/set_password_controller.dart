import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class SetJournalPasswordController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> setJournalPassword(String password) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {"key": password};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.setJournalKeyUrl, requestBody,
            accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      // Store that password is set in GetStorage
      box.write('isJournalPasswordSet', true);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> isPasswordSet() async {
    // Check if password is set from GetStorage
    return box.read('isJournalPasswordSet') ?? false;
  }
}