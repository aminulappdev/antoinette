import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_details_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/facebook_auth_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/forgot_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/google_auth_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_in_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/verify_otp_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_podcast_controller.dart';
import 'package:antoinette/app/modules/checkIn/controllers/add_checkIn_controller.dart';
import 'package:antoinette/app/modules/checkIn/controllers/all_checkIn_list_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/add_contact_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/all_contact_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/delete_contact_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/access_journal_key_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/add_diaries_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/change_password_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/get_dashboard_controller.dart';
import 'package:antoinette/app/modules/dear_diary/controllers/set_password_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/all_articles_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/all_podcast_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/poscast_details.dart';
import 'package:antoinette/app/modules/payment/controllers/all_package_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/subscription_controller.dart';
import 'package:antoinette/app/modules/product/controllers/all_product_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/article_details_controller.dart';
import 'package:antoinette/app/modules/product/controllers/product_details_controllers.dart';
import 'package:antoinette/app/modules/profile/controllers/content_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/update_profile_controller.dart';
import 'package:antoinette/app/modules/session/controllers/all_session_controller.dart';
import 'package:antoinette/app/modules/session/controllers/get_session_slotById_controller.dart';
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
    Get.put(ProfileController());
    Get.put(UpdateProfileController());
    Get.put(AddCheckInController());
    Get.put(AllCheckInController());
    Get.put(AllSessionSlotByIdController());
    Get.put(ContentController());
    Get.put(DeleteContactController());
    Get.put(BookMarkController());
    Get.put(BookmarkArticlesController());
    Get.put(BookmarkArticleDetailsController());
    Get.put(AddDiariesController());
    Get.put(SetJournalPasswordController());
    Get.put(ChangeJournalPasswordController());
    Get.put(AccessJournalPasswordController());
    Get.put(BookmarkPodcastController());
    Get.put(SubscriptionController());
    Get.put(AllPackageController());
    Get.put(GetDashboardController());

  
    
  }
 
}