import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300.h,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 169.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Padding(
                  padding:  EdgeInsets.all(12.0.h),
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
                                    image: AssetImage(AssetsPath.womenBookRead),
                                    fit: BoxFit.fill)),
                            child: Center(
                              child: Text(
                                'Completed',
                                style: TextStyle(color: Colors.white),
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
                                  'Find Balance & Clarity',
                                  style: GoogleFonts.poppins(fontSize: 15.sp),
                                ),
                                heightBox4,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Dr. Jane Smith',
                                      style: GoogleFonts.poppins(fontSize: 10.sp),
                                    ),
                                    Text(
                                      'Video Therapy',
                                      style: GoogleFonts.poppins(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                                heightBox4,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '25 January 2025',
                                      style: GoogleFonts.poppins(fontSize: 10.sp),
                                    ),
                                    Text(
                                      '02:00 pm',
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
                            '\$50.00',
                            style: GoogleFonts.poppins(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      heightBox8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40.h,
                            width: 150.w,
                            child: GradientElevatedButton(
                                onPressed: () {}, text: 'Reschedule'),
                          ),
                          SizedBox(
                              height: 40.h,
                              width: 150.w,
                              child: Container(
                                height: 40.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffA13430).withAlpha(10),
                                  border: Border.all(color: Color(0xffA13430)),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                    child: Text(
                                  'Cancel Booking',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Color(0xffA13430)),
                                )),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
