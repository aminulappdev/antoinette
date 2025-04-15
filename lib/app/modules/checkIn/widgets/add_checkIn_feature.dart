import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCheckInFeature extends StatelessWidget {
  final bool isSelectedf;
  final VoidCallback ontap;
  final String icon;
  final String feature;
  const AddCheckInFeature({
    super.key,
    required this.icon,
    required this.feature,
    required this.ontap, required this.isSelectedf,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 170.w,
        decoration: BoxDecoration(
            color: isSelectedf == true ? Color.fromARGB(255, 232, 230, 228) : Color(0xffD9A48E).withAlpha(10),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffD9A48E))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                icon,
                style: TextStyle(fontSize: 16.sp),
              ),
              widthBox5,
              SizedBox(
                width: 120.w,
                child: Text(
                  feature,
                  style: TextStyle(color: Color(0xffD9A48E), fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
