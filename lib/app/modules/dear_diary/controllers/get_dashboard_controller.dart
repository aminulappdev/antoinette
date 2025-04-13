import 'package:antoinette/app/modules/dear_diary/model/dashboard_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class GetDashboardController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DashboardModel? dashboardModel;
  DashboardItemModel? get dashboardData => dashboardModel?.data;

  Future<bool> getDashboard(String date) async {
    Map<String, dynamic> queryparam = {'searchTerm': date};
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.dashboardUrl,
            accesToken: box.read('user-login-access-token'), queryParams: queryparam);

    dashboardModel = DashboardModel.fromJson(response.responseData);

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
