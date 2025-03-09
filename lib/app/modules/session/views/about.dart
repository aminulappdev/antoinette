import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Therapy Session',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '"Connect with a licensed psychologist for a private and secure therapy session. Choose between text or video consultations and get the support you need—anytime, anywhere.',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
        heightBox12,
        Text(
          'About Therapist',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '"Connect with a licensed psychologist for a private and secure therapy session. Choose between text or video consultations and get the support you need—anytime, anywhere.',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
        heightBox12,
        Text(
          'About Therapist',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '"Connect with a licensed psychologist for a private and secure therapy session. Choose between text or video consultations and get the support you need—anytime, anywhere.',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
        heightBox12,
        Text(
          'Pricing & Payment',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '\$50 per session',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
