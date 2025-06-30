import 'package:antoinette/app/modules/payment/model/my_subscription_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class MySubscriptionController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MySubscriptionModel? mySubscriptionModel;
  List<MySubscriptionItemModel>? get subscriptionData =>
      mySubscriptionModel?.data;

  // Check if user has an active subscription for a specific billing cycle
  bool hasActiveSubscription(String billingCycle) {
    if (subscriptionData == null || subscriptionData!.isEmpty) {
      return false;
    }
    return subscriptionData!.any(
      (subscription) =>
          subscription.paymentStatus == "paid" &&
          subscription.status == "confirmed" &&
          subscription.package?.billingCycle.toLowerCase() ==
              billingCycle.toLowerCase() &&
          subscription.expiredAt.isAfter(DateTime.now()) &&
          !subscription.isExpired &&
          !subscription.isDeleted,
    );
  }

  Future<bool> getMySubscriptions() async {
    _inProgress = true;
    update();

    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.mySubscriptionUrl,
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess && response.responseData != null) {
      mySubscriptionModel = MySubscriptionModel.fromJson(response.responseData);
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
