import 'package:antoinette/app/modules/checkIn/controllers/all_checkIn_list_controller.dart';
import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  GetBuilder<AllCheckInController>(
                    builder: (controller) {
                       if (controller.inProgress) {
                    return Center(child: CircularProgressIndicator());
                  }
                      return SizedBox(
                        height: 600.h,
                        child: ListView.builder(
                          itemCount: controller.checkInList?.length,
                          itemBuilder: (context, index) {
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
                                    children: [
                                      Icon(
                                        Icons.push_pin,
                                        color: Colors.orange,
                                      ),
                                      widthBox8,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.checkInList?[index].quickCheckIn}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 15.sp),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.call_outlined,
                                                size: 18.h,
                                              ),
                                              widthBox4,
                                              Text(
                                                'Sunan - 01975265553',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12.sp),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 90.w,
                                      ),
                                      Text(
                                        'Yesterday',
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
                    }
                  ),
                  heightBox20,
                  GradientElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddCheckInScreen.routeName,
                            arguments: '');
                      },
                      text: '+ Add Check-In')
                ],
              ),
            )
         
      ),
    );
  }
}
