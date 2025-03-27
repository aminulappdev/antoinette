
import 'package:antoinette/app/modules/session/model/all_session_model.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PsychoSupportCard extends StatelessWidget {
  // final String status;
  // final String time;
  // final String price;
  // final String imagePath;
  // final String title;
  final AllSessionItemModel sessionItemModel;
  const PsychoSupportCard({
    super.key, required this.sessionItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.h,
      width: 238.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            height: 133.h,
            width: 238.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AssetsPath.psycoSupport,
                    ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'status',
                    style: GoogleFonts.poppins(
                        fontSize: 10.sp, color: Colors.green),
                  ),
                  heightBox50,
                  heightBox30,
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duration: time mins',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, color: Colors.white),
                      ),
                      Text(
                        ' Per session: ',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: 8.w, vertical: 2.h),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AssetsPath.womenBookRead),
                  radius: 18.r,
                ),
                widthBox4,
                Text(
                  'title',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}