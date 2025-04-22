import 'package:antoinette/app/modules/product/model/all_product_pegination_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class AllProcuctController extends GetxController {
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

  final int _limit = 20;
  int page = 0;

  int? lastPage;

  

  Future<bool> getProductList() async {
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
        Urls.allProductUrl,
        queryParams: queryparam,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllProductPeginationModel allProductPeginationModel =
          AllProductPeginationModel.fromJson(response.responseData);
      productsList.addAll(allProductPeginationModel.data);
      
      if (allProductPeginationModel.meta?.totalPage != null) {
        lastPage = allProductPeginationModel.meta!.totalPage;
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts(null);
  }

  Future<void> fetchAllProducts(String? sessionQuery) async {   
    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page, 'searchTerm' : sessionQuery ?? ''};
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
       queryParams: queryparam,
        Urls.allProductUrl,
        accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;

      AllProductPeginationModel allProductPeginationModel =
          AllProductPeginationModel.fromJson(response.responseData);

      allProductsList.value = allProductPeginationModel.data;
    } else {
      _errorMessage = response.errorMessage;
    }
  }

  void onSearchQueryChangedSession(String sessionQuery) {
    fetchAllProducts(sessionQuery);
  }
}


