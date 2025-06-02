import 'package:antoinette/app/modules/product/model/all_product_pegination_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllProductController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  bool get initialInProgress => page == 1;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  List<AllProductItemModel> productsList = [];
  List<AllProductItemModel> get allProductList => productsList;

  var allProductsList = <AllProductItemModel>[].obs;

  final int _limit = 9999;
  int page = 0;
  int? lastPage;

  Future<bool> getProductList() async {
    if (_inProgress) {
      return false;
    }

    page++; // Increment page for pagination

    if (lastPage != null && page > lastPage!) {
      page--; // Revert page increment if exceeding last page
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    // Clear productsList only on the first page to prevent duplicates
    if (page == 1) {
      productsList.clear();
      allProductsList.clear();
    }

    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.allProductUrl,
      queryParams: queryparam,
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllProductPeginationModel allProductPeginationModel =
          AllProductPeginationModel.fromJson(response.responseData);
      productsList.addAll(allProductPeginationModel.data);
      allProductsList.addAll(allProductPeginationModel.data); // Sync with RxList

      if (allProductPeginationModel.meta?.totalPage != null) {
        lastPage = allProductPeginationModel.meta!.totalPage;
      }
    } else {
      _errorMessage = response.errorMessage;
      page--; // Revert page increment on failure
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  // Reset page and fetch products (for refresh or initial load)
  Future<bool> refreshProducts() async {
    page = 0; // Reset to page 0 so next getProductList starts at page 1
    return await getProductList();
  }

  Future<void> fetchAllProducts(String? sessionQuery) async {
    Map<String, dynamic> queryparam = {
      'limit': _limit,
      'page': 1, // Always fetch first page for search
      if (sessionQuery != null && sessionQuery.isNotEmpty) 'searchTerm': sessionQuery,
    };

    _inProgress = true;
    update();

    // Clear lists for search to avoid duplicates
    productsList.clear();
    allProductsList.clear();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.allProductUrl,
      queryParams: queryparam,
      accesToken: box.read('user-login-access-token'),
    );

    if (response.isSuccess) {
      _errorMessage = null;

      AllProductPeginationModel allProductPeginationModel =
          AllProductPeginationModel.fromJson(response.responseData);

      productsList.addAll(allProductPeginationModel.data);
      allProductsList.value = allProductPeginationModel.data; // Update RxList
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
  }

  void onSearchQueryChangedProducts(String sessionQuery) {
    fetchAllProducts(sessionQuery);
  }

  @override
  void onInit() {
    super.onInit();
    getProductList(); // Initial fetch
  }
}