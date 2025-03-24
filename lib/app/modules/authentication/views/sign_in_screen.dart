import 'package:antoinette/app/modules/authentication/controllers/forgot_password_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/sign_in_controller.dart';
import 'package:antoinette/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_up_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/continue_elevated_button.dart';
import 'package:antoinette/app/modules/authentication/widgets/footer_section.dart';
import 'package:antoinette/app/modules/authentication/widgets/forgot_password_row.dart';
import 'package:antoinette/app/modules/authentication/widgets/liner_widget.dart';
import 'package:antoinette/app/modules/authentication/widgets/welcome_text.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

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
  SignInController signInController = SignInController();
  ForgotPasswordController forgotPasswordController =
      ForgotPasswordController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox4,
                CustomAppBar(
                  name: 'Sign In',
                ),
                heightBox16,
                WelcomeText(
                  title: 'Hi, Welcome back!',
                  subtitle: 'Sign in to continue exploring the best deals',
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
                          if (value!.isEmpty) {
                            return 'Enter email';
                          }
                          if (EmailValidator.validate(value) == false) {
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
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          hintText: '***********',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ForgotPasswordRow(
                        ontap: forgotPasswordBTN,
                      ),
                      heightBox24,
                      GradientElevatedButton(
                        onPressed: onTapToNextButton,
                        text: 'Sign in',
                      ),
                      Liner(),
                      ContinueElevatedButton(
                        name: 'Continue with google',
                        logoPath: AssetsPath.googleLogoUp, ontap: () {
                          
                        },
                      ),
                      heightBox12,
                      ContinueElevatedButton(
                        name: 'Continue with apple',
                        logoPath: AssetsPath.appleLogo, ontap: () {  },
                      ),
                      heightBox12,
                      ContinueElevatedButton(
                        name: 'Continue with facebook',
                        logoPath: AssetsPath.fbLogo, ontap: () {  },
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
      ),
    );
  }

// Future<void> onTapGoogleSignIn() async {
//   final bool isSuccess = await Get.find<GoogleAuthController>().signInWithGoogle();

//   if (isSuccess) {
//     if (context.mounted) {
//       showSnackBarMessage(context, 'Signed in with Google');   
//     }
//   } else {
//     if (context.mounted) {
//       showSnackBarMessage(
//         context,
//         Get.find<GoogleAuthController>().errorMessage ?? 'Sign-in failed',
//         true,
//       );
//     }
//   }
// }


  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await signInController.signIn(emailCtrl.text, passwordCtrl.text);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Login successfully done');
          Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
        } else {
          if (mounted) {
            showSnackBarMessage(context, signInController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          print('Error show ----------------------------------');
          showSnackBarMessage(context, signInController.errorMessage!, true);
        }
      }
    }
  }

  Future<void> forgotPasswordBTN() async {
    final bool isSuccess =
        await forgotPasswordController.forgotPassword(emailCtrl.text);

    if (isSuccess) {
      if (mounted) {
        // Map<String, dynamic> userInfo = {
        //   'email': emailCtrl.text,
        //   'token': forgotPasswordController.accessToken
        // };

        // box.write('fotgot-password-info', userInfo);
        Navigator.pushNamed(context, ForgotPasswordScreen.routeName);

      
      } else {
        if (mounted) {
          showSnackBarMessage(context, forgotPasswordController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, forgotPasswordController.errorMessage!, true);
      }
    }
  }

  void clearTextField() {
    emailCtrl.clear();
    passwordCtrl.clear();
  }
  
  @override
  void dispose() {
    super.dispose();

    emailCtrl.dispose();
    passwordCtrl.dispose();
  }
}
