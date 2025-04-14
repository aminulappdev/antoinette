import 'package:antoinette/app/modules/checkIn/controllers/all_checkIn_list_controller.dart';
import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CheckInScreen extends StatefulWidget {
  static const String routeName = '/chek-in-screen';
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  void initState() {
    Get.find<AllCheckInController>().getCheckInList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          children: [
            CustomAppBar(name: 'Check In'),
            heightBox12,
            GetBuilder<AllCheckInController>(builder: (controller) {
              if (controller.inProgress) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 600.h,
                child: ListView.builder(
                  itemCount: controller.checkInList?.length,
                  itemBuilder: (context, index) {
                    String isoDate = '${controller.checkInList?[index].createdAt}';
                    // Parse the ISO date string
                    DateTime utcDate = DateTime.parse(isoDate);
                    // Convert to local time if needed
                    DateTime localDate = utcDate.toLocal();
                    // Format it
                    String formatted =
                        DateFormat('d MMMM yyyy, h:mm a').format(localDate);

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Container(
                        height: 69.sp,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.checkInList?[index].quickCheckIn}',
                                    style: GoogleFonts.poppins(fontSize: 15.sp),
                                  ),
                                  Row(
                                    children: [
                                     
                                      Text(
                                        'Chech-In time : ${controller.checkInList?[index].timer}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                formatted,
                                style: GoogleFonts.poppins(fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            heightBox20,
            GradientElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddCheckInScreen.routeName,
                      arguments: '');
                },
                text: '+ Add Check-In')
          ],
        ),
      )),
    );
  }
}
