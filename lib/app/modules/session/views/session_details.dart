
import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/modules/session/views/session_bar.dart';
import 'package:antoinette/app/modules/session/views/session_form_section.dart';
import 'package:antoinette/app/modules/session/widgets/session_schedule.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

class SessionDetailsScreen extends StatefulWidget {
  static const String routeName = '/session-details-screen';
  const SessionDetailsScreen({super.key, required this.sessionDataModel});
   final SessionDataModel sessionDataModel; 

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Session Details'),
                heightBox12,
                Container(
                  height: 200.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                        image: AssetImage(AssetsPath.session),
                        fit: BoxFit.fill),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.sessionDataModel.title}',
                      style: GoogleFonts.poppins(fontSize: 15.sp),
                    ),
                    SizedBox(
                      width: 70.w,
                      child: RichText(
                          text: TextSpan(
                              text: '\$${widget.sessionDataModel.fee}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 12.sp, color: Colors.black),
                              children: [
                            TextSpan(
                              text: ' per session',
                              style: GoogleFonts.poppins(
                                  fontSize: 12.sp, color: Colors.black),
                            )
                          ])),
                    )
                  ],
                ),
                SessionSchedule(
                  date: 'Monday to Friday',
                  time: '9:00 AM – 3:30 PM ',
                  address:
                      '${widget.sessionDataModel.location}',
                ),
                heightBox8,
                SessionBar(
               sessionDataModel: widget.sessionDataModel,   
                ),
                heightBox12,
                GradientElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SessionFormScreen.routeName);
                    },
                    text: 'Book now')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
