import 'package:antoinette/app/modules/checkIn/controllers/all_checkIn_list_controller.dart';
import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/payment/views/subscription_page.dart';
import 'package:antoinette/app/utils/app_colors.dart';
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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Get.find<AllCheckInController>().getCheckInList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<AllCheckInController>()
                .errorMessage
                ?.contains("Access denied!") ??
            false) {
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
        floatingActionButton: GestureDetector(
          onTap: () {
            int localCurrentPage = 0;
            final PageController localPageController = PageController();

            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                contentPadding: EdgeInsets.all(20.w),
                content: StatefulBuilder(
                  builder: (context, setModalState) {
                    return SizedBox(
                      height: 300.h,
                      width: 300.w,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView(
                              controller: localPageController,
                              onPageChanged: (page) {
                                setModalState(() {
                                  localCurrentPage = page;
                                });
                              },
                              children: [
                                _buildSlide(
                                  title: 'What Is Check-In?',
                                  subtitle: 'Set a timer. Stay safe.',
                                  description:
                                      'Check-In lets you set a safety timer when you’re in a vulnerable situation—like taking a ride, walking alone, or going on a date. If you don’t respond when the timer ends, we’ll alert your trusted contacts.',
                                ),
                                _buildSlide(
                                  title: 'What Happens Next?',
                                  subtitle:
                                      'We check in. You reply, or we act.',
                                  description:
                                      'When your timer ends, you’ll get a notification asking if you’re okay. If you don’t respond in time, your selected trusted contact will get an alert with your location.',
                                ),
                                _buildSlide(
                                  title: 'Who Gets Alerted?',
                                  subtitle: 'Only the people you choose.',
                                  description:
                                      'You control who gets notified. Add at least one trusted contact to activate the Check-In feature.\nTip: We never share your data without your permission.',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                width: localCurrentPage == index ? 12.w : 8.w,
                                height: localCurrentPage == index ? 12.w : 8.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: localCurrentPage == index
                                      ? AppColors.iconButtonThemeColor
                                      : Colors.grey.withOpacity(0.5),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              localCurrentPage > 0
                                  ? TextButton(
                                      onPressed: () {
                                        localPageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                        setModalState(() {
                                          localCurrentPage--;
                                        });
                                      },
                                      child: Text(
                                        'Previous',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color:
                                                AppColors.iconButtonThemeColor),
                                      ),
                                    )
                                  : SizedBox(width: 60.w),
                              TextButton(
                                onPressed: () {
                                  if (localCurrentPage < 2) {
                                    localPageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                    setModalState(() {
                                      localCurrentPage++;
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  localCurrentPage == 2 ? 'Got it' : 'Next',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.iconButtonThemeColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                    color: AppColors.iconButtonThemeColor,
                    //  color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: Text(
                  'How to use',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.normal,fontSize: 12),
                      textAlign: TextAlign.center,
                )),
              ),
              heightBox50,
              heightBox10
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.h),
          child: Column(
            children: [
              heightBox24,
              CustomAppBar(name: 'Check In'),
              heightBox12,
              GetBuilder<AllCheckInController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage
                        ?.contains("Access denied!") ??
                    false) {
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
                              borderRadius: BorderRadius.circular(20.r)),
                          title: Center(
                            child: Text(
                              'This feature requires a subscription. Unlock check-ins and more by upgrading your plan.',
                              style: GoogleFonts.poppins(fontSize: 14.sp),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SubscriptionScreen.routeName);
                              },
                              child: Container(
                                height: 32.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: const Color(0xffF7EDE6),
                                  border: Border.all(
                                      color: const Color(0xff305FA1)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Upgrade Now',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
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
                                  borderRadius: BorderRadius.circular(10.r),
                                  color:
                                      const Color(0xffA13430).withOpacity(0.1),
                                  border: Border.all(
                                      color: const Color(0xffA13430)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Maybe Later',
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
                  return const SizedBox.shrink();
                } else if (controller.checkInList == null ||
                    controller.checkInList!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.checkInList!.length,
                      itemBuilder: (context, index) {
                        final createdAt =
                            controller.checkInList![index].createdAt;
                        final isoDate = createdAt?.toString() ?? '';
                        final utcDate =
                            DateTime.tryParse(isoDate) ?? DateTime.now();
                        final localDate = utcDate.toLocal();
                        final formatted =
                            DateFormat('d MMMM yyyy, h:mm a').format(localDate);

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Container(
                            height: 69.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.checkInList![index]
                                                .quickCheckIn ??
                                            'N/A',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        'Check-In time: ${controller.checkInList![index].timer ?? 'N/A'}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.sp),
                                      ),
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
                }
              }),
              heightBox20,
              GradientElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddCheckInScreen.routeName,
                      arguments: '');
                },
                text: '+ Add Check-In',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({
    required String title,
    required String subtitle,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
