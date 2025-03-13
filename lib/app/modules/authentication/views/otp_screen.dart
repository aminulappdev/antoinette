import 'dart:async';
import 'package:antoinette/app/modules/authentication/views/reset_password_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/borderRectangleButton.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerifyScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  const OTPVerifyScreen({super.key});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RxInt remainingTime = 60.obs;
  late Timer timer;
  RxBool enableResendCodeButtom = false.obs;

  @override
  void initState() {
    resendOTP();
    super.initState();
  }

  void resendOTP() {
    enableResendCodeButtom.value = false;
    remainingTime.value = 60;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        remainingTime.value--;
        if (remainingTime.value == 0) {
          t.cancel();
          enableResendCodeButtom.value = true;
        }
      },
    );
  }

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
                  name: 'OTP Verification',
                ),
                heightBox16,
                AuthHeaderText(
                  title: 'Enter OTP',
                  subtitle:
                      'We have just sentb you 6 digitcode via uour email.',
                  titleFontSize: 20,
                  subtitleFontSize: 12,
                  sizeBoxHeight: 200,
                ),
                heightBox20,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
      
                      PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        onChanged: (value) {},
                        pinTheme: PinTheme(
                            selectedColor: Colors.black,
                            activeColor: Colors.orange,
                            borderWidth: 0.5,
                            shape: PinCodeFieldShape.circle,
                            borderRadius: BorderRadius.circular(100.r),
                            inactiveColor: const Color(0xffD9A48E),
                            fieldHeight: 50.h,
                            fieldWidth: 50.h,
                            activeFillColor: Colors.white,
                            inactiveFillColor:
                                Color(0xffD9A48E).withOpacity(0.1),
                            selectedFillColor: Colors.white),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        appContext: context,
                      ),

                      heightBox8,
                      GradientElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ResetPasswordScreen.routeName);
                        },
                        text: 'Confirm',
                      ),
                      heightBox8,
                      BorderRectangleButton(name: 'Skip', ontap: () {}),
                      heightBox12,
                      Obx(
                        () => Visibility(
                          visible: !enableResendCodeButtom.value,
                          replacement: GestureDetector(
                            onTap: () {
                              resendOTP();
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Didn’t receive code? ',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16.sp)),
                                  TextSpan(
                                      text: 'Resend code',
                                      style: GoogleFonts.poppins(
                                          color: Colors.orange,
                                          fontSize: 16.sp)),
                                ],
                              ),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Resend code',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 16.sp)),
                                TextSpan(
                                    text: '$remainingTime',
                                    style: GoogleFonts.poppins(
                                        color: Colors.orange, fontSize: 16.sp)),
                                TextSpan(
                                    text: 's',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 16.sp)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                heightBox100,
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
