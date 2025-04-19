import 'package:antoinette/app/modules/common/model/all_notification_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllNotificationController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  bool get initialInProgress => page == 1;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  List<AllNotificationItemModel> notificationList = [];
  List<AllNotificationItemModel> get allNotification => notificationList;

  final int _limit = 10;
  int page = 0;

  int? lastPage;

  Future<bool> getNotificationList() async {
    if (_inProgress) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;

    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allNotificationUrl,
        queryParams: queryparam,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllNotificationModel allNotificationModel =
          AllNotificationModel.fromJson(response.responseData);
      notificationList.addAll(allNotificationModel.data ?? []);

      if (allNotificationModel.meta?.totalPage != null) {
        lastPage = allNotificationModel.meta!.totalPage;
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
