import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';


class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  String? addressFiled;

  Future<bool> updateProfile({
    String name = '',
    String number = '',
    String address = '',
    String addressIndex = '',
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {};

    if (address.isNotEmpty && addressIndex != -1) {
      if (addressIndex == 'Home') {
        addressFiled = 'homeAddress';
      } else if (addressIndex == 'Office') {
        addressFiled = 'officeAddress';
      } else if (addressIndex == 'Delivery') {
        addressFiled = 'deliveryAddress';
      }

      if (addressFiled != null) {
        requestBody[addressFiled!] = address;
      }
    } else {
      requestBody = {
        "name": name,
        "contractNo": number,
        
      };
    }

    final NetworkResponse response = await Get.find<NetworkCaller>().putRequest(
      Urls.updateProfileUrl,
      requestBody,
      accesToken: box.read('user-login-access-token'),
    );

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

