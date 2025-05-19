import 'package:antoinette/app/modules/dear_diary/model/all_diary_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllDiariesController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  List<AllDiaryItemModel> diaryList = [];
  List<AllDiaryItemModel> get allDiaryList => diaryList;

  final int _limit = 9999;

  // Pagination state
  int page = 0;
  int? lastPage;

  // Fetch fresh diary list (used for real-time updates)
  Future<bool> getDiaryList({bool refresh = false}) async {
    // Prevent duplicate requests
    if (_inProgress) return false;

    // If refreshing, reset state
    if (refresh) {
      page = 0;
      lastPage = null;
      diaryList.clear();
    }

    // Increment page for new fetch
    page++;

    // Prevent over-fetching
    if (lastPage != null && page > lastPage!) return false;

    _inProgress = true;
    update(); // Notifies listeners (UI)

    bool isSuccess = false;
    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};

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

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllDiaryModel allDiaryModel = AllDiaryModel.fromJson(response.responseData);
      diaryList.addAll(allDiaryModel.data ?? []);

      if (allDiaryModel.meta?.totalPage != null) {
        lastPage = allDiaryModel.meta!.totalPage;
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
