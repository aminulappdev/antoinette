import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_podcast_controller.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookMarkController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
 
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addBookmark(String user, String reference, String modeType) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "user": user,
      "reference": reference,
      "modeType": modeType // 'Article' or 'Podcast'
    };

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      Urls.bookmarkUrl,
      requestBody,
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      // Notify BookmarkArticlesController to refresh the list
      if (modeType == 'Article') {
        final BookmarkArticlesController articlesController = Get.find<BookmarkArticlesController>();
        await articlesController.refreshBookmarkList();
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}