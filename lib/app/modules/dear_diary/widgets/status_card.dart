
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCard extends StatelessWidget {
  final String emojiPath;
  final String percent;
  const StatusCard({
    super.key,
    required this.emojiPath,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 76.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding:  EdgeInsets.all(2.0.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 10.r,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(emojiPath),
            ),
            widthBox4,
            Text('$percent%',style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
