import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageHeader extends StatelessWidget {
  final String circleText;
  final VoidCallback onTapNotification;

  const HomePageHeader({
    super.key,
    required this.circleText,
    required this.onTapNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 21.r,
          backgroundColor: Color(0xffC37D60),
          child: Center(
            child: Text(
              circleText,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: onTapNotification,
              child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xff828282),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: Color(0xff828282),
                  )),
            ),
            widthBox8,
          ],
        ),
      ],
    );
  }
}
