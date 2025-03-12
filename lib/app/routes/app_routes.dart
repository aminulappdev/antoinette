

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
import 'package:antoinette/app/modules/Letters/views/article_details_screen.dart';
import 'package:antoinette/app/modules/Letters/views/letter_screen.dart';
import 'package:antoinette/app/modules/Letters/views/podcast_details.dart';
import 'package:antoinette/app/modules/therapy/views/camera_screen.dart';
import 'package:antoinette/app/modules/therapy/views/healing_note_screen.dart';
import 'package:antoinette/app/modules/therapy/views/text_therapy_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes = {
    
    SplashScreen.routeName: (context) => const SplashScreen(),

    // Onboarding section
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),

    // Authentication section
    SignInScreen.routeName: (context) => const SignInScreen(),
    SignUpScreen.routeName: (context) => const SignUpScreen(),
    VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
    VerifyEmailScreenWithForgot.routeName: (context) => const VerifyEmailScreenWithForgot(),
    OTPVerifyForgotScreen.routeName: (context) => const OTPVerifyForgotScreen(),
    ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
    ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
    OTPVerifyScreen.routeName: (context) => const OTPVerifyScreen(),



    MainButtonNavbarScreen.routeName: (context) => const MainButtonNavbarScreen(),
    PanicButtonScreen.routeName: (context) => const PanicButtonScreen(),
    

    // Product Section
    ProductScreen.routeName: (context) { 
      final args = ModalRoute.of(context)!.settings.arguments as bool;
      return ProductScreen(shouldBackButton: args,);},
    ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
    CheckOutScreen.routeName: (context) => const CheckOutScreen(),
   

    // Session Section
    SessionDetailsScreen.routeName: (context) => const SessionDetailsScreen(),
    SessionFormScreen.routeName: (context) => const SessionFormScreen(),

    // Dear Diary Section
    DearDiaryScreen.routeName: (context) => const DearDiaryScreen(),
    AddDiaryScreen.routeName: (context) => const AddDiaryScreen(),

    // Therapy Section
     HealingNoteScreen.routeName: (context) => const HealingNoteScreen(),
     TextTherapyScreen.routeName: (context) => const TextTherapyScreen(),
     CameraScreen.routeName: (context) => const CameraScreen(cameras: [],),

    LetterScreen.routeName: (context) => const LetterScreen(),
    ArticleDetailsScreen.routeName: (context) => const ArticleDetailsScreen(),
    PodcastDetailsScreen.routeName: (context) => const PodcastDetailsScreen(),


    CheckInScreen.routeName: (context) => const CheckInScreen(),
    AddCheckInScreen.routeName: (context) => const AddCheckInScreen(),
    CustomStatusScreen.routeName: (context) => const CustomStatusScreen(),



    ContactScreen.routeName: (context) => const ContactScreen(),
    AddContactScreen.routeName: (context) => const AddContactScreen(),


    HistoryScreen.routeName: (context) => const HistoryScreen(),

    // Profile Section
    ProfileScreen.routeName: (context) => const ProfileScreen(),
    AccountScreen.routeName: (context) => const AccountScreen(),
    AdderssScreen.routeName: (context) => const AdderssScreen(),
    AddAdderssScreen.routeName: (context) => const AddAdderssScreen(),
    
    InfoScreen.routeName: (context) { 
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      return InfoScreen(data: args['data']!,appBarTitle: args['appBarTitle']!,);},
   
  };

  static var initialRoute = OnboardingScreen.routeName;
}
