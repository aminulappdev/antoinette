import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key, required this.sessionId});
  // final SessionDataModel sessionDataModel; 
  final String sessionId;
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  final SessionDetailsController sessionDetailsController =
      Get.find<SessionDetailsController>();

  @override
  void initState() {
    sessionDetailsController.getSessionDetails(widget.sessionId);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionDetailsController>(
      builder: (controller) {
        if (controller.inProgress) {
            return Center(child: CircularProgressIndicator());
          }
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
              '${controller.sessionModel?.description}',
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
              '${controller.sessionModel?.therapist?.bio}',
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
              '${controller.sessionModel?.therapist?.achievement}',
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
              '₦${controller.sessionModel?.fee} per session',
              style: GoogleFonts.roboto(
                fontSize: 12.sp,
              ),
            ),
          ],
        );
      }
    );
  }
}
