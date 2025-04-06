import 'package:antoinette/app/modules/authentication/controllers/facebook_auth_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/forgot_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/google_auth_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_in_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/verify_otp_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/add_contact_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/all_contact_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/all_articles_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/all_podcast_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/poscast_details.dart';
import 'package:antoinette/app/modules/product/controllers/all_product_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/article_details_controller.dart';
import 'package:antoinette/app/modules/product/controllers/product_details_controllers.dart';
import 'package:antoinette/app/modules/session/controllers/all_session_controller.dart';
import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
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
    Get.put(GoogleAuthController());
    Get.put(AllProcuctController());
    Get.put(ProcuctDetailsController());
    Get.put(FacebookAuthController());
    Get.put(AllSessionController());
    Get.put(SessionDetailsController());
    Get.put(AllArticlesController());
    Get.put(ArticleDetailsController());
    Get.put(AllPodcastController());
    Get.put(PodcastDetailsController());
    Get.put(AddContactController());
    Get.put(AllContactController());

  
    
  }
 
}