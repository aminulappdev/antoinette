import 'package:antoinette/app/modules/authentication/controllers/forgot_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_in_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/verify_otp_controller.dart';
import 'package:antoinette/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(NetworkCaller());
    Get.put(VerifyOtpController());
    Get.put(SignInController());
    Get.put(ForgotPasswordController());
    Get.put(ResendOTPController());
    Get.put(ResetPasswordController());
  
    
  }
 
}