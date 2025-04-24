import 'package:antoinette/app/modules/session/model/session_booking_respomse_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class RescheduleBookingController extends GetxController {
  bool _inProgress = false; 
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  SessionBookingResponseModel? sessionBookingResponseModel;
  SessionBookingResponseItemModel? get sessionBookingResponseData =>
      sessionBookingResponseModel?.data;

  Future<bool> bookingSession(String bookingId, String slotId) async {
    bool isSuccess = false;

    _inProgress = true;

    update();
 
    Map<String, dynamic> requestBody = {
      "slot": slotId,
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .putRequest(Urls.rescheduleBookingById(bookingId), requestBody,
            accesToken: box.read('user-login-access-token'));

    // sessionBookingResponseModel =
    //     SessionBookingResponseModel.fromJson(response.responseData);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      // final message = response.responseData?['message'] ?? 'Something went wrong';
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
