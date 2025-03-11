import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressCardWidget extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback editOntap;
  final bool isShowBatch;
  const AddressCardWidget({
    super.key,
    required this.name,
    required this.address,
    required this.editOntap,
    required this.isShowBatch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isShowBatch ? 102 : 80,
      width: 353,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12.r,
                      backgroundColor: Color(0xffA57EA5).withAlpha(10),
                      child: Center(
                        child: Icon(
                          Icons.location_pin,
                          color: AppColors.iconButtonThemeColor,
                          size: 18.sp,
                        ),
                      ),
                    ),
                    widthBox8,
                    Text(
                      name,
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.edit_outlined,
                      color: AppColors.iconButtonThemeColor,
                      size: 18.sp,
                    )),
              ],
            ),
            Center(
                child: Text(
              address,
              style: GoogleFonts.poppins(fontSize: 14),
            )),
            heightBox12,
            isShowBatch
                ? Center(
                    child: Container(
                      height: 24,
                      width: 124,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xffD9A48E))),
                      child: Center(
                          child: Text(
                        'Default shipping',
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: Color(0xffD9A48E)),
                      )),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
