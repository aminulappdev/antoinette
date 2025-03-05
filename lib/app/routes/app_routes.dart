

import 'package:antoinette/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/otp_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/views/otp_screen.dart';
import 'package:antoinette/app/modules/authentication/views/reset_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_up_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:antoinette/app/modules/onboarding/views/splash_screen.dart';
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


   
  };

  static var initialRoute = OnboardingScreen.routeName;
}
