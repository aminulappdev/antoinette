import 'package:antoinette/app/modules/authentication/views/otp_forgot_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class VerifyEmailScreenWithForgot extends StatefulWidget {
  static const String routeName = '/verify-email-forgot-screen';
  const VerifyEmailScreenWithForgot({super.key});

  @override
  State<VerifyEmailScreenWithForgot> createState() => _VerifyEmailScreenWithForgotState();
}

class _VerifyEmailScreenWithForgotState extends State<VerifyEmailScreenWithForgot> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox4,
                CustomAppBar(
                  name: 'Verify Email',
                ),
                heightBox100,

                CircleAvatar(
                  backgroundColor: Color(0xFFD9A48E).withValues(alpha: 0.1),
                  backgroundImage: AssetImage(AssetsPath.emailLogo),
                  radius: 36,
                ),
                heightBox16,
                AuthHeaderText(title: 'Check Email',subtitle:  'Please check your email to verify your account.',titleFontSize: 20,subtitleFontSize: 12,sizeBoxHeight: 210,),
                heightBox30,
                GradientElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, OTPVerifyForgotScreen.routeName);
                  },
                  text: 'Confirm Now',
                ),
                heightBox8,
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
