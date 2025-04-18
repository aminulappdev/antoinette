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
    
  });

  @override
  State<MentalStatusWidget> createState() => _MentalStatusWidgetState();
}

class _MentalStatusWidgetState extends State<MentalStatusWidget> {
  final GetDashboardController getDashboardController =
      Get.find<GetDashboardController>();

  bool _isDropdownOpen = false;
  String _selectedMonth = 'January';
  String currentYear = DateTime.now().year.toString();
  String date = '2025-04';

  final LayerLink _layerLink = LayerLink();
  final GlobalKey _dropdownKey = GlobalKey();
  OverlayEntry? _dropdownOverlay;

  @override
  void initState() {
    super.initState();
    getDashboardController.getDashboard(date);
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }

    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _removeDropdown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    final RenderBox renderBox = _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        width: size.width,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                        final index = [
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
                          'December'
                        ].indexOf(month) + 1;
                        date = '$currentYear-${index.toString().padLeft(2, '0')}';
                        getDashboardController.getDashboard(date);
                        _toggleDropdown();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          month,
                          style: TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(_dropdownOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CompositedTransformTarget(
            link: _layerLink,
            child: Container(
              key: _dropdownKey,
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
          ),
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
                      percent: controller.dashboardData?.feelingsStatusData?.sad?.toString() ?? '0',
                      emojiPath: AssetsPath.sad,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller.dashboardData?.feelingsStatusData?.angry?.toString() ?? '0',
                      emojiPath: AssetsPath.angry,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller.dashboardData?.feelingsStatusData?.motivated?.toString() ?? '0',
                      emojiPath: AssetsPath.muscle,
                    ),
                  ],
                ),
                SizedBox(width: 14.w),
                Column(
                  children: [
                    StatusCard(
                      percent: controller.dashboardData?.feelingsStatusData?.calm?.toString() ?? '0',
                      emojiPath: AssetsPath.tired,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller.dashboardData?.feelingsStatusData?.happy?.toString() ?? '0',
                      emojiPath: AssetsPath.happy,
                    ),
                    SizedBox(height: 10.h),
                    StatusCard(
                      percent: controller.dashboardData?.feelingsStatusData?.anxious?.toString() ?? '0',
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
