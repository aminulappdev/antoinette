import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key, required this.sessionDataModel});
  final SessionDataModel sessionDataModel; 
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Therapy Session',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '${widget.sessionDataModel.description}',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
        heightBox12,
        Text(
          'About Therapist',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '${widget.sessionDataModel.therapist?.bio}',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
        heightBox12,
        Text(
          'Therapist Certificats',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '${widget.sessionDataModel.therapist?.achievement}',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
        heightBox12,
        Text(
          'Pricing & Payment',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
          ),
        ),
        heightBox4,
        Text(
          '\$${widget.sessionDataModel.fee} per session',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
