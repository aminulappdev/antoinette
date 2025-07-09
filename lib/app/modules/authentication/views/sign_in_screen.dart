// // ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

// import 'package:antoinette/app/modules/authentication/controllers/forgot_password_controller.dart';
// import 'package:antoinette/app/modules/authentication/controllers/google_auth_controller.dart';
// import 'package:antoinette/app/modules/authentication/controllers/resend_otp_controller.dart';
// import 'package:antoinette/app/modules/authentication/controllers/sign_in_controller.dart';
// import 'package:antoinette/app/modules/authentication/views/forgot_password_screen.dart';
// import 'package:antoinette/app/modules/authentication/views/sign_up_screen.dart';
// import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
// import 'package:antoinette/app/modules/authentication/widgets/continue_elevated_button.dart';
// import 'package:antoinette/app/modules/authentication/widgets/footer_section.dart';
// import 'package:antoinette/app/modules/authentication/widgets/forgot_password_row.dart';
// import 'package:antoinette/app/modules/authentication/widgets/liner_widget.dart';
// import 'package:antoinette/app/modules/authentication/widgets/welcome_text.dart';
// import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
// import 'package:antoinette/app/utils/assets_path.dart';
// import 'package:antoinette/app/utils/responsive_size.dart';
// import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
// import 'package:antoinette/app/widgets/show_snackBar_message.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SignInScreen extends StatefulWidget {
//   static const String routeName = '/sign-in-screen';
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController emailCtrl = TextEditingController();
//   TextEditingController passwordCtrl = TextEditingController();

//   final SignInController signInController = Get.put(SignInController());
//   final ResendOTPController resendOTPController =
//       Get.put(ResendOTPController());
//   final ForgotPasswordController forgotPasswordController =
//       Get.put(ForgotPasswordController());

//   bool _obscureText = true;
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(12.0.h),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               heightBox24,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, SignUpScreen.routeName);
//                     },
//                     child: CircleAvatar(
//                       backgroundColor: Theme.of(context).primaryColor,
//                       radius: 24.r,
//                       child: Icon(
//                         Icons.arrow_back,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Sign In',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18.sp,
//                       color: Color(0xff626262),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Container(
//                     width: 36.w,
//                   )
//                 ],
//               ),
//               heightBox16,
//               WelcomeText(
//                 title: 'Hi, Welcome back!',
//                 subtitle: '',
//               ),
//               heightBox50,
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Email',
//                         style: GoogleFonts.poppins(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff626262))),
//                     heightBox8,
//                     TextFormField(
//                       controller: emailCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (String? value) {
//                         if (value!.isEmpty) return 'Enter email';
//                         if (!EmailValidator.validate(value)) {
//                           return 'Enter a valid email address';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           hintText: 'example@gmail.com',
//                           hintStyle: TextStyle(color: Colors.grey)),
//                     ),
//                     heightBox8,
//                     Text('Password',
//                         style: GoogleFonts.poppins(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff626262))),
//                     heightBox8,
//                     TextFormField(
//                       controller: passwordCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'Enter password';
//                         } else if (value.length < 6)
//                           return 'Password must be at least 6 characters';
//                         return null;
//                       },
//                       obscureText: _obscureText,
//                       decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                               _obscureText
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.grey),
//                           onPressed: () =>
//                               setState(() => _obscureText = !_obscureText),
//                         ),
//                         hintText: '***********',
//                         hintStyle: TextStyle(color: Colors.grey),
//                       ),
//                     ),

//                     GetBuilder<ForgotPasswordController>(
//                       builder: (controller) {
//                         return Align(
//                           alignment: Alignment.centerRight,
//                           child: ForgotPasswordRow(
//                             ontap: controller.inProgress
//                                 ? () {}
//                                 : forgotPasswordBTN,
//                           ),
//                         );
//                       },
//                     ),

//                     heightBox24,

//                     // 🔄 updated: SignIn Button with internal loader
//                     GetBuilder<SignInController>(
//                       builder: (controller) {
//                         return Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             GradientElevatedButton(
//                               onPressed: controller.inProgress
//                                   ? () {}
//                                   : () => onTapToNextButton(),
//                               text: controller.inProgress ? '' : 'Sign in',
//                             ),
//                             if (controller.inProgress)
//                               SizedBox(
//                                 width: 24,
//                                 height: 24,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                           ],
//                         );
//                       },
//                     ),

//                     Liner(),
//                     ContinueElevatedButton(
//                       name: 'Continue with google',
//                       logoPath: AssetsPath.googleLogoUp,
//                       ontap: onTapGoogleSignIn,
//                     ),
//                     heightBox12,
//                     AuthenticationFooterSection(
//                       fTextName: 'Don’t have an account? ',
//                       fTextColor: Color(0xff33363F),
//                       sTextName: 'Sign up',
//                       sTextColor: Color(0xff33363F),
//                       ontap: () {
//                         Navigator.pushNamed(context, SignUpScreen.routeName);
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> onTapGoogleSignIn() async {
//     final controller = Get.find<GoogleAuthController>();
//     final bool isSuccess = await controller.signInWithGoogle();

//     if (isSuccess) {
//       if (context.mounted) {
//         showSnackBarMessage(context, 'Google success');
//       }
//     } else {
//       String message = controller.errorMessage ?? 'Google failed';

//       if (message.contains('credentials')) {
//         if (context.mounted) {
//           showDialog(
//             context: context,
//             builder: (_) => AlertDialog(
//               title: Text("Account problem"),
//               content:
//                   Text("This account already registered. try another account"),
//               actions: [
//                 TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text("Correct"))
//               ],
//             ),
//           );
//         }
//       } else {
//         if (context.mounted) {
//           showSnackBarMessage(context, message, true);
//         }
//       }
//     }
//   }

//   Future<void> onTapToNextButton() async {
//     if (_formKey.currentState!.validate()) {
//       final bool isSuccess = await signInController.signIn(
//           emailCtrl.text, passwordCtrl.text, isChecked);

//       if (isSuccess) {
//         if (mounted) {
//           showSnackBarMessage(context, 'Login successfully done');
//           Navigator.pushNamedAndRemoveUntil(
//               context, MainButtonNavbarScreen.routeName, (route) => false);
//         }
//       } else if (signInController.errorMessage!.contains('verified')) {
//         final bool isSuccess =
//             await resendOTPController.resendOTP(emailCtrl.text);

//         if (isSuccess) {
//           showSnackBarMessage(
//               context, 'You are not verified, please verify your email');
//           Navigator.pushNamed(context, VerifyEmailScreen.routeName,
//               arguments: resendOTPController.accessToken);
//         } else {
//           if (mounted) {
//             showSnackBarMessage(
//                 context, resendOTPController.errorMessage ?? 'Failed', true);
//           }
//         }
//       } else {
//         if (mounted) {
//           showSnackBarMessage(
//               context, signInController.errorMessage ?? 'Login failed', true);
//         }
//       }
//     }
//   }

//   Future<void> forgotPasswordBTN() async {
//     final bool isSuccess =
//         await forgotPasswordController.forgotPassword(emailCtrl.text);
//     if (emailCtrl.text.isEmpty) {
//       showSnackBarMessage(context, 'Please input valid email', true);
//     } else if (isSuccess && mounted) {
//       Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
//     } else if (mounted) {
//       showSnackBarMessage(context,
//           forgotPasswordController.errorMessage ?? 'Error occurred', true);
//     }
//   }

//   void clearTextField() {
//     emailCtrl.clear();
//     passwordCtrl.clear();
//   }

//   @override
//   void dispose() {
//     emailCtrl.dispose();
//     passwordCtrl.dispose();
//     super.dispose();
//   }
// }

import 'package:antoinette/app/modules/authentication/controllers/forgot_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/google_auth_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_in_controller.dart';
import 'package:antoinette/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_up_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/continue_elevated_button.dart';
import 'package:antoinette/app/modules/authentication/widgets/footer_section.dart';
import 'package:antoinette/app/modules/authentication/widgets/forgot_password_row.dart';
import 'package:antoinette/app/modules/authentication/widgets/liner_widget.dart';
import 'package:antoinette/app/modules/authentication/widgets/welcome_text.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/urls.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final SignInController signInController = Get.put(SignInController());
  final ResendOTPController resendOTPController =
      Get.put(ResendOTPController());
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  bool _obscureText = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 24.r,
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  Text(
                    'Sign In',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Color(0xff626262),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 36.w,
                  )
                ],
              ),
              heightBox16,
              WelcomeText(
                title: 'Hi, Welcome back! ',
                subtitle: "Let's continue your journey.",
              ),
              heightBox50,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff626262))),
                    heightBox8,
                    TextFormField(
                      controller: emailCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Enter email';
                        if (!EmailValidator.validate(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'example@gmail.com',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    heightBox8,
                    Text('Password',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff626262))),
                    heightBox8,
                    TextFormField(
                      controller: passwordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        } else if (value.length < 6)
                          // ignore: curly_braces_in_flow_control_structures
                          return 'Password must be at least 6 characters';
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey),
                          onPressed: () =>
                              setState(() => _obscureText = !_obscureText),
                        ),
                        hintText: '***********',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),

                    GetBuilder<ForgotPasswordController>(
                      builder: (controller) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: ForgotPasswordRow(
                            ontap: controller.inProgress
                                ? () {}
                                : forgotPasswordBTN,
                          ),
                        );
                      },
                    ),

                    heightBox24,

                    GetBuilder<SignInController>(
                      builder: (controller) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            GradientElevatedButton(
                              onPressed: controller.inProgress
                                  ? () {}
                                  : () => onTapToNextButton(),
                              text: controller.inProgress ? '' : 'Sign in',
                            ),
                            if (controller.inProgress)
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    Liner(),
                    ContinueElevatedButton(
                      name: 'Continue with google',
                      logoPath: AssetsPath.googleLogoUp,
                      ontap: onTapGoogleSignIn,
                    ),
                    heightBox12,
                    AuthenticationFooterSection(
                      fTextName: 'Don’t have an account? ',
                      fTextColor: Color(0xff33363F),
                      sTextName: 'Sign up',
                      sTextColor: Color(0xff33363F),
                      ontap: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapGoogleSignIn() async {
    final controller = Get.find<GoogleAuthController>();
    final bool isSuccess = await controller.signInWithGoogle();

    if (isSuccess) {
      if (context.mounted) {
        showSnackBarMessage(context, 'Google success');
      }
    } else {
      String message = controller.errorMessage ?? 'Google failed';

      if (message.contains('credentials')) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Account problem"),
              content:
                  Text("This account already registered. try another account"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Correct"))
              ],
            ),
          );
        }
      } else {
        if (context.mounted) {
          showSnackBarMessage(context, message, true);
        }
      }
    }
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      // FCM টোকেন পাওয়া
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      // সাইন-ইন ডাটা এবং FCM টোকেন ব্যাকএন্ডে পাঠানো
      final bool isSuccess = await signInController.signIn(
        emailCtrl.text,
        passwordCtrl.text,
        isChecked,
        fcmToken: fcmToken, // FCM টোকেন পাঠানো
      );

      if (isSuccess) {
        if (mounted) {
          // ব্যাকএন্ডে FCM টোকেন পাঠানোর জন্য API কল
          await sendFcmTokenToBackend(emailCtrl.text, fcmToken);
          showSnackBarMessage(context, 'Login successfully done');
          Navigator.pushNamedAndRemoveUntil(
              context, MainButtonNavbarScreen.routeName, (route) => false);
        }
      } else if (signInController.errorMessage!.contains('verified')) {
        final bool isSuccess =
            await resendOTPController.resendOTP(emailCtrl.text);

        if (isSuccess) {
          showSnackBarMessage(
              context, 'You are not verified, please verify your email');
          Navigator.pushNamed(context, VerifyEmailScreen.routeName,
              arguments: resendOTPController.accessToken);
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, resendOTPController.errorMessage ?? 'Failed', true);
          }
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, signInController.errorMessage ?? 'Login failed', true);
        }
      }
    }
  }

  Future<void> sendFcmTokenToBackend(String email, String? fcmToken) async {
    if (fcmToken == null) {
      print('FCM Token is null');
      return;
    }

    const String apiUrl = Urls.signIn; // তোমার ব্যাকএন্ড API URL
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'fcmToken': fcmToken,
        }),
      );

      if (response.statusCode == 200) {
        print('FCM Token sent to backend successfully');
      } else {
        print('Failed to send FCM Token: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending FCM Token: $e');
    }
  }

  Future<void> forgotPasswordBTN() async {
    final bool isSuccess =
        await forgotPasswordController.forgotPassword(emailCtrl.text);
    if (emailCtrl.text.isEmpty) {
      showSnackBarMessage(context, 'Please input valid email', true);
    } else if (isSuccess && mounted) {
      Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
    } else if (mounted) {
      showSnackBarMessage(context,
          forgotPasswordController.errorMessage ?? 'Error occurred', true);
    }
  }

  void clearTextField() {
    emailCtrl.clear();
    passwordCtrl.clear();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}