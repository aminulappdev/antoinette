import 'package:antoinette/app/modules/bookmark/model/all_bookmark_podcast_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookmarkPodcastController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  bool get initialInProgress => page == 1;

  final RxString _errorMessage = RxString('');
  String? get errorMessage => _errorMessage.value;

  final RxString _accessToken = RxString('');
  String? get accessToken => _accessToken.value;

  final RxList<AllBookmarkPodcastItemModel> _bookmarkPodcastsList = <AllBookmarkPodcastItemModel>[].obs;
  List<AllBookmarkPodcastItemModel> get bookmarkPodcastList => _bookmarkPodcastsList;

  final int _limit = 9999;
  int page = 0;
  String modeType = 'Podcast';
  int? lastPage;


  @override
  void onInit() {
    super.onInit();
      
       if (box.read('user-login-access-token') == null) {
      print(
          "///////////////////////////////////////////////////////////////////");
    } else {
      _accessToken.value = box.read('user-login-access-token');
    }
     
  }

  Future<bool> getbookmarkPodcastList() async {
    if (_inProgress.value) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;

    bool isSuccess = false;
    _inProgress.value = true;

    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page, 'modeType': modeType};

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.bookmarkArticleUrl, // Assuming this URL also serves podcast bookmarks
      queryParams: queryparam,
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess) {
      _errorMessage.value = '';
      isSuccess = true;

      AllBookmarkPodcastModel allPodcastModel = AllBookmarkPodcastModel.fromJson(response.responseData);
      _bookmarkPodcastsList.addAll(allPodcastModel.data ?? []); // Update RxList

      if (allPodcastModel.meta?.totalPage != null) {
        lastPage = allPodcastModel.meta!.totalPage;
      }
    } else {
      _errorMessage.value = response.errorMessage;
    }

    _inProgress.value = false;
    return isSuccess;
  }

  Future<bool> refreshBookmarkList() async {
    page = 0; // Reset pagination
    _bookmarkPodcastsList.clear(); // Clear existing list
    lastPage = null; // Reset last page
    return await getbookmarkPodcastList(); // Fetch fresh list
  }
}