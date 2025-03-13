import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PanicButtonScreen extends StatefulWidget {
  static const String routeName = '/panic-button-screen';

  const PanicButtonScreen({super.key});

  @override
  State<PanicButtonScreen> createState() => _PanicButtonScreenState();
}

class _PanicButtonScreenState extends State<PanicButtonScreen> {
  bool isPressed = false; // Track whether the button is activated
  late Timer _timer; // Timer to check long press duration
  bool isHolding = false; // To track if button is being held


  void _onLongPressEnd(LongPressEndDetails details) {
    if (_timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      isHolding = false; // Stop the long press tracking
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                   Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Color(0xffA57EA5).withOpacity(0.1),
                  child: Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'Are you in danger?',
              style: GoogleFonts.poppins(
                  fontSize: 32.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Hold for 3 seconds to send an alert.',
              style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 150.h),
            GestureDetector(
              onLongPress: _onLongPress, 
              onLongPressEnd: _onLongPressEnd, 
              child: Container(
                height: 217.h,
                width: 217.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPressed ? Colors.green : Color(0xffFA7875),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    isPressed ? 'Alert Sent!' : 'Panic Button',
                    style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  
  void _onLongPress() {
    setState(() {
      isHolding = true;
    });

    _timer = Timer(Duration(seconds: 2), () {
      if (isHolding) {
        setState(() {
          isPressed = true;
        });

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(
                child: Text('Are you OK?',
                    style: GoogleFonts.poppins(fontSize: 20))),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    isPressed = false; // Reset if user presses YES
                  });
                },
                child: Container(
                  height: 32.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff305FA1).withOpacity(0.1),
                    border: Border.all(color: Color(0xff305FA1)),
                  ),
                  child: Center(
                    child: Text(
                      'YES',
                      style: TextStyle(color: Color(0xff305FA1), fontSize: 14),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Handle NO action (can add an emergency function here)
                },
                child: Container(
                  height: 32.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffA13430).withOpacity(0.1),
                    border: Border.all(color: Color(0xffA13430)),
                  ),
                  child: Center(
                    child: Text(
                      'NO',
                      style: TextStyle(color: Color(0xffA13430), fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
