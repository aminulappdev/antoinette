import 'dart:async';
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
      title: "Time's up!",
      middleText: "Your check-in time has expired.",
      onConfirm: () => Get.back(),
      textConfirm: "OK",
    );
  }

  // Stop the countdown manually
  void stopCountdown() {
    _timer.cancel();
  }

  @override
  void onClose() {
    super.onClose();
    // Ensure timer is stopped when the controller is disposed
    _timer.cancel();
  }
}
