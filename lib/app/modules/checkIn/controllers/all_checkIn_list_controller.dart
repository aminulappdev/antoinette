import 'package:antoinette/app/modules/checkIn/model/all_check_in_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllCheckInController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

 

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;



  AllCheckInModel? _allCheckInModel;
  List<CheckInItemModel>? get checkInList => _allCheckInModel?.data;

  Future<bool> getCheckInList() async {
  
    bool isSuccess = false;

    _inProgress = true;

    update();

   
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allCheckInUrl,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;  
      
      _allCheckInModel = AllCheckInModel.fromJson(response.responseData);
      
    //  print('my data ${response.responseData}'); 
    //  print('my data ${_allContactModel!.data?[0].name}');
     print(checkInList?[0].sId);
      
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
