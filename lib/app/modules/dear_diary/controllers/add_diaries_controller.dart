import 'package:antoinette/app/modules/dear_diary/controllers/all_diaries_controller.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AddDiariesController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addDiaries(String userId, String date, String time,
      String description, String feeling) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "user": userId,
      "date": date,
      "time": time,
      "description": description,
      "feelings": feeling,
      "themeMode": "Light Mode"
    };

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      Urls.addDiariesUrl,
      requestBody,
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      // Refresh diary list in real time
      Get.find<AllDiariesController>().getDiaryList();
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
