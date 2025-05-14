import 'package:antoinette/app/modules/dear_diary/controllers/set_password_controller.dart';
import 'package:antoinette/app/modules/dear_diary/views/change_password_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SetJournalPasswordScreen extends StatefulWidget {
  static const String routeName = '/journal-password-screen';
  const SetJournalPasswordScreen({super.key});

  @override
  State<SetJournalPasswordScreen> createState() =>
      _SetJournalPasswordScreenState();
}

class _SetJournalPasswordScreenState extends State<SetJournalPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordCtrl = TextEditingController();
  SetJournalPasswordController setJournalPasswordController =
      SetJournalPasswordController();

  bool _obscureText = true;
  bool _isPasswordSet = false;

  @override
  void initState() {
    super.initState();
    _checkPasswordStatus();
  }

  Future<void> _checkPasswordStatus() async {
    _isPasswordSet = await setJournalPasswordController.isPasswordSet();
    if (_isPasswordSet && mounted) {
      
      Navigator.pushReplacementNamed(
          context, ChangeJournalPasswordScreen.routeName);
    }
    if (mounted) {
      setState(() {});
    }
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
                  name: 'Set Password',
                ),
                heightBox16,
                if (!_isPasswordSet) // Show form only if password is not set
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
                        heightBox24,
                        GradientElevatedButton(
                          onPressed: () {
                            onTapToNextButton(passwordCtrl.text);
                          },
                          text: 'Set Password',
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ChangeJournalPasswordScreen.routeName);
                            },
                            child: Text('Change password'),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_isPasswordSet)
                  Center(
                    child: Text(
                      'Password is already set. Please use "Change password" to update.',
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton(String password) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await setJournalPasswordController.setJournalPassword(password);

      if (isSuccess) {
        if (mounted) {
          clearTextField();
          showSnackBarMessage(context, 'Set password successfully done');
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, setJournalPasswordController.errorMessage!, true);
        }
      }
    }
  }

  void clearTextField() {
    passwordCtrl.clear();
  }

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }
}