import 'package:antoinette/app/modules/history/controllers/all_booking_controller.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  final AllBookingController allBookingController =
      Get.find<AllBookingController>();

  @override
  void initState() {
    allBookingController.getBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllBookingController>(builder: (controller) {
      if (controller.inProgress && controller.page == 1) {
        return Center(child: CircularProgressIndicator());
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: controller.bookingList.length,
          itemBuilder: (context, index) {
            String dateString = '2025-03-18';
            DateTime date = DateTime.parse(dateString);
            DateTime today = DateTime.now();
            if (controller.bookingList[index].paymentStatus == 'paid') {
              // if (today.isBefore(date)) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 169.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
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
                                          image: AssetImage(
                                              AssetsPath.womenBookRead),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Find Balance & Clarity',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15.sp),
                                      ),
                                      heightBox4,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Dr. Jane Smith',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10.sp),
                                          ),
                                          Text(
                                            'Video Therapy',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10.sp),
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
                                            style: GoogleFonts.poppins(
                                                fontSize: 10.sp),
                                          ),
                                          Text(
                                            '02:00 pm',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10.sp),
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
                            SizedBox(
                              height: 40,
                              child: GradientElevatedButton(
                                  onPressed: () {}, text: 'Rebook'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              // }
              // return Text('No data');
            }
          },
        ),
      );
    });
  }
}


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DateComparisonScreen(),
//     );
//   }
// }

// class DateComparisonScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Date Comparison and Formatting Example"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "ফরম্যাট করা তারিখ: $formattedDate",
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             Text(
//               comparisonResult,
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
