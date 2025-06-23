import 'package:antoinette/app/modules/bookmark/model/all_bookmark_article_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class BookmarkArticlesController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  bool get initialInProgress => page == 1;

  final RxString _errorMessage = RxString('');
  String? get errorMessage => _errorMessage.value;

  final RxString _accessToken = RxString('');
  String? get accessToken => _accessToken.value;

  final RxList<AllBookmarkArticleItemModel> _bookmarkArticlesList =
      <AllBookmarkArticleItemModel>[].obs;
  List<AllBookmarkArticleItemModel> get bookmarkArticleList =>
      _bookmarkArticlesList;

  final int _limit = 9999;
  int page = 0;
  String modeType = 'Article';
  int? lastPage;

  @override
  void onInit() {
    super.onInit();

    if (box.read('user-login-access-token') == null) {
// Navigator.push(
//   Get.context!,
//   MaterialPageRoute(
//     builder: (context) => const SignInScreen(),
//   ),
// );
      print(
          "///////////////////////////////////////////////////////////////////");
    } else {
      _accessToken.value = box.read('user-login-access-token');
    }
  }

  Future<bool> getbookmarkArticleList() async {
    if (_inProgress.value) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;

    bool isSuccess = false;
    _inProgress.value = true;

    Map<String, dynamic> queryparam = {
      'limit': _limit,
      'page': page,
      'modeType': modeType
    };

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.bookmarkArticleUrl,
      queryParams: queryparam,
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess) {
      _errorMessage.value = '';
      isSuccess = true;

      AllBookmarkArticleModel allArticlesModel =
          AllBookmarkArticleModel.fromJson(response.responseData);
      _bookmarkArticlesList.addAll(allArticlesModel.data ?? []);

      if (allArticlesModel.meta?.totalPage != null) {
        lastPage = allArticlesModel.meta!.totalPage;
      }
    } else {
      _errorMessage.value = response.errorMessage;
    }

    _inProgress.value = false;
    return isSuccess;
  }

  Future<bool> refreshBookmarkList() async {
    page = 0;
    _bookmarkArticlesList.clear();
    lastPage = null;
    return await getbookmarkArticleList();
  }
}
