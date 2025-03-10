import 'package:antoinette/app/modules/dear_diary/widgets/status_card.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MentalStatusWidget extends StatefulWidget {
  const MentalStatusWidget({
    super.key,
    required this.toogleOntap,
    required this.happyPercent,
    required this.angryPercent,
    required this.sadPercent,
    required this.anglePercent,
    required this.tiredPercent,
    required this.musclePercent,
  });

  final VoidCallback toogleOntap;
  final String happyPercent;
  final String angryPercent;
  final String sadPercent;
  final String anglePercent;
  final String tiredPercent;
  final String musclePercent;

  @override
  State<MentalStatusWidget> createState() => _MentalStatusWidgetState();
}

class _MentalStatusWidgetState extends State<MentalStatusWidget> {
  bool _isDropdownOpen = false;
  String _selectedMonth = 'January';

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 27.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Colors.purple,
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
                          color: Colors.purple,
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
            // Dropdown list of months
            Column(
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
                        _isDropdownOpen = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(2.0.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          month,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
          SizedBox(height: 12.h), // Replaced heightBox12
          Row(
            children: [
              Column(
                children: [
                  StatusCard(
                    percent: widget.sadPercent,
                    emojiPath: AssetsPath.sad,
                  ),
                  SizedBox(height: 10.h), // Replaced heightBox10
                  StatusCard(
                    percent: widget.angryPercent,
                    emojiPath: AssetsPath.angry,
                  ),
                  SizedBox(height: 10.h), // Replaced heightBox10
                  StatusCard(
                    percent: widget.musclePercent,
                    emojiPath: AssetsPath.muscle,
                  ),
                ],
              ),
              SizedBox(width: 14.w), // Replaced widthBox14
              Column(
                children: [
                  StatusCard(
                    percent: widget.tiredPercent,
                    emojiPath: AssetsPath.tired,
                  ),
                  SizedBox(height: 10.h), // Replaced heightBox10
                  StatusCard(
                    percent: widget.happyPercent,
                    emojiPath: AssetsPath.happy,
                  ),
                  SizedBox(height: 10.h), // Replaced heightBox10
                  StatusCard(
                    percent: widget.anglePercent,
                    emojiPath: AssetsPath.angle,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
