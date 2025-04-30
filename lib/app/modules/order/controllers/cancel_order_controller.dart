import 'package:antoinette/app/urls.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class CancelOrderController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> cancelOrder(String orderId) async {
    bool isSuccess = false;

    _inProgress = true; 

    update();


    final NetworkResponse response =
        await Get.find<NetworkCaller>().deleteRequest(Urls.cancelOrderById(orderId));

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
