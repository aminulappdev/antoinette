import 'dart:io';

import 'package:antoinette/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:antoinette/app/modules/authentication/controllers/student_sign_up_controller.dart';
import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/authentication/views/verify_email_screen.dart';
import 'package:antoinette/app/modules/authentication/widgets/agree_condition_widget.dart';
import 'package:antoinette/app/modules/authentication/widgets/footer_section.dart';
import 'package:antoinette/app/modules/authentication/widgets/welcome_text.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/image_picker.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  SignUpController signUpController = Get.put(SignUpController());
  final StudentSignUpController studentSignUpController =
      Get.find<StudentSignUpController>();
  

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 24.r,
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  Text(
                    'Sign up',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Color(0xff626262),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 36.w,
                  )
                ],
              ),
              heightBox16,
              WelcomeText(
                title: 'Let’s Begin Your Journey',
                subtitle: 'Just a few details to make this space yours.',
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
                      maxLength: 15,
                      controller: numberCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
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
                        // ignore: curly_braces_in_flow_control_structures
                        else if (value.length < 6)
                          // ignore: curly_braces_in_flow_control_structures
                          return 'Password must be at least 6 characters';
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
                    image != null
                        ? Center(
                            child: Image.file(
                              image!,
                              width: MediaQuery.of(context).size.width,
                              height: 250.h,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(),
                    heightBox12,
                    isStudentChecked == true
                        ? Align(
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
                                width: 250,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add your identification (JPG, JPEG, PNG)',
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                    widthBox4,
                                    Icon(
                                      Icons.upload,
                                      size: 20,
                                    )
                                  ],
                                )),
                              ),
                            ),
                          )
                        : Container(),
                    heightBox14,
                    AgreeConditionCheck(
                      onChanged: (value) {
                        setState(() {
                          showButton = value;
                        });
                      },
                    ),
                    heightBox24,
                    GetBuilder<SignUpController>(
                      builder: (controller) {
                        return Visibility(
                          visible: showButton,
                          replacement: Opacity(
                            opacity: 0.5,
                            child: GradientElevatedButton(
                              text: 'Verify Email',
                              onPressed: () {}, // Disabled
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GradientElevatedButton(
                                onPressed: controller.inProgress
                                    ? () {} // Prevent tap when loading
                                    : (isStudentChecked == false
                                        ? () => signUpFunction()
                                        : (image == null
                                            ? () => showModel()
                                            : () => signUpStudentFunction())),
                                text:
                                    controller.inProgress ? '' : 'Verify Email',
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
                          ),
                        );
                      },
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

  Future<void> showModel() async {
    showSnackBarMessage(context, 'Please upload your identification image.');
  }

  Future<void> signUpFunction() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await signUpController.signUp(
        nameCtrl.text,
        emailCtrl.text,
        passwordCtrl.text,
        numberCtrl.text,
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'New user created');
          isStudentChecked
              ? Navigator.pushNamed(context, MainButtonNavbarScreen.routeName)
              : Navigator.pushNamed(context, VerifyEmailScreen.routeName,
                  arguments: signUpController.token);
        } else {
          if (mounted) {
            showSnackBarMessage(context, signUpController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, signUpController.errorMessage!, true);
        }
      }
    }
  }

  Future<void> signUpStudentFunction() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await studentSignUpController.studentSignUp(
          nameCtrl.text,
          emailCtrl.text,
          passwordCtrl.text,
          numberCtrl.text,
          image);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'New student user created');
          Navigator.pushNamed(context, VerifyEmailScreen.routeName,
              arguments: studentSignUpController.token);
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, studentSignUpController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, studentSignUpController.errorMessage ?? 'Failed', true);
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
