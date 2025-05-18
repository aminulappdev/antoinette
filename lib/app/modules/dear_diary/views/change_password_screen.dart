import 'package:antoinette/app/modules/dear_diary/controllers/change_password_controller.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeJournalPasswordScreen extends StatefulWidget {
  static const String routeName = '/change-journal-password-screen';
  const ChangeJournalPasswordScreen({super.key});

  @override
  State<ChangeJournalPasswordScreen> createState() =>
      _ChangeJournalPasswordScreenState();
}

class _ChangeJournalPasswordScreenState
    extends State<ChangeJournalPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  ChangeJournalPasswordController changeJournalPasswordController =
      ChangeJournalPasswordController();

  bool _obscureText = true;

  String email = '';
  String accessToken = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightBox20,
              CustomAppBar(
                name: 'Change Password',
              ),
              heightBox16,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter Old Password',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff626262))),
                    heightBox8,
                    TextFormField(
                      controller: oldPasswordCtrl,
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
                    Text('Enter New Password',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff626262))),
                    heightBox8,
                    TextFormField(
                      controller: newPasswordCtrl,
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
                        onTapToNextButton(
                            oldPasswordCtrl.text, newPasswordCtrl.text);
                      },
                      text: 'Change Password',
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

  Future<void> onTapToNextButton(String oldPassword, String newPassword) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await changeJournalPasswordController
          .changeJournalPassword(oldPassword, newPassword);

      if (isSuccess) {
        if (mounted) {
          clearTextField();
          showSnackBarMessage(context, 'Set password successfully done');
          Navigator.pop(context);
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, changeJournalPasswordController.errorMessage!, true);
          }
        }
      }
      else {
        if (mounted) {
          showSnackBarMessage(
              context, changeJournalPasswordController.errorMessage ?? 'Failed', true);
        }
      }
    }
  }

  void clearTextField() {
    oldPasswordCtrl.clear();
    newPasswordCtrl.clear();
  }

  @override
  void dispose() {
    oldPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    super.dispose();
  }
}
