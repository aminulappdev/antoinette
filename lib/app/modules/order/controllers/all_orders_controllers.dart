import 'package:antoinette/app/modules/order/model/all_order_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllOrderController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  AllOrderModel? allOrderModel;
  List<AllOrderItemModel>? get ordersData => allOrderModel?.data;

  int? lastPage;

  Future<bool> getOrderList() async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allOrderUrl,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      allOrderModel = AllOrderModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
