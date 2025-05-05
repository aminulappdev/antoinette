import 'package:antoinette/app/modules/authentication/model/login_model.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:antoinette/services/network_caller/network_response.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _token;
  String? get token => _token;

  Future<bool> signInWithGoogle() async {
    _inProgress = true;
    update();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _errorMessage = "Google sign-in was cancelled";
        _inProgress = false;
        update();
        return false;
      }

      final Map<String, dynamic> requestBody = {
        "name": googleUser.displayName ?? "User",
        "email": googleUser.email,
        "password": "user123",
        "contactNumber": "+1987654321",
        "token": googleUser.id
      };

      final NetworkResponse response = await Get.find<NetworkCaller>()
          .postRequest(Urls.googleAuth, requestBody);

      if (response.isSuccess) {
        _errorMessage = null;

        final loginModel = LoginModel.fromJson(response.responseData);
        _token = loginModel.data!.accessToken;
        box.write('user-login-access-token', _token);

        // Redirect to main page
        Future.delayed(Duration.zero, () {
          Get.offAllNamed(MainButtonNavbarScreen.routeName);
        });

        _inProgress = false;
        update();
        return true;
      } else {
        if (response.errorMessage.contains('credentials') == true) {
          await _googleSignIn.signOut(); // allow switching account
        }

        _errorMessage = response.errorMessage;
        _inProgress = false;
        update();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _inProgress = false;
      update();
      return false;
    }
  }
}
