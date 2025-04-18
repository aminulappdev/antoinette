import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CountdownController extends GetxController {
  Rx<Duration> remainingTime = Duration(minutes: 15).obs;
  late Timer _timer;

  // This method starts the countdown
  void startCountdown(Duration duration) {
    remainingTime.value = duration;  // Set the initial duration

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds > 0) {
        remainingTime.value -= Duration(seconds: 1);  // Decrease time by 1 second
      } else {
        _timer.cancel();
        showTimeUpDialog();  // Show time-up dialog when time is finished
      }
    });
  }

  // Show the time-up dialog
 void showTimeUpDialog() {
  Get.defaultDialog(
    title: "Chek-In Time's up!",
    middleText: "Are you Ok?",
    barrierDismissible: false, 
    actions: [
     
      GestureDetector(
        onTap: () {
          Get.back();
          print("User pressed YES");     
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10.r)
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.h),
          
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      SizedBox(width: 10.w),
    
      GestureDetector(
        onTap: () {
          Get.back(); 
          print("User pressed NO");    
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.r)
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
         
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ],
  );
}

  void stopCountdown() {
    _timer.cancel();
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }
}
