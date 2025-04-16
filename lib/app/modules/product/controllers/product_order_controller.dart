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

  // OrderResponseModel? orderResponseModel;
  // OrderResponseItemModel? get orderResponseData => orderResponseModel?.data;
 
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
      String adress,
      String phoneNumber,
      String email) async {
    bool isSuccess = false;

    _inProgress = true;

    update();
   
    Map<String, dynamic> requestBody = {
      "items": [
        {
          "product": productId, // add productID
          "quantity": quantity,
          "price": double.parse(price.toStringAsFixed(2)), // calculate form frontent
          "totalPrice":
              double.parse(totalPrice.toStringAsFixed(2)), // calculate form frontent total product price
          "discount": discount
        }
      ],
      "orderData": {
        "user": userId, // add userId
        "amount": double.parse(amount.toStringAsFixed(2)), // calculate form frontend
        "deliveryCharge": deliveryCharge,
        // billing details sent form frontend
        "billingDetails": {
          "name": billingName,
          "pickupDate": pickupDate,
          "address": adress,
          "phoneNumber": phoneNumber,
          "email": email
        }
      }
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.orderProductUrl, requestBody);

    print('Order response data ...................');
    print(response.responseData);

    orderResponseModel = OrderResponseModel.fromJson(response.responseData);
    print('Order model data ...................');
    print(orderResponseModel);

    // orderResponseModel = OrderResponseModel.fromJson(response.responseData);

    // print('Order details ...................');
    // print(orderResponseData?.user?.name);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.responseData;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
