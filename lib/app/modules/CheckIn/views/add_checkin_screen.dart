import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antoinette/app/modules/checkIn/views/custom_status_screen.dart';
import 'package:antoinette/app/modules/checkIn/widgets/add_checkIn_feature.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/toggle_button.dart';

class AddCheckInScreen extends StatefulWidget {
  static const String routeName = '/add-check-screen';
  const AddCheckInScreen({super.key});

  @override
  State<AddCheckInScreen> createState() => _AddCheckInScreenState();
}

class _AddCheckInScreenState extends State<AddCheckInScreen> {
  bool togggleActive = false;
  bool isToggled = false;
  int hours = 0, minutes = 15, seconds = 0;
  Duration _selectedDuration = const Duration(minutes: 15);
  late final Timer _timer; // Ensure _timer is initialized

  // Initialize timer (if needed) in your screen lifecycle
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    });
  }

  // Dispose the timer when widget is removed from widget tree
  @override
  void dispose() {
    _timer.cancel();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(name: 'Add Check-In'),
              heightBox12,
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 22.sp,
                  ),
                  widthBox4,
                  Text(
                    'Set Check-In Timer',
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  )
                ],
              ),
              Container(
                height: 230.h,
                color: Colors.transparent,
                child: CupertinoTimerPicker(
                  
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: _selectedDuration,
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() {
                      _selectedDuration = newDuration;
                    });
                  },
                ),
              ),
              heightBox12,
              Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 22.sp,
                  ),
                  widthBox4,
                  Text(
                    'Quick Check-In',
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  )
                ],
              ),
              heightBox12,
              Row(
                children: [
                  AddCheckInFeature(
                    icon: '🏍️',
                    feature: 'Going on ',
                  ),
                  widthBox12,
                  AddCheckInFeature(
                    icon: '🏍️',
                    feature: 'Going on',
                  ),
                ],
              ),
              heightBox12,
              Row(
                children: [
                  AddCheckInFeature(
                    icon: '🏍️',
                    feature: 'Going on ',
                  ),
                  widthBox12,
                  AddCheckInFeature(
                    icon: '🏍️',
                    feature: 'Going on',
                  ),
                ],
              ),
              heightBox12,
              AddCheckInFeature(
                icon: '🏍️',
                feature: 'Going on',
              ),
              heightBox12,
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 22.h,
                  ),
                  widthBox4,
                  Text(
                    'Set Check-In Timer',
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  )
                ],
              ),
              heightBox12,
              Row(
                children: [
                  ToggleButton(
                    isToggled: isToggled,
                    onToggle: (bool value) {
                      setState(() {
                        isToggled = value; // Handle toggle state change
                      });
                    },
                  ),
                  widthBox4,
                  Text('sunan 01975566236')
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              GradientElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, CustomStatusScreen.routeName);
                },
                text: 'Check-In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
