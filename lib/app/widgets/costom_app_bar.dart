import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  final bool offPopBack;
  const CustomAppBar({super.key, required this.name, this.offPopBack = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            offPopBack == true ? null : Navigator.pop(context);
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 24.r,
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            color: Color(0xff626262),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: 36.w,
        )
      ],
    );
  }
}
