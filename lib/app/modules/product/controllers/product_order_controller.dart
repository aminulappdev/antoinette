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

  Future<bool> orderProduct({
    required String productId,
    required int quantity,
    required dynamic price,
    required double totalPrice,
    required String discount,
    required String userId,
    required dynamic amount,
    required dynamic deliveryCharge,
    required String billingName,
    required String streetAddress,
    required String phoneNumber,
    required String apartment,
    required String town,
    required String state,
    required String country,
    required String note,
  }) async {
    _inProgress = true;
    update();

    bool isSuccess = false;

    Map<String, dynamic> requestBody = {
      "items": [
        {
          "product": productId, // add productID
          "quantity": quantity,
          "price": price, // calculate form frontent
          "totalPrice":
              totalPrice, // calculate form frontent total product price
          "discount": discount
        }
      ],
      "orderData": {
        "user": userId, // add userId
        "amount": totalPrice, // calculate form frontend
        "deliveryCharge": deliveryCharge,
        // billing details sent form frontend
        "billingDetails": {
          "name": billingName,
          "phoneNumber": phoneNumber,
          "streetAddress": streetAddress,
          "apartment": apartment,
          "town": town,
          "state": state,
          "note": note
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
