import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  String? addressFiled;

  // Method to update profile with image and other details
  Future<bool> updateProfile({
    String name = '',
    String number = '',
    File? image,  String? address,  String? addressIndex, // Image file parameter
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      'name': name,
      'contractNo': number,
    };

    // Add image file to request body if available
    if (image != null) {
      print('Image can\'t null .............');
      String? mimeType = lookupMimeType(image.path); // Use the mime package's lookupMimeType function
      var imageFile = await http.MultipartFile.fromPath(
        'image', // Field name in the backend
        image.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );

      // Adding image to the request body
      requestBody['image'] = imageFile;
    }

    // Send the request using the NetworkCaller
    final NetworkResponse response = await Get.find<NetworkCaller>().putRequest(
      Urls.updateProfileUrl,
      requestBody,
      accesToken: box.read('user-login-access-token'), // Access token for authorization
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    // End the progress indicator
    _inProgress = false;
    update();

    return isSuccess;
  }
}
