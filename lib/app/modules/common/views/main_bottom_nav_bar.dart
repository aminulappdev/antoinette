import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/home/views/home_screen.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainButtonNavbarScreen extends StatefulWidget {
  static const String routeName = '/mainbottom-nav-screen';

  const MainButtonNavbarScreen({super.key});

  @override
  State<MainButtonNavbarScreen> createState() => _MainButtonNavbarScreenState();
}

class _MainButtonNavbarScreenState extends State<MainButtonNavbarScreen> {
  int selectedKey = 0;

  List<Widget> screens = const [
    HomeScreen(),
    SignInScreen(),
    SignInScreen(),
    SignInScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[selectedKey],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(50.0), // Set the border radius here
                ),
                elevation: 2,
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(color: Colors.black)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedKey = 0;
                          setState(() {});
                        },
                        child: Icon(
                          selectedKey == 0 ? Icons.home : Icons.home_outlined,
                          color: AppColors.iconButtonThemeColor,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedKey = 1;
                          setState(() {});
                        },
                        child: Icon(
                          selectedKey == 1
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          color: AppColors.iconButtonThemeColor,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedKey = 2;
                          setState(() {});
                        },
                        child: Icon(
                          selectedKey == 2
                              ? Icons.list_alt_outlined
                              : Icons.list,
                          color: AppColors.iconButtonThemeColor,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedKey = 3;
                          setState(() {});
                        },
                        child: Icon(
                          selectedKey == 3
                              ? Icons.person
                              : Icons.person_outline,
                          color: AppColors.iconButtonThemeColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: -24,
                  left: 152,
                  right: 152,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(
                          50.0), // Set the border radius here
                    ),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Color(0xffA57EA5),
                        borderRadius: BorderRadius.circular(100),
                        // border: Border.all(color: Colors.black)
                      ),
                      child: Center(
                        child: Icon(
                          Icons.list_alt_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
