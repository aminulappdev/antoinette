import 'package:antoinette/app/modules/checkIn/controllers/counter_controller.dart';
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

  String? _checkingId;
  String? get checkingId => _checkingId;

  AllCheckInModel? _allCheckInModel;
  List<CheckInItemModel>? get checkInList => _allCheckInModel?.data;


  final CountdownController countdownController = Get.put(CountdownController());
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
      print(response.responseData);
      final data = response.responseData['data'];

      if (data != null && data is List && data.isNotEmpty) {
        final firstId = data[0]['_id'];
        countdownController.checkinID = firstId;
        print('First Check-in ID: ${countdownController.checkinID}');
      }

      //  print('my data ${response.responseData}');
      //  print('my data ${_allContactModel!.data?[0].name}');
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
