import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueElevatedButton extends StatelessWidget {
  final String logoPath;
  final String name;
  const ContinueElevatedButton({
    super.key,
    required this.logoPath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 42.h,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 10.r,
            child: Image.asset(
              logoPath,
              fit: BoxFit.fill,
            ),
          ),
          widthBox8,
          Text(
            name,
            style: GoogleFonts.poppins(
                fontSize: 14.sp, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
