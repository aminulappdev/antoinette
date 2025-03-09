

import 'package:antoinette/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/otp_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/views/otp_screen.dart';
import 'package:antoinette/app/modules/authentication/views/reset_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_up_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/dear_diary/views/dear_diary_screen.dart';
import 'package:antoinette/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:antoinette/app/modules/onboarding/views/splash_screen.dart';
import 'package:antoinette/app/modules/product/views/check_out_screen.dart';
import 'package:antoinette/app/modules/product/views/product_datails_screen.dart';
import 'package:antoinette/app/modules/product/views/product_screen.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/modules/session/views/session_form_section.dart';
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
    
   
  };

  static var initialRoute = OnboardingScreen.routeName;
}
