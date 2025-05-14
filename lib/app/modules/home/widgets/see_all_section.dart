
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeAllSection extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const SeeAllSection({
    super.key, required this.title, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 250.w,
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 16.sp),
            )),
        GestureDetector(
          onTap: ontap,
          child: Row(
            children: [
              Text(
                '',
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: AppColors.iconButtonThemeColor),
              ),
              widthBox4,
              CircleAvatar(
                  radius: 16.r, child: Icon(Icons.arrow_forward))
            ],
          ),
        )
      ],
    );
  }
}