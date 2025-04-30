import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/onboarding/views/pannic_button/pannic_page_view.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PannicOnboardingScreen extends StatefulWidget {
  static const String routeName = '/pannic-onboarding-screen';

  const PannicOnboardingScreen({super.key});

  @override
  State<PannicOnboardingScreen> createState() => _PannicOnboardingScreenState();
}

class _PannicOnboardingScreenState extends State<PannicOnboardingScreen> {
  List<String> buttonTexts = [
    'Next',
    'Next',
    'Enter App'
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(
                () {
                  _currentPage = index;
                },
              );
            },
            children: [
              PannicOnboardingPage(
                showBackButton: false,
  
                onBoardingRow: false,
      
                pageController: _pageController,
                content: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 600,
                    child: ListView(
                      children: [
                        Text(
                          '1. What is the Panic Button?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        bulletPoint(
                            'The Panic Button is a safety feature designed to alert your trusted contacts when you\'re in a potential emergency situation.'),
                        SizedBox(height: 20),
                        Text(
                          '2. How does it work?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        numberPoint(
                            '1. If you ever feel threatened or unsafe, press and hold the Panic Button in the app for 3 seconds.'),
                        numberPoint(
                            '2. After 3 seconds, a popup will appear asking "Are you safe?" with two options:'),
                        bulletPoint(
                            'Yes: If you are safe, press Yes — no alert will be sent.'),
                        bulletPoint(
                            'No: If you are in danger, press No — an immediate alert with your last known location will be sent to your trusted contacts.'),
                        SizedBox(height: 10),
                        Text(
                          'They will receive a message with your last known location and an urgent message to take action.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PannicOnboardingPage(
                showBackButton: true,
          
                onBoardingRow: true,
              
               
                pageController: _pageController,
                content: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 600,
                    child: ListView(
                      children: [
                        Text(
                          '3. What happens after you press the Panic Button?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        bulletPoint(
                            'Your trusted contacts will receive an alert message that includes:'),
                        bulletPoint(
                            'Your current location (with a Google Maps link).'),
                        bulletPoint(
                            'A danger alert so they know to act immediately.'),
                        bulletPoint(
                            'An SOS-style message indicating you\'re in an emergency.'),
                        SizedBox(height: 20),
                        Text(
                          '4. Why it’s important:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        bulletPoint(
                            'The Panic Button ensures that someone is always alerted when you need help, even if you can’t call them yourself.'),
                        bulletPoint(
                            'It’s a quick and easy way to send a help request with minimal effort.'),
                      ],
                    ),
                  ),
                ),
              ),
              PannicOnboardingPage(
                showBackButton: true,
             
                onBoardingRow: false,
               
                pageController: _pageController,
                content: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 600,
                    child: ListView(
                      children: [
                        Text(
                          '5. Remember:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        bulletPoint(
                            'It’s a quick and easy way to send a help request with minimal effort.'),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Next Steps',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Go ahead and set your trusted contacts in the app to ensure they\'re ready for emergencies.',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 80.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Here’s how the Panic Button works:',
                  style: TextStyle(
                      color: AppColors.iconButtonThemeColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                heightBox5,
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 6.0.h,
                    dotWidth: 100.0.w,
                    spacing: 10.0,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.iconButtonThemeColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 50.h,
            child: Padding(
              padding: EdgeInsets.all(15.0.h),
              child: GestureDetector(
                onTap: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      buttonTexts[_currentPage],
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp, color: Color(0xffA074A0)),
                    ),
                    widthBox4,
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.iconButtonThemeColor,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget numberPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(text, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
