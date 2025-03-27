import 'package:antoinette/app/modules/product/model/product_details_model.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';

class ProcuctDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  ProductDetailsModel? productDetailsModel;

  ProductModel? get productModel => productDetailsModel?.data;

  final userAccessToken = box.read('user-access-token');
  int? lastPage;

  Future<bool> getProductDetails(String id) async {
    // if (_inProgress) {
    //   return false;
    // }

    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.productUrlsById(id), accesToken: userAccessToken);
   
    print('response data is : ${response.responseData}');

    productDetailsModel = ProductDetailsModel.fromJson(response.responseData);
    print('my id is : $id\nmy data is ${ProductDetailsModel.fromJson(response.responseData).data?.name}');

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
