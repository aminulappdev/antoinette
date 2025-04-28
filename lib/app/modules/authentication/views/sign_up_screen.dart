import 'dart:io';

import 'package:antoinette/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/agree_condition_widget.dart';
import 'package:antoinette/app/modules/authentication/widgets/footer_section.dart';
import 'package:antoinette/app/modules/authentication/widgets/welcome_text.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/image_picker.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
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
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  SignUpController signUpController = SignUpController();
  File? image;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  bool _obscureText = true;
  bool isStudentChecked = false;
  bool showButton = false;

  void toggleShowButton() {
    setState(() {
      showButton = !showButton;
    });
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
              heightBox20,
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
                      controller: nameCtrl,
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
                      controller: numberCtrl,
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
                      controller: emailCtrl,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isStudentChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isStudentChecked = value!;
                            });
                          },
                        ),
                        Text('Are you student?'),
                      ],
                    ),
                    // image show kora theke baki ...
                    heightBox12,
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          _imagePickerHelper.showAlertDialog(context,
                              (File pickedImage) {
                            setState(() {
                              image = pickedImage;
                            });
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 220,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Add your identification'),
                              widthBox4,
                              Icon(Icons.upload)
                            ],
                          )),
                        ),
                      ),
                    ),
                    heightBox14,
                    AgreeConditionCheck(
                      onChanged: (value) {
                        setState(() {
                          showButton = value;
                        });
                      },
                    ),
                    heightBox24,
                    Visibility(
                      visible: showButton,
                      replacement: Opacity(
                        opacity: 0.5,
                        child: GradientElevatedButton(
                          text: 'Verify Email',
                          onPressed: () {},
                        ),
                      ),
                      child: GradientElevatedButton(
                        onPressed: onTapToNextButton,
                        text: 'Verify Email',
                      ),
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
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await signUpController.signUp(
          nameCtrl.text, emailCtrl.text, passwordCtrl.text, numberCtrl.text);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'New user created');
          Navigator.pushNamed(context, VerifyEmailScreen.routeName,
              arguments: signUpController.token);

          // print('My token ---------------------------------------');
          // print(signUpController.token);
        } else {
          if (mounted) {
            showSnackBarMessage(context, signUpController.errorMessage!, true);
          }
        }
      }
    }
  }

  void clearTextField() {
    emailCtrl.clear();
    nameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
  }

  @override
  void dispose() {
    super.dispose();

    emailCtrl.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }
}
