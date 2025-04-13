import 'package:antoinette/app/modules/dear_diary/controllers/get_dashboard_controller.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/status_card.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MentalStatusWidget extends StatefulWidget {
  const MentalStatusWidget({
    super.key,
    required this.toogleOntap,
  });

  final VoidCallback toogleOntap;

  @override
  State<MentalStatusWidget> createState() => _MentalStatusWidgetState();
}

class _MentalStatusWidgetState extends State<MentalStatusWidget> {
  String happyPercent = '0';
  String angryPercent = '0';
  String sadPercent = '0';
  String anglePercent = '0';
  String tiredPercent = '0';
  String musclePercent = '0';
  final GetDashboardController getDashboardController =
      Get.find<GetDashboardController>();
  bool _isDropdownOpen = false;
  String _selectedMonth = 'January';

  String currentYear = DateTime.now().year.toString();
  String currentMonth = DateTime.now().month.toString().padLeft(2, '0');
  String date = '2025-04';

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  void initState() {
    getDashboardController.getDashboard(date);
    print('my date ..................................');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 27.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColors.iconButtonThemeColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedMonth,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleDropdown,
                    child: CircleAvatar(
                      radius: 8.r,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(
                          _isDropdownOpen
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: AppColors.iconButtonThemeColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isDropdownOpen) ...[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(4.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var month in [
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December',
                      ])
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMonth = month;
                              if (_selectedMonth == 'January') {
                                date = '$currentYear-01';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'February') {
                                date = '$currentYear-02';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'March') {
                                date = '$currentYear-03';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'April') {
                                date = '$currentYear-04';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'May') {
                                date = '$currentYear-05';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'June') {
                                date = '$currentYear-06';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'July') {
                                date = '$currentYear-07';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'August') {
                                date = '$currentYear-08';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'September') {
                                date = '$currentYear-09';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'October') {
                                date = '$currentYear-10';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'November') {
                                date = '$currentYear-11';
                                getDashboardController.getDashboard(date);
                              } else if (_selectedMonth == 'December') {
                                date = '$currentYear-12';
                                getDashboardController.getDashboard(date);
                              }
                              _isDropdownOpen = false;
                              print('Selecte date : $date');
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(2.0.h),
                            child: Text(
                              month,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 12.h),
          GetBuilder<GetDashboardController>(builder: (controller) {
            if (controller.inProgress) {
              return Center(child: CircularProgressIndicator());
            }
            return Row(
              children: [
                Column(
                  children: [
                    StatusCard(
                      percent: controller.dashboardData!.feelingsStatusData?.sad
                              .toString() ??
                          '0',
                      emojiPath: AssetsPath.sad,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller
                              .dashboardData!.feelingsStatusData?.angry
                              .toString() ??
                          '0',
                      emojiPath: AssetsPath.angry,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller
                              .dashboardData!.feelingsStatusData?.motivated
                              .toString() ??
                          '0',
                      emojiPath: AssetsPath.muscle,
                    ),
                  ],
                ),
                SizedBox(width: 14.w),
                Column(
                  children: [
                    StatusCard(
                      percent: controller
                              .dashboardData!.feelingsStatusData?.calm
                              .toString() ??
                          '0',
                      emojiPath: AssetsPath.tired,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller
                              .dashboardData!.feelingsStatusData?.happy
                              .toString() ??
                          '0',
                      emojiPath: AssetsPath.happy,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller
                              .dashboardData!.feelingsStatusData?.anxious
                              .toString() ??
                          '0',
                      emojiPath: AssetsPath.angle,
                    ),
                  ],
                )
              ],
            );
          })
        ],
      ),
    );
  }
}
