import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(BuildContext context, String msg, [bool isError = false]) {
  Get.snackbar(
    isError ? 'Error' : 'Success', // Title based on isError
    msg, // Message
    backgroundColor: isError
        ? const Color.fromARGB(255, 82, 81, 81)
        : const Color.fromARGB(153, 135, 237, 138),
    colorText: Colors.white, // Text color for better visibility
    snackPosition: SnackPosition.TOP, // Position at bottom
    margin: EdgeInsets.all(16), // Margin for better appearance
    borderRadius: 8, // Rounded corners
    duration: Duration(seconds: 3), // Duration of snackbar
  );
}