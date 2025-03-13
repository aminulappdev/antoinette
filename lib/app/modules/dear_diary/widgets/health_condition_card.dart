import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthConditionCard extends StatelessWidget {
  final Color themeColor;
  final String iconPath;
  final String status;
  final String day;
  final String time;
  final String description;
  final VoidCallback lockOntap;
  final VoidCallback moreHorizOntap;
  const HealthConditionCard({
    super.key,
    required this.iconPath,
    required this.status,
    required this.day,
    required this.time,
    required this.description,
    required this.lockOntap,
    required this.moreHorizOntap,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(iconPath),
                  radius: 20.r,
                ),
                widthBox8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: Color(0xffE9BD0F)),
                    ),
                    Row(
                      children: [
                        Text(
                          day,
                          style: GoogleFonts.poppins(fontSize: 10.sp),
                        ),
                        widthBox8,
                        Text(time, style: GoogleFonts.poppins(fontSize: 10.sp)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 130.w,
                ),
                Icon(
                  Icons.lock_outline,
                  size: 30.h,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Container(
                    height: 26.h,
                    width: 26.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Icon(
                      Icons.more_horiz,
                      size: 24.sp,
                    ))),
              ],
            ),
            heightBox8,
            Text(
              description,
              style: GoogleFonts.caveat(
                fontSize: 14.sp,
                decoration: TextDecoration.underline,
              ),
              textScaleFactor: 1.25,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
