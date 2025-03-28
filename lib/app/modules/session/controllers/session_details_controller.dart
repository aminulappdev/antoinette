import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class SessionDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken; 
  String? get accessToken => _accessToken;

  SessionDetailsModel? sessionDetailsModel;
  SessionDataModel? get sessionModel => sessionDetailsModel?.data;


  int? lastPage;

  Future<bool> getSessionDetails(String id) async {
    // if (_inProgress) {
    //   return false;
    // }

    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.sessionUrlsById(id), accesToken: box.read('user-login-access-token'));
   
    // print('response data is : ${response.responseData}');

    sessionDetailsModel = SessionDetailsModel.fromJson(response.responseData);
    // print('my id is : $id\nmy data is ${SessionDetailsModel.fromJson(response.responseData).data?.description}');

    if (response.isSuccess) {
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
