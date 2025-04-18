import 'package:antoinette/app/modules/bookmark/model/all_bookmark_podcast_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookmarkPodcastController extends GetxController {
  bool _inProgress = false; 
  bool get inProgress => _inProgress;

  bool get initialInProgress => page == 1;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  List<AllBookmarkPodcastItemModel> bookmarkPodcastsList = [];
  List<AllBookmarkPodcastItemModel> get bookmarkPodcastList => bookmarkPodcastsList;

  final int _limit = 4;
  int page = 0;
  String modeType = 'Podcast';

  int? lastPage;

  Future<bool> getbookmarkArticleList() async {
    if (_inProgress) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;

    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page, 'modeType' : modeType};

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.bookmarkArticleUrl,
        queryParams: queryparam,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllBookmarkPodcastModel allPodcastModel =
          AllBookmarkPodcastModel.fromJson(response.responseData);

      bookmarkPodcastsList.addAll(allPodcastModel.data ?? []);

      if (allPodcastModel.meta?.totalPage != null) {
        lastPage = allPodcastModel.meta!.totalPage;
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
