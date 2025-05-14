import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoOptionCard extends StatelessWidget {
  final String op1Name;
  final String op2Name;
  final String status;
  final String imagePath;
  final String title;
  final String name;
  final String therapyType;
  final String date;
  final String time;
  final String price;
  final VoidCallback op1Ontap;
  final VoidCallback op2Ontap;
  const TwoOptionCard({
    super.key,
    required this.status,
    required this.imagePath,
    required this.title,
    required this.name,
    required this.therapyType,
    required this.date,
    required this.time,
    required this.price,
    required this.op1Ontap,
    required this.op2Ontap,
    required this.op1Name,
    required this.op2Name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 180.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 61.h,
                      width: 97.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(imagePath),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          status,
                          style: TextStyle(
                              color: status == 'confirmed'
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    widthBox8,
                    SizedBox(
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            title,
                            style: GoogleFonts.poppins(fontSize: 15.sp),
                          ),
                          heightBox4,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.poppins(fontSize: 10.sp),
                              ),
                              Text(
                                therapyType,
                                style: GoogleFonts.poppins(fontSize: 10.sp),
                              ),
                            ],
                          ),
                          heightBox4,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                date,
                                style: GoogleFonts.poppins(fontSize: 10.sp),
                              ),
                              Text(
                                time,
                                style: GoogleFonts.poppins(fontSize: 10.sp),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                heightBox8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount Paid',
                      style: GoogleFonts.poppins(fontSize: 12.sp),
                    ),
                    Text(
                      '₦$price',
                      style: GoogleFonts.roboto(fontSize: 12.sp),
                    ),
                  ],
                ),
                heightBox8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: op1Ontap,
                      child: SizedBox(
                        height: 40.h,
                        width: 150.w,
                        child: GradientElevatedButton(
                            onPressed: op1Ontap, text: op1Name),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: InkWell(
                        onTap: op2Ontap,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.iconButtonThemeColor),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              op2Name,
                              style: TextStyle(
                                  color: AppColors.iconButtonThemeColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
