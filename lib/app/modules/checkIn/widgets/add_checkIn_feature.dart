
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCheckInFeature extends StatelessWidget {
  final String icon;
  final String feature;
  const AddCheckInFeature({
    super.key,
    required this.icon,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 115.w,
      decoration: BoxDecoration(
          color: Color(0xffD9A48E).withAlpha(10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffD9A48E))),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(icon, style: TextStyle(fontSize: 20.sp)),
            Text(
              feature,
              style: TextStyle(color: Color(0xffD9A48E)),
            ),
          ],
        ),
      ),
    );
  }
}