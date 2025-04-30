import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PannicOnboardingPage extends StatelessWidget {

  final bool onBoardingRow;
  final bool showBackButton;
  
  final PageController pageController; 
  final Widget content;

  const PannicOnboardingPage({
    super.key,
 
    required this.onBoardingRow,
   
    required this.showBackButton,
    required this.pageController, required this.content, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            heightBox20,
            Visibility(
              visible: !showBackButton,
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {          
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(162, 243, 213, 248),
                      radius: 24.r,
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: AppColors.iconButtonThemeColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: AppColors.iconButtonThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            heightBox100,
          
            content
          ],
        ),
      ),
    );
  }
}
