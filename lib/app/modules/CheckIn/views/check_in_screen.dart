import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckInScreen extends StatefulWidget {
  static const String routeName = '/chek-in-screen';
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            children: [
              CustomAppBar(name: 'Check In'),
              heightBox12,
              Container(
                height: 69.sp,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.push_pin,color: Colors.orange,),
                      widthBox8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Taking a Ride',
                            style: GoogleFonts.poppins(fontSize: 15.sp),
                          ),
                          Row(
                  
                            children: [
                              Icon(
                                Icons.call_outlined,
                                size: 18.h,
                              ),
                              widthBox4,
                              Text(
                                'Sunan - 01975265553',
                                style: GoogleFonts.poppins(fontSize: 12.sp),
                              ),
                            ],
                          )
                        ],
                      ),
                     SizedBox(width: 90.w,),
                      
                      Text(
                        'Yesterday',
                        style: GoogleFonts.poppins(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 500.h,),
              GradientElevatedButton(onPressed: () {
                Navigator.pushNamed(context, AddCheckInScreen.routeName);
              }, text: '+ Add Check-In')
            ],
          ),
        ),
      ),
    );
  }
}
