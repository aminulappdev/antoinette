import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



class RebookCard extends StatelessWidget {
  final String status;
  final String imagePath;
  final String title;
  final String name;
  final String therapyType;
  final String date;
  final String time;
  final String price;
  final VoidCallback ontap;
  const RebookCard({
    super.key,
    required this.status,
    required this.imagePath,
    required this.title,
    required this.name,
    required this.therapyType,
    required this.date,
    required this.time,
    required this.price,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 169.h,
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
                              image:  NetworkImage(imagePath),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          status,
                          style: TextStyle(color:  const Color.fromARGB(255, 11, 192, 17),fontSize: 12),
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
                      '\$$time',
                      style: GoogleFonts.poppins(fontSize: 12.sp),
                    ),
                  ],
                ),
                heightBox8,
                SizedBox(
                  height: 40,
                  child:
                      GradientElevatedButton(onPressed: ontap, text: 'Rebook'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
