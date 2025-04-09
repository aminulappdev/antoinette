import 'package:antoinette/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = '/reset-password-screen';
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  ResetPasswordController resetPasswordController = ResetPasswordController();
  bool _obscureText = true;

  final info = box.read('fotgot-password-info');
  final userAccessToken = box.read('user-access-token');
  String email = '';
  String accessToken = '';

  @override
  void initState() {
    email = info['email'];
    accessToken = userAccessToken;
    super.initState();
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
                  name: 'Reset Password',
                ),
                heightBox16,
                AuthHeaderText(
                  title: 'Let’s secure your space.',
                  subtitle: 'Create a new password to secure your account.',
                  titleFontSize: 15,
                  subtitleFontSize: 12,
                  sizeBoxHeight: 300,
                ),
                heightBox12,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter New Password',
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
                      heightBox12,
                      Text('Confirm Password',
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff626262))),
                      heightBox8,
                      TextFormField(
                        controller: confirmPasswordCtrl,
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
                      heightBox24,
                      GradientElevatedButton(
                        onPressed: onTapToNextButton,
                        text: 'Update Password',
                      ),
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

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await resetPasswordController.resetPassword(
          email, passwordCtrl.text, confirmPasswordCtrl.text, accessToken);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Reset password successfully done');
          Navigator.pushNamed(context, SignInScreen.routeName);
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, resetPasswordController.errorMessage!, true);
          }
        }
      }
    }
  }

  void clearTextField() {
    passwordCtrl.clear();
    confirmPasswordCtrl.clear();
  }

  @override
  void dispose() {
    super.dispose();

    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
  }
}
