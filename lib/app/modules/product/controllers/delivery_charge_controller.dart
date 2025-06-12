// ✅ Fixed ProductOrderController

import 'package:antoinette/app/modules/product/model/delivery_charge_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class DeliveryChargeController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DeliveryChargeModel? deliveryChargeModel;
  List<DeliveryChargeItemModel>? get deliverChargeData => deliveryChargeModel?.data;

  Future<bool> deliveryCharge() async {
    _inProgress = true;
    update();

    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.deliverChargeUrl,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      deliveryChargeModel = DeliveryChargeModel.fromJson(response.responseData);
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
