import 'package:antoinette/app/modules/dear_diary/model/all_diary_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AllDiariesController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  List<AllDiaryItemModel> diaryList = [];
  List<AllDiaryItemModel> get allDiaryList => diaryList;

  final int _limit = 10;
  int page = 0;

  int? lastPage;

  Future<bool> getDiaryList() async {
    // Early return if already in progress
    if (_inProgress) {
      return false;
    }

    // Increment page for pagination
    page++;

    // Prevent fetching if the last page is reached
    if (lastPage != null && page > lastPage!) return false;

    // Start loading indicator
    _inProgress = true;
    update(); // Ensure UI gets updated on inProgress change

    bool isSuccess = false;
    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};

    // Fetch access token and make sure it is valid
    _accessToken = box.read('user-login-access-token');
    if (_accessToken == null) {
      _inProgress = false;
      update();
      return false;
    }

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.allDiarydUrl,
      queryParams: queryparam,
      accesToken: _accessToken,
    );

    // Handle the response
    if (response.isSuccess) {
      _errorMessage = null;  // Reset error message on success
      isSuccess = true;

      AllDiaryModel allDiaryModel = AllDiaryModel.fromJson(response.responseData);
      diaryList.addAll(allDiaryModel.data ?? []); // Add new diaries

      // Update pagination state
      if (allDiaryModel.meta?.totalPage != null) {
        lastPage = allDiaryModel.meta!.totalPage;
      }
    } else {
      _errorMessage = response.errorMessage; // Set the error message if any
    }

    // End loading indicator
    _inProgress = false;
    update(); // Ensure UI updates after request completes

    return isSuccess;
  }
}
