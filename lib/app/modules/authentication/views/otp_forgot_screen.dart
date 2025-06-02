import 'dart:async';
import 'package:antoinette/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/verify_otp_controller.dart';
import 'package:antoinette/app/modules/authentication/views/reset_password_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerifyForgotScreen extends StatefulWidget {
  static const String routeName = '/otp-forgot-screen';
  const OTPVerifyForgotScreen({super.key});

  @override
  State<OTPVerifyForgotScreen> createState() => _OTPVerifyForgotScreenState();
}

class _OTPVerifyForgotScreenState extends State<OTPVerifyForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  ResendOTPController resendOTPController = Get.put(ResendOTPController());

  RxInt remainingTime = 60.obs;
  late Timer timer;
  RxBool enableResendCodeButtom = false.obs;

  final info = box.read('fotgot-password-info');
  String email = '';

  @override
  void initState() {
    super.initState();

    email = info['email'];

    // Start the timer without calling resendOTP
    remainingTime.value = 16;
    enableResendCodeButtom.value = false;
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

  void resendOTP() async {
    print('resendOTP called'); // For debugging
    enableResendCodeButtom.value = false;
    remainingTime.value = 16;
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

    final bool isSuccess = await resendOTPController.resendOTP(email);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'OTP successfully sent');
        clearTextField(); // Clear OTP field after successful resend
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, resendOTPController.errorMessage ?? 'Failed to resend OTP', true);
      }
    }
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
                name: 'OTP Verification',
              ),
              heightBox16,
              AuthHeaderText(
                title: 'Verify Your Identity',
                subtitle:
                    'For your security, verify the code sent to your registered contact. Let’s confirm it’s you!',
                titleFontSize: 15,
                subtitleFontSize: 12,
                sizeBoxHeight: 350,
              ),
              heightBox20,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: PinCodeTextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: otpCtrl,
                        length: 6,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          borderWidth: 0.2,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12.r),
                          inactiveColor: const Color.fromARGB(218, 222, 220, 220),
                          fieldHeight: 55.h,
                          fieldWidth: 55.h,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        appContext: context,
                      ),
                    ),
                    heightBox8,
                    GetBuilder<VerifyOtpController>(
                      builder: (controller) {
                        bool isOtpFilled = otpCtrl.text.length == 6;

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: isOtpFilled ? 1.0 : 0.5,
                              child: GradientElevatedButton(
                                onPressed:
                                    (!isOtpFilled || controller.inProgress)
                                        ? () {}
                                        : () => onTapToNextButton(),
                                text: controller.inProgress ? '' : 'Confirm',
                              ),
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
                    heightBox12,
                    Obx(
                      () => Visibility(
                        visible: !enableResendCodeButtom.value,
                        replacement: GestureDetector(
                          onTap: () {
                            resendOTP();
                          },
                          child: Text(
                            'Resend code',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Resend code in ',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: '${remainingTime.value}',
                                style: GoogleFonts.poppins(
                                  color: Colors.orange,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: 's',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await verifyOtpController.verifyOtp(
        otpCtrl.text,
        resendOTPController.accessToken.toString(),
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'OTP verification successfully done');
          Navigator.pushNamed(context, ResetPasswordScreen.routeName);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            verifyOtpController.errorMessage ?? 'OTP verification failed',
            true,
          );
        }
      }
    }
  }

  void clearTextField() {
    otpCtrl.clear();
    setState(() {}); // Update UI to reflect cleared field
  }

  @override
  void dispose() {
    timer.cancel(); // Prevent memory leaks
    otpCtrl.dispose();
    super.dispose();
  }
}