
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeTextHomePage extends StatelessWidget {
  final String time;
  final String name;
  const WelcomeTextHomePage({
    super.key, required this.time, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good',
          style: GoogleFonts.poppins(
              fontSize: 26.sp, fontWeight: FontWeight.w400),
        ),
        Text(
          time,
          style: GoogleFonts.poppins(
              fontSize: 26.sp, fontWeight: FontWeight.w400),
        ),
        Text(
          name,
          style: GoogleFonts.poppins(
              fontSize: 26.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.iconButtonThemeColor),
        ),
      ],
    );
  }
}