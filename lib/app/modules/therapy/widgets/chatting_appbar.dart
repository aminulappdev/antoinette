
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChatAppBar extends StatelessWidget {
  final String name;
  
  const CustomChatAppBar({
    super.key, required this.name,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.videocam_sharp,
                size: 30,
              ),
            ),widthBox8,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.error_outline,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}