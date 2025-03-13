
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GridFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const GridFeature({
    super.key, required this.icon, required this.title, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: const Color(0xffC184FD)
                  .withOpacity(0.2))),
      child: Padding(
        padding:  EdgeInsets.all(8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor:
                  AppColors.iconButtonThemeColor,
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            heightBox4,
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12.sp),
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(fontSize: 10.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
