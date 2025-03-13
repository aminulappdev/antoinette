import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/borderRectangleButton.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const String routeName = '/verify-email-screen';
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
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
                Text(
                  'Check Email',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w400),
                ),
                heightBox12,
                SizedBox(
                  width: 210.w,
                  child: Text(
                    'Please check your email to verify your account.',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                heightBox30,
                GradientElevatedButton(
                  onPressed: () {
                  
                  },
                  text: 'Confirm Now',
                ),
                heightBox8,
                BorderRectangleButton(
                  name: 'Skip',
                  ontap: () {

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
