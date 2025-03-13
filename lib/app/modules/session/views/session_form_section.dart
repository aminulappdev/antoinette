import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionFormScreen extends StatefulWidget {
  static const String routeName = '/session-form-screen';
  const SessionFormScreen({super.key});

  @override
  State<SessionFormScreen> createState() => _SessionFormScreenState();
}

class _SessionFormScreenState extends State<SessionFormScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Let’s Get to Know You'),
                Text(
                  'This form helps your therapist understand your needs better. Answer as openly as you feel comfortable.',
                  style: GoogleFonts.cormorantGaramond(fontSize: 15.sp),
                  textAlign: TextAlign.center,
                ),
                heightBox8,
                Text(
                  'Personal details',
                  style: GoogleFonts.poppins(fontSize: 15.sp),
                ),
                heightBox8,
                Text('Full Name',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff626262))),
                heightBox8,
                TextFormField(
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
                heightBox12,
                Text('Age',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff626262))),
                heightBox8,
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter age';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: '27', hintStyle: TextStyle(color: Colors.grey)),
                ),
                heightBox12,
                Text('Contact',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff626262))),
                heightBox8,
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter contact';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(hintStyle: TextStyle(color: Colors.grey)),
                ),
                heightBox12,
                Text(
                  'Current Emotional State:',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff626262),
                  ),
                ),
                heightBox8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (bool? value) {}),
                        const Text("Happy"),
                        SizedBox(width: 10),
                        Checkbox(value: false, onChanged: (bool? value) {}),
                        const Text("Anxious"),
                        SizedBox(width: 10),
                        Checkbox(value: false, onChanged: (bool? value) {}),
                        const Text("Stressed"),
                        SizedBox(width: 10),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (bool? value) {}),
                        const Text("Other"),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Text(
                      "Consent:",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff626262),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (bool? value) {}),
                        const Text("I agree to the terms & privacy policy."),
                      ],
                    ),
                  ],
                ),
                GradientElevatedButton(onPressed: () {
                   Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
                }, text: 'Submit')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
