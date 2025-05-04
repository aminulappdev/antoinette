import 'dart:async';
import 'package:antoinette/app/modules/checkIn/controllers/check_in_response_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CountdownController extends GetxController {
  final CheckInRequestController checkInRequestController =
      CheckInRequestController();

  Rx<Duration> remainingTime = Duration(minutes: 15).obs;
  late Timer _timer;

  String? _checkId;

  // ✅ Getter
  String? get checkinID => _checkId;

  // ✅ Setter
  set checkinID(String? value) {
    _checkId = value;
    update();
  }

  // This method starts the countdown
  void startCountdown(Duration duration) {
    remainingTime.value = duration;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds > 0) {
        remainingTime.value -= Duration(seconds: 1);
      } else {
        _timer.cancel();
        showTimeUpDialog(); // When time ends
      }
    });
  }

  // Show the time-up dialog
  void showTimeUpDialog() {
    Get.defaultDialog(
      title: "Check-In Time's Up!",
      middleText: "Are you OK?",
      barrierDismissible: false,
      actions: [
        GestureDetector(
          onTap: () async {
            final bool isSuccess =
                await checkInRequestController.checkInRequest(_checkId ?? '');

            if (isSuccess) {
              print("Check in done.....");
            } else {
              print("Check in not work.....");
            }
            Get.back();
            print("User pressed YES");
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10.r)),
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
            print("User pressed NO");
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10.r)),
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
