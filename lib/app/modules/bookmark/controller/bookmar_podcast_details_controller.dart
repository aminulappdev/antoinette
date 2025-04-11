import 'package:antoinette/app/modules/bookmark/model/bookmark_podcast_details_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookmarkPodcastDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  BookmarkPodcastDetailsModel? bookmarkPodcastDetailsModel;
  BookmarkPodcastDetailsItemModel? get bookmarkPodcastModel => bookmarkPodcastDetailsModel?.data;

  int? lastPage;

  Future<bool> getBookmarkPodcastDetails(String id) async {
   
    bool isSuccess = false; 

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.bookmarkContentUrlsById(id), accesToken: box.read('user-login-access-token'));
   
    print('response data is : ${response.responseData}');

    bookmarkPodcastDetailsModel = BookmarkPodcastDetailsModel.fromJson(response.responseData);
    print('my id is : $id\nmy data is ${BookmarkPodcastDetailsModel.fromJson(response.responseData).data?.reference?.title}');

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
