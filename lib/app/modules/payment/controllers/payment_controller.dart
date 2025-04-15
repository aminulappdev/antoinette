import 'package:antoinette/app/urls.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<bool> getPayment(String modelType, String userId, String refereneId) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
    "modelType": modelType, // here modelType: Booking | Subscription | Order
    "account": userId,
    "reference": refereneId
};

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.signIn, requestBody);

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
