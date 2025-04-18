import 'package:antoinette/app/modules/bookmark/model/bookmark_article_details_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookmarkArticleDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken; 
  String? get accessToken => _accessToken;
 
  BookmarkArticleDetalsModel? articlesDetailsModel;
  BookmarkArticleDetailsItemModel? get bookmarkArticleModel => articlesDetailsModel?.data;

  int? lastPage;

  Future<bool> getBookmarkArticleDetails(String id) async {
   
    bool isSuccess = false; 

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.bookmarkContentUrlsById(id), accesToken: box.read('user-login-access-token'));
   
    print('response data is : ${response.responseData}');

    articlesDetailsModel = BookmarkArticleDetalsModel.fromJson(response.responseData);
   

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
