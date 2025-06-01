import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _movetoNewScreen();
    super.initState();
  }

  Future<void> _movetoNewScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn = box.read('user-login-access-token') != null;
    Navigator.pushReplacementNamed(
      context,
      isLoggedIn
          ? MainButtonNavbarScreen.routeName
          : OnboardingScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset(
        AssetsPath.spBackground,
        fit: BoxFit.fill,
      ),
    );
  }
}
