// import 'package:antoinette/app/urls.dart';
// import 'package:antoinette/app/utils/get_storage.dart';
// import 'package:antoinette/services/network_caller/network_caller.dart';
// import 'package:antoinette/services/network_caller/network_response.dart';
// import 'package:get/get.dart';

// class UpdateContactController extends GetxController {
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;


//   Future<bool> addContact(String name, String number) async {
//     bool isSuccess = false;

//     _inProgress = true;

//     update();

//     Map<String, dynamic> requestBody = {
//       "user": '67dfad3574eb1ff506ea4f82',
//       "name": name,
//       "contractNumber": number
//     };

//     final NetworkResponse response = await Get.find<NetworkCaller>()
//         .postRequest(Urls.addContactUrl, requestBody,
//             accesToken: box.read('user-login-access-token'));

//     if (response.isSuccess) {
//       _errorMessage = null;
//       isSuccess = true;
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();
//     return isSuccess;
//   }
// }
