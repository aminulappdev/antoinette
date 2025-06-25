import 'dart:async';
import 'package:antoinette/app/modules/checkIn/controllers/check_in_response_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CountdownController extends GetxController {
  final CheckInRequestController checkInRequestController =
      CheckInRequestController();

  Rx<Duration> remainingTime = Duration(minutes: 15).obs;
  Timer? _timer;

  String? _checkId;

  // ✅ Getter
  String? get checkinID => _checkId;

  // ✅ Setter
  set checkinID(String? value) {
    _checkId = value;
    update();
  }

  // ✅ Start countdown
  void startCountdown(Duration duration) {
    remainingTime.value = duration;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds > 0) {
        remainingTime.value -= Duration(seconds: 1);
      } else {
        stopCountdown();
        showTimeUpDialog();
      }
    });
  }

  // ✅ Show dialog when time's up
  void showTimeUpDialog() {
    if (Get.isDialogOpen == true) return;

    Get.defaultDialog(
      title: "Check-In Time's Up!",
      middleText: "Are you Safe?",
      barrierDismissible: false,
      actions: [
        GestureDetector(
          onTap: () {
            if (Get.isDialogOpen == true) {
              Get.back(); // Close the dialog
            }
            print("User pressed YES");
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.r),
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
          onTap: () async {
            final bool isSuccess =
                await checkInRequestController.checkInRequest(_checkId ?? '');

            if (isSuccess) {
              Get.back();
              Get.snackbar(
                "Success",
                "Sms sent to all trusted contacts",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Color(0xffC37D60),
                colorText: Colors.white,
              );
              print("Check in done.....");
            } else {
              Get.snackbar(
                "Failed",
                "Could not send SMS to trusted contacts",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
              print("Check in not work.....");
            }

        
            print("User pressed NO");
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.r),
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

  // ✅ Stop countdown
  void stopCountdown() {
    _timer?.cancel();
  }

  // ✅ Clear timer on controller dispose
  @override
  void onClose() {
    super.onClose();
    stopCountdown();
  }
}
