import 'package:antoinette/app/modules/payment/model/payment_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelSubscriptionController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> cancelSubscription(String subId, BuildContext context) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.cancelSubscriptionById(subId),
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
       print('Successfully hoye geche ');
       showSnackBarMessage(context, "Cancellation successful");
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
