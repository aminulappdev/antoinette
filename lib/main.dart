import 'dart:io';

import 'package:antoinette/app/app_binding.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:antoinette/app/routes/app_routes.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/services/push%20notification/push_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);

  // Init socket service
  SocketService socketService = Get.put(SocketService());

  // Init push notifications (includes permission request)
  await PushNotificationService().init();

  // Init FCM token
  await _initFCMToken();

  // Init local storage
  await GetStorage.init();

  // Init socket
  await socketService.init();

  runApp(const AntoinetteApp());
}

class AntoinetteApp extends StatelessWidget {
  const AntoinetteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: ControllerBinder(),
          debugShowCheckedModeBanner: false,
          title: 'antoinette',
          theme: ThemeData(
            primaryColor: const Color(0xffA57EA5).withOpacity(0.1),
            scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
            inputDecorationTheme: inputDecoration(),
            useMaterial3: true,
            fontFamily: 'Poppins',
            textTheme: const TextTheme(),
          ),
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.appRoutes,
        );
      },
    );
  }
}

InputDecorationTheme inputDecoration() {
  return InputDecorationTheme(
    hintStyle: const TextStyle(fontWeight: FontWeight.w300),
    fillColor: Colors.transparent,
    filled: true,
    border: inputBorder(),
    enabledBorder: inputBorder(),
    focusedBorder: inputBorder(),
    errorBorder: inputBorder(),
  );
}

OutlineInputBorder inputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xffCACACA), width: 1),
    borderRadius: BorderRadius.circular(14),
  );
}

Future<void> _initFCMToken() async {
  debugPrint("📡 Starting FCM token initialization...");

  if (Platform.isIOS) {
    // Request notification permissions for iOS
    final permission = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint("📝 iOS Notification Permission: ${permission.authorizationStatus}");

    // Try to get APNs token with retries
    String? apnsToken;
    for (int i = 0; i < 3; i++) {
      apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      debugPrint("📡 Attempt ${i + 1} - APNs token: $apnsToken");
      if (apnsToken != null) break;
      await Future.delayed(const Duration(seconds: 2)); // Wait before retry
    }

    if (apnsToken == null) {
      debugPrint("⚠️ Failed to get APNs token after retries");
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        debugPrint("📱 iOS FCM Token (via refresh): $newToken");
      });
      return;
    }
  }

  // Get FCM token for iOS (if APNs token exists) or Android
  final fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("📱 FCM Token: $fcmToken");

  // Listen for token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    debugPrint("🔄 FCM Token Refreshed: $newToken");
  });
}