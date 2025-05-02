import 'package:antoinette/app/modules/history/model/payment_bt_booking_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class PaymentByBookingIDController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  PaymentByBookingIdModel? paymentByBookingIdModel;
  PaymentByBookingIdItemModel? get paymentData => paymentByBookingIdModel?.data;

  int? lastPage;

  Future<bool> getPaymentByBookingId(String id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.paymentByBookingId(id),
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess) {
      paymentByBookingIdModel =
          PaymentByBookingIdModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      paymentByBookingIdModel = null; // কোনো ভুল ডেটা সেট না হয়
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
