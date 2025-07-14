import 'package:antoinette/app/modules/letters/views/letter_bar.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LetterScreen extends StatefulWidget {
  static const String routeName = '/letter-screen';
  const LetterScreen({super.key});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox24,
            Padding(
              padding:  EdgeInsets.all(8.0.h),
              child: CustomAppBar(name: 'Letters to you'),
            ),
            LetterBar(),           
          ],
        ),
      ),
    );
  }
}