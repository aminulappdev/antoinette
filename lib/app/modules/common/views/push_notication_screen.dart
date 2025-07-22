import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PushNotificationScreen extends StatelessWidget {
  static const String routeName = '/notification-screen';

  const PushNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Center(
          child: Text(
            'Your notifications will appear here!',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }
}