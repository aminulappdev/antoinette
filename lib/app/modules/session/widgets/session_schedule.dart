
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionSchedule extends StatelessWidget {
  final String date;
  final String time;
  final String address;

  const SessionSchedule({
    super.key,
    required this.date,
    required this.time,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.date_range),
                widthBox4,
                Text(
                  date,
                  style:
                      GoogleFonts.poppins(fontSize: 12.sp, color: Colors.black),
                )
              ],
            ),
            heightBox8,
            Row(
              children: [
                Icon(Icons.timer_outlined),
                widthBox4,
                Text(
                  time,
                  style:
                      GoogleFonts.poppins(fontSize: 12.sp, color: Colors.black),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            Icon(Icons.location_on_outlined),
            widthBox4,
            SizedBox(
              width: 160,
              child: Text(
                address,
                style:
                    GoogleFonts.poppins(fontSize: 12.sp, color: Colors.black),
              ),
            )
          ],
        ),
      ],
    );
  }
}
