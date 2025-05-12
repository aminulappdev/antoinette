import 'dart:convert';
import 'dart:io';
import 'package:antoinette/app/modules/authentication/model/sign_up_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';

class StudentSignUpController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _token;
  String? get token => _token;

  String? addressFiled;

  /// 🔁 Student Sign Up Function
  Future<bool> studentSignUp(
    String? name,
    String? email,
    String? password,
    String? number,
    File? image,
  ) async {
    print('Image ache ................................');
    print(image?.path);

    bool isSuccess = false;
    _inProgress = true;
    update();
    print('problem bahire');
    try {
      print('try te dukche');
     
      
      print('Acces token ');
      var uri = Uri.parse(Urls.studentSignUpUrl);
      var request = http.MultipartRequest('POST', uri);


      // ✅ Set 'data' field with JSON-encoded string
      Map<String, dynamic> jsonFields = {
        "name": name,
        "email": email,
        "password": password,
        "contactNumber": number
      };

      request.fields['data'] = jsonEncode(jsonFields);

      print('data asche');

      // ✅ Add image if available
      if (image != null) {
        print('Image is here, processing...');
        String imagePath = image.path;
        String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

        request.files.add(
          await http.MultipartFile.fromPath(
            'documents', // 🔑 Backend should expect this key
            imagePath,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      // 📡 Send request
      var streamedResponse = await request.send();
      var responseBody = await streamedResponse.stream.bytesToString();

      print('📥 Server Response: $responseBody');

      var decodedResponse = jsonDecode(responseBody);

      if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
        print('Success');


        _errorMessage = null;
        isSuccess = true;

        final signInModel = SignInModel.fromJson(decodedResponse);
        _token = signInModel.data?.otpToken?.token;
      } else {
        _errorMessage = decodedResponse['message'] ?? "Failed to sign up";
      }
    } catch (e) {
       print('problem');
      _errorMessage = "Error signing up: $e";
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }
}
