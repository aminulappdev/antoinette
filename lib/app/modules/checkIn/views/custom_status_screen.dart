import 'package:antoinette/app/modules/checkIn/views/add_checkin_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStatusScreen extends StatefulWidget {
  static const String routeName = '/custom-status-screen';
  const CustomStatusScreen({super.key});

  @override
  State<CustomStatusScreen> createState() => _CustomStatusScreenState();
}

class _CustomStatusScreenState extends State<CustomStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.r),
          child: Column(
            children: [
              CustomAppBar(name: 'Custom status'),
              heightBox12,
              Row(children: [
                Icon(Icons.add,size: 18.h,),
                widthBox8,
                Text('Add Custom Status',style: GoogleFonts.poppins(fontSize: 14.sp),)
              ],),
              heightBox12,
              TextFormField(),
              SizedBox(height: 50.h,),
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
