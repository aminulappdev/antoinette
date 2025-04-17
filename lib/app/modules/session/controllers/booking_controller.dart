import 'package:antoinette/app/modules/session/model/session_booking_respomse_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  SessionBookingResponseModel? sessionBookingResponseModel;
  List<SessionBookingResponseItemModel>? get sessionBookingResponseData => sessionBookingResponseModel?.data;

  Future<bool> bookingSession(String user, String sessionId, String slotId, String therapyType, String mood) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
    "user": user,
    "session": sessionId,
    "slot": slotId,
    "therapyType" : therapyType,
    "emotionState" : mood
};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.bookingSessionUrl, requestBody, accesToken: box.read('user-login-access-token'));

        sessionBookingResponseModel = SessionBookingResponseModel.fromJson(response.responseData);

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
