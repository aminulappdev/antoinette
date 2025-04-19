import 'package:antoinette/app/modules/order/model/order_details_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  OrderDetailsModel? orderDetailsModel;
  OrderDetailsData? get orderDetailsData => orderDetailsModel?.data;

  int? lastPage;

  Future<bool> getOrderDetails(String id) async {
 
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.orderDetailsById(id),
        accesToken: box.read('user-login-access-token'));

    orderDetailsModel = OrderDetailsModel.fromJson(response.responseData);

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
