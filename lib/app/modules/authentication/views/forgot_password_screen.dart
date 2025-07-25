import 'package:antoinette/app/modules/authentication/views/verify_email_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password-screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final info = box.read('fotgot-password-info');
  String email = '';

  @override
  void initState() {
     email = info['email'];
    super.initState();
   
  }

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
              CustomAppBar(
                name: 'Forgot Password',
              ),
              heightBox16,
              AuthHeaderText(
                title: 'No worries!',
                subtitle:
                    'Enter your registered email address or mobile number and we’ll send you instructions to reset your password. Let’s get you back on track quickly and securely!',
                titleFontSize: 15,
                subtitleFontSize: 12,
                sizeBoxHeight: 400,
              ),
              heightBox12,
              Text(
                'Email Address',
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              heightBox12,
              Container(
                height: 70.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Color(0xffDCDCDC))),
                child: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 21.r,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.email_sharp),
                      ),
                      SizedBox(
                        width: 250.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email:',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500)),
                            heightBox8,
                            Text(email,
                                style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, VerifyEmailScreenWithForgot.routeName);
                        },
                        child: CircleAvatar(
                          radius: 21.r,
                          backgroundColor: AppColors.iconButtonThemeColor,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
