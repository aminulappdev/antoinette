import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(BuildContext context, String msg, [bool isError = false]) {
  Get.snackbar(
    isError ? 'Failed' : 'Success', // Title based on isError
    msg, // Message
    backgroundColor: isError
        ? const Color.fromARGB(255, 229, 73, 73)
        : const Color(0xffC37D60),
    colorText: Colors.white, // Text color for better visibility
    snackPosition: SnackPosition.TOP, // Position at bottom
    margin: EdgeInsets.all(16), // Margin for better appearance
    borderRadius: 8, // Rounded corners
    duration: Duration(seconds: 3), // Duration of snackbar
  );
}