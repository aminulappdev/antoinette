import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/agree_condition_widget.dart';
import 'package:antoinette/app/modules/authentication/widgets/footer_section.dart';
import 'package:antoinette/app/modules/authentication/widgets/welcome_text.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  name: 'Sign Up',
                ),
                heightBox16,
                WelcomeText(
                  title: 'Let’s Begin Your Journey',
                  subtitle: 'Just a few details  to make this space yours.',
                ),
                heightBox50,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name',
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
                            return 'Enter name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your full name',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      heightBox8,
                      Text('Mobile Number',
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
                            return 'Enter mobile number';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your number',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      heightBox8,
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
                      AgreeConditionCheck(
                        ontap: () {},
                      ),
                      heightBox24,
                      GradientElevatedButton(
                        onPressed: () {
                           Navigator.pushNamed(context, VerifyEmailScreen.routeName);
                        },
                        text: 'Verify Email',
                      ),
                      heightBox12,
                      AuthenticationFooterSection(
                        fTextName: 'Already received your letter? ',
                        fTextColor: Color(0xff33363F),
                        sTextName: 'open it here',
                        sTextColor: Color(0xffD9A48E),
                        ontap: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
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
