import 'package:antoinette/app/modules/letters/model/article_details_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class ArticleDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  ArticlesDetailsModel? articlesDetailsModel;

  ArticleModel? get articleModel => articlesDetailsModel?.data;

  int? lastPage;

  Future<bool> getArticleDetails(String id) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.articleUrlsById(id),
        accesToken: box.read('user-login-access-token'));

    print('response data is : ${response.responseData}');

    if (response.isSuccess && response.responseData != null) {
      articlesDetailsModel =
          ArticlesDetailsModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      if (response.errorMessage.contains("Access denied!") == true) {
        _errorMessage =
            'Access denied! Your free trial has expired. Please subscribe.';
        print('Access denied!');
      }
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
