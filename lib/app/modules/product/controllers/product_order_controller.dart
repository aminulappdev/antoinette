// ✅ Fixed ProductOrderController

import 'package:antoinette/app/modules/product/model/order_response_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class ProductOrderController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  OrderResponseModel? orderResponseModel;
  OrderResponseItemModel? get orderResponseData => orderResponseModel?.data;

  Future<bool> orderProduct(
    String productId,
    int quantity,
    double price,
    double totalPrice,
    String discount,
    String userId,
    double amount,
    String deliveryCharge,
    String billingName,
    String pickupDate,
    String address,
    String phoneNumber,
    String email,
  ) async {
    _inProgress = true;
    update();

    bool isSuccess = false;

    Map<String, dynamic> requestBody = {
      "items": [
        {
          "product": productId,
          "quantity": quantity,
          "price": price.toInt(),
          "totalPrice": totalPrice.toInt(),
          "discount": discount
        }
      ],
      "orderData": {
        "user": userId,
        "amount": amount.toInt(),
        "deliveryCharge": deliveryCharge,
        "billingDetails": {
          "name": billingName,
          "pickupDate": pickupDate,
          "address": address,
          "phoneNumber": phoneNumber,
          "email": email
        }
      }
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.orderProductUrl, requestBody);

    if (response.isSuccess) {
      orderResponseModel = OrderResponseModel.fromJson(response.responseData);
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
