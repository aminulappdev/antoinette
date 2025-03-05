import 'package:antoinette/app/utils/assets_path.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffD9A48E),
      body: Center(child: Image(image: AssetImage(AssetsPath.spLogo)),),
    );
  }
}    

