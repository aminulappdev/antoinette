import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<bool> bookingSession(String user, String sessionId, String slotId) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
    "user": user,
    "session": sessionId,
    "slot": slotId
};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.bookingSessionUrl, requestBody, accesToken: box.read('ser-login-access-token'));

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
