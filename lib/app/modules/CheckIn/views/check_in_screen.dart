import 'package:antoinette/app/modules/checkIn/controllers/all_checkIn_list_controller.dart';
import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/payment/views/subscription_page.dart';
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
    return WillPopScope(
      onWillPop: () async { 
        if (Get.find<AllCheckInController>()
                .errorMessage
                ?.contains("Access denied!") ==
            true) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainButtonNavbarScreen.routeName,
            (Route<dynamic> route) => false,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            children: [
              heightBox24,
              CustomAppBar(name: 'Check In'),
              heightBox12,
              GetBuilder<AllCheckInController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage
                        ?.contains("Access denied!") ==
                    true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => WillPopScope(
                        onWillPop: () async {                      
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            MainButtonNavbarScreen.routeName,
                            (Route<dynamic> route) => false,
                          );
                          return false;
                        },
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'This feature requires a subscription. Unlock check-ins and more by upgrading your plan.',
                              style: GoogleFonts.poppins(fontSize: 14.sp),
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  SubscriptionScreen.routeName,
                                );
                              },
                              child: Container(
                                height: 32.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color(0xffF7EDE6),
                                  border: Border.all(
                                      color: const Color(0xff305FA1)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Upgrade Now',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 3, 3, 3), fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MainButtonNavbarScreen.routeName,
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Container(
                                height: 32.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color(0xffA13430).withOpacity(0.1),
                                  border: Border.all(
                                      color: const Color(0xffA13430)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Maybe Late',
                                    style: TextStyle(
                                        color: const Color(0xff8C543F),
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                  return const Center(child: Text(""));
                } else if (controller.checkInList == null ||
                    controller.checkInList!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.checkInList?.length,
                        itemBuilder: (context, index) {
                          String isoDate =
                              '${controller.checkInList?[index].createdAt}';
                          // Parse the ISO date string
                          DateTime utcDate = DateTime.parse(isoDate);
                          // Convert to local time if needed
                          DateTime localDate = utcDate.toLocal();
                          // Format it
                          String formatted = DateFormat('d MMMM yyyy, h:mm a')
                              .format(localDate);

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
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
                                            Text(
                                              'Check-In time : ${controller.checkInList?[index].timer}',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      formatted,
                                      style:
                                          GoogleFonts.poppins(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
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
        ),
      ),
    );
  }
}
