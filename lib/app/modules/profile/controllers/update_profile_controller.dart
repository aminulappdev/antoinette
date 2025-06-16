import 'dart:convert';
import 'dart:io';

import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  String? addressFiled;

  final ProfileController profileController = Get.find<ProfileController>();

  /// 🔁 Update Profile Function
  Future<bool> updateProfile({
    bool? isNameUpdate,
    String? addressIndex,
    String? name,
    String? number,
    String? address,
    File? image,
  }) async {
    print('Image ache ?? ................................');
    print('$address');
    print(image);
    print(addressIndex);
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      String? token = box.read('user-login-access-token');
      if (token == null || token.isEmpty) {
        _errorMessage = "User not authenticated";
        _inProgress = false;
        update();
        return false;
      }

      var uri = Uri.parse(Urls.updateProfileUrl);
      var request = http.MultipartRequest('PUT', uri);

      // ✅ Only Authorization header
      request.headers['Authorization'] = token;

      // ✅ Set 'data' field with JSON-encoded string
      Map<String, dynamic> jsonFields = {
        "name": isNameUpdate == true ? name : profileController.profileData?.name ?? name,
        "contactNumber": number,
      };

      if (address != null && address.isNotEmpty) {
        if(addressIndex == 'Home'){
              jsonFields['homeAddress'] = address;
        }
        else if(addressIndex == 'Office'){
           jsonFields['officeAddress'] = address;
        }
        else if(addressIndex == 'Delivery'){
           jsonFields['deliveryAddress'] = address;
        }
       
      }
      

      request.fields['data'] = jsonEncode(jsonFields);

      // ✅ Add image if available
      if (image != null) {
        print('Image ache ekhane ................................');
        print(image);
        String imagePath = image.path;
        String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
 
        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // 🔑 Backend should expect this key
            imagePath,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      // 📡 Send request
      var streamedResponse = await request.send();
      var responseBody = await streamedResponse.stream.bytesToString();

      print('📥 Server Response:');
      print(responseBody);

      var decodedResponse = jsonDecode(responseBody);

      if (streamedResponse.statusCode == 200) {
         print('response data is : ${decodedResponse}');
        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage = decodedResponse['message'] ?? "Failed to update profile";
      }
    } catch (e) {
      _errorMessage = "Error updating profile: $e";
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }
}
