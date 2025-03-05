import 'package:antoinette/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:antoinette/app/modules/authentication/views/otp_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_up_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/continue_elevated_button.dart';
import 'package:antoinette/app/modules/authentication/widgets/footer_section.dart';
import 'package:antoinette/app/modules/authentication/widgets/forgot_password_row.dart';
import 'package:antoinette/app/modules/authentication/widgets/liner_widget.dart';
import 'package:antoinette/app/modules/authentication/widgets/welcome_text.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
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
                        
                        ontap: () {
                          Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                        },
                      ),
                      heightBox24,
                      GradientElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, OTPVerifyScreen.routeName);
                        },
                        text: 'Sign in',
                      ),
                      Liner(),
                      ContinueElevatedButton(
                        name: 'Continue with google',
                        logoPath: AssetsPath.googleLogoUp,
                      ),
                      heightBox12,
                      ContinueElevatedButton(
                        name: 'Continue with apple',
                        logoPath: AssetsPath.appleLogo,
                      ),
                      heightBox12,
                      ContinueElevatedButton(
                        name: 'Continue with facebook',
                        logoPath: AssetsPath.fbLogo,
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
}
