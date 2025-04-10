
import 'package:antoinette/app/modules/bookmark/model/bookmark_article_details_model.dart';
import 'package:antoinette/app/modules/bookmark/views/bookmark_article_details_page.dart';
import 'package:antoinette/app/modules/common/views/notification_screen.dart';
import 'package:antoinette/app/modules/letters/model/article_details_model.dart';
import 'package:antoinette/app/modules/letters/model/podcast_details_model.dart';


import 'package:antoinette/app/modules/letters/views/letter_screen.dart';
import 'package:antoinette/app/modules/letters/views/podcast_details.dart';
import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/modules/checkIn/views/check_in_screen.dart';
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
import 'package:antoinette/app/modules/onboarding/views/splash_screen.dart';
import 'package:antoinette/app/modules/order/views/order_bar.dart';
import 'package:antoinette/app/modules/product/model/product_details_model.dart';
import 'package:antoinette/app/modules/product/views/check_out_screen.dart';
import 'package:antoinette/app/modules/product/views/product_datails_screen.dart';
import 'package:antoinette/app/modules/product/views/product_screen.dart';
import 'package:antoinette/app/modules/profile/views/account_screen.dart';
import 'package:antoinette/app/modules/profile/views/add_address.dart';
import 'package:antoinette/app/modules/profile/views/address_screen.dart';
import 'package:antoinette/app/modules/profile/views/info_screen.dart';
import 'package:antoinette/app/modules/profile/views/profile_screen.dart';
import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/modules/session/views/session_form_section.dart';
import 'package:antoinette/app/modules/letters/views/article_details_screen.dart';
import 'package:antoinette/app/modules/session/views/session_screen.dart';
import 'package:antoinette/app/modules/therapy/views/camera_screen.dart';
import 'package:antoinette/app/modules/therapy/views/healing_note_screen.dart';
import 'package:antoinette/app/modules/therapy/views/text_therapy_screen.dart';
import 'package:flutter/material.dart';

import '../modules/bookmark/views/bookmark_letter_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes = {
    SplashScreen.routeName: (context) => const SplashScreen(),

    // Onboarding section
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
    NotificationScreen.routeName: (context) => const NotificationScreen(),
    OrderBarScreen.routeName: (context) => const OrderBarScreen(),

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
      final args =
          ModalRoute.of(context)!.settings.arguments as SessionDataModel;
      return SessionDetailsScreen(
        sessionDataModel: args,
      );
    },

    SessionFormScreen.routeName: (context) => const SessionFormScreen(),
    SessionScreen.routeName: (context) => const SessionScreen(),

    // Dear Diary Section
    DearDiaryScreen.routeName: (context) => const DearDiaryScreen(),
    AddDiaryScreen.routeName: (context) => const AddDiaryScreen(),

    // Therapy Section
    HealingNoteScreen.routeName: (context) => const HealingNoteScreen(),
    TextTherapyScreen.routeName: (context) => const TextTherapyScreen(),
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
      final args = ModalRoute.of(context)!.settings.arguments as BookmarkArticleItemModel;
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

    BookmarkScreen.routeName: (context) => const BookmarkScreen(),
    CheckInScreen.routeName: (context) => const CheckInScreen(),
    
    AddCheckInScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return AddCheckInScreen(customStatus: args,
        
      );
    },

    CustomStatusScreen.routeName: (context) => const CustomStatusScreen(),
    ContactScreen.routeName: (context) => const ContactScreen(),
    AddContactScreen.routeName: (context) => const AddContactScreen(),

    HistoryScreen.routeName: (context) => const HistoryScreen(),

    // Profile Section
    ProfileScreen.routeName: (context) => const ProfileScreen(),
    AccountScreen.routeName: (context) => const AccountScreen(),
    AdderssScreen.routeName: (context) => const AdderssScreen(),
    
    AddAdderssScreen.routeName: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return AddAdderssScreen(
        type: args,
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
