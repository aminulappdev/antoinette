import 'package:antoinette/app/app_binding.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:antoinette/app/routes/app_routes.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/services/push%20notification/push_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ First initialize Firebase (only once)
  await Firebase.initializeApp();
 // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Init socket service
  SocketService socketService = Get.put(SocketService());

  // Init Push Notifications (after Firebase is ready)
  await PushNotificationService().init();

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
