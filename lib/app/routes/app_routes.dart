import 'package:antoinette/app/modules/checkin/views/check_in_screen.dart';
import 'package:antoinette/app/modules/bookmark/model/bookmark_article_details_model.dart';
import 'package:antoinette/app/modules/bookmark/model/bookmark_podcast_details_model.dart';
import 'package:antoinette/app/modules/bookmark/views/bookmark_article_details_page.dart';
import 'package:antoinette/app/modules/bookmark/views/bookmark_podcast_details_screen.dart';
import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/modules/common/views/notification_screen.dart';
import 'package:antoinette/app/modules/contact/views/edit_contact_screen.dart';
import 'package:antoinette/app/modules/dear_diary/views/change_password_screen.dart';
import 'package:antoinette/app/modules/dear_diary/views/edit_diary_screen.dart';
import 'package:antoinette/app/modules/dear_diary/views/set_password_screen.dart';
import 'package:antoinette/app/modules/history/views/reschedule_session.dart';
import 'package:antoinette/app/modules/letters/model/article_details_model.dart';
import 'package:antoinette/app/modules/letters/model/podcast_details_model.dart';
import 'package:antoinette/app/modules/letters/views/letter_screen.dart';
import 'package:antoinette/app/modules/letters/views/podcast_details.dart';
import 'package:antoinette/app/modules/checkIn/views/custom_status_screen.dart';
import 'package:antoinette/app/modules/common/views/panic_button_screen.dart';
import 'package:antoinette/app/modules/contact/views/add_contact_screen.dart';
import 'package:antoinette/app/modules/contact/views/contact_screen.dart';
import 'package:antoinette/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/otp_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/views/otp_screen.dart';
import 'package:antoinette/app/modules/authentication/views/reset_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_up_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/dear_diary/views/add_diary_screen.dart';
import 'package:antoinette/app/modules/dear_diary/views/dear_diary_screen.dart';
import 'package:antoinette/app/modules/history/views/history_screen.dart';
import 'package:antoinette/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:antoinette/app/modules/onboarding/views/pannic_button/pannic_onboarding_screen.dart';
import 'package:antoinette/app/modules/onboarding/views/splash_screen.dart';
import 'package:antoinette/app/modules/order/views/oder_screen.dart';
import 'package:antoinette/app/modules/order/views/order_details_screen.dart';
import 'package:antoinette/app/modules/payment/views/payment_details_screen.dart';
import 'package:antoinette/app/modules/payment/views/payment_success_screen.dart';
import 'package:antoinette/app/modules/payment/views/payment_webview_screen.dart';
import 'package:antoinette/app/modules/payment/views/subscription_page.dart';
import 'package:antoinette/app/modules/product/model/product_details_model.dart';
import 'package:antoinette/app/modules/product/views/check_out_screen.dart';
import 'package:antoinette/app/modules/product/views/product_datails_screen.dart';
import 'package:antoinette/app/modules/product/views/product_screen.dart';
import 'package:antoinette/app/modules/profile/views/account_screen.dart';
import 'package:antoinette/app/modules/profile/views/add_address.dart';
import 'package:antoinette/app/modules/profile/views/address_screen.dart';
import 'package:antoinette/app/modules/profile/views/info_screen.dart';
import 'package:antoinette/app/modules/profile/views/profile_screen.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/modules/session/views/session_form_section.dart';
import 'package:antoinette/app/modules/letters/views/article_details_screen.dart';
import 'package:antoinette/app/modules/session/views/session_screen.dart';
import 'package:antoinette/app/modules/therapy/views/camera_screen.dart';
import 'package:antoinette/app/modules/chatting/views/healing_note_screen.dart';
import 'package:antoinette/app/modules/chatting/views/text_therapy_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../modules/bookmark/views/bookmark_letter_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes = {
    SplashScreen.routeName: (context) => const SplashScreen(),

    // Onboarding section
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
    NotificationScreen.routeName: (context) => const NotificationScreen(),
    PannicOnboardingScreen.routeName: (context) => const PannicOnboardingScreen(),
    // OrderBarScreen.routeName: (context) => const OrderBarScreen(),

    // Authentication section
    SignInScreen.routeName: (context) => const SignInScreen(),
    SignUpScreen.routeName: (context) => const SignUpScreen(),

    VerifyEmailScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return VerifyEmailScreen(
        token: args,
      );
    },

    VerifyEmailScreenWithForgot.routeName: (context) =>
        const VerifyEmailScreenWithForgot(),
    OTPVerifyForgotScreen.routeName: (context) => const OTPVerifyForgotScreen(),
    ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
    ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),

    OTPVerifyScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return OTPVerifyScreen(
        token: args,
      );
    },

    MainButtonNavbarScreen.routeName: (context) =>
        const MainButtonNavbarScreen(),
    PanicButtonScreen.routeName: (context) => const PanicButtonScreen(),

    // Product Section
    ProductScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as bool;
      return ProductScreen(
        shouldBackButton: args,
      );
    },
    // ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
    ProductDetailScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as ProductModel;
      return ProductDetailScreen(
        productModel: args,
      );
    },

    CheckOutScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as ProductModel;
      return CheckOutScreen(
        productModel: args,
      );
    },
    // CheckOutScreen.routeName: (context) => const CheckOutScreen(),

    // Session Section
    SessionDetailsScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return SessionDetailsScreen(
        sessionId: args,
      );
    },

    SessionFormScreen.routeName: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return SessionFormScreen(
        slotData: args,
      );
    },

    SessionScreen.routeName: (context) => const SessionScreen(),

    MyOrderScreen.routeName: (context) => const MyOrderScreen(),

    OrderDetailsScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return OrderDetailsScreen(
        orderId: args,
      );
    },

    // Dear Diary Section
    DearDiaryScreen.routeName: (context) => const DearDiaryScreen(),
    AddDiaryScreen.routeName: (context) => const AddDiaryScreen(),
    SetJournalPasswordScreen.routeName: (context) =>
        const SetJournalPasswordScreen(),
    ChangeJournalPasswordScreen.routeName: (context) =>
        const ChangeJournalPasswordScreen(),
    EditDiaryScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return EditDiaryScreen(
        userId: args,
      );
    },

    // Therapy Section
    HealingNoteScreen.routeName: (context) => const HealingNoteScreen(),
    TextTherapyScreen.routeName: (context) => TextTherapyScreen(
          chatId: Get.arguments['chatId'],
          receiverId: Get.arguments['receiverId'],
          receiverName: Get.arguments['receiverName'],
          receiverImage: Get.arguments['receiverImage'],
        ),
    CameraScreen.routeName: (context) => const CameraScreen(
          cameras: [],
        ),

    // Letter Section
    LetterScreen.routeName: (context) => const LetterScreen(),
    ArticleDetailsScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as ArticleModel;
      return ArticleDetailsScreen(
        articleModel: args,
      );
    },

    // ignore: equal_keys_in_map
    BookmarkArticleDetailsScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments
          as BookmarkArticleDetailsItemModel;
      return BookmarkArticleDetailsScreen(
        bookmarkArticleItemModel: args,
      );
    },

    PodcastDetailsScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as PodcastModel;
      return PodcastDetailsScreen(
        podcastModel: args,
      );
    },

    BookMarkPodcastDetailsScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments
          as BookmarkPodcastDetailsItemModel;
      return BookMarkPodcastDetailsScreen(
        bookmarkPodcastDetailsItemModel: args,
      );
    },

    BookmarkScreen.routeName: (context) => const BookmarkScreen(),
    CheckInScreen.routeName: (context) => const CheckInScreen(),

    SubscriptionScreen.routeName: (context) => const SubscriptionScreen(),
    PaymentDetailsScreen.routeName: (context) => const PaymentDetailsScreen(),

    PaymentWebviewScreen.routeName: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return PaymentWebviewScreen(
        paymentData: args,
      );
    },

    AddCheckInScreen.routeName: (context) => const AddCheckInScreen(),
    PaymentSuccessScreen.routeName: (context) => const PaymentSuccessScreen(),

    CustomStatusScreen.routeName: (context) => const CustomStatusScreen(),
    ContactScreen.routeName: (context) => const ContactScreen(),
    AddContactScreen.routeName: (context) => const AddContactScreen(),

    HistoryScreen.routeName: (context) => const HistoryScreen(),
    // PaymentWebviewScreen.routeName: (context) => const PaymentWebviewScreen(),

    // Profile Section
    ProfileScreen.routeName: (context) => const ProfileScreen(),
    AccountScreen.routeName: (context) => const AccountScreen(),
    AdderssScreen.routeName: (context) => const AdderssScreen(),

    EditContactScreen.routeName: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return EditContactScreen(
        contactData: args,
      );
    },

    
    RescheduleSessionScreen.routeName: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
      return RescheduleSessionScreen(
        data: args,
      );
    },


    AddAdderssScreen.routeName: (context) {
     
      return AddAdderssScreen(
       
      );
    },

    InfoScreen.routeName: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      return InfoScreen(
        data: args['data']!,
        appBarTitle: args['appBarTitle']!,
      );
    },
  };

  static var initialRoute = SplashScreen.routeName;
}
