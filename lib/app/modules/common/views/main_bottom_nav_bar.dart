import 'package:antoinette/app/modules/common/views/panic_button_screen.dart';
import 'package:antoinette/app/modules/dear_diary/views/dear_diary_screen.dart';
import 'package:antoinette/app/modules/home/views/home_screen.dart';
import 'package:antoinette/app/modules/product/views/product_screen.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/views/profile_screen.dart';
import 'package:antoinette/app/modules/chatting/views/healing_note_screen.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class MainButtonNavbarScreen extends StatefulWidget {
  static  String routeName = '/mainbottom-nav-screen';

   const MainButtonNavbarScreen({super.key});

  @override
  State<MainButtonNavbarScreen> createState() => _MainButtonNavbarScreenState();
}

class _MainButtonNavbarScreenState extends State<MainButtonNavbarScreen> {
  int selectedKey = 0;
  
  
  List<Widget> screens = [
    const HomeScreen(),
    const ProductScreen(
      shouldBackButton: false,
    ),
    const HealingNoteScreen(),
    const ProfileScreen(),
    const DearDiaryScreen(),
  
  ];
   
   @override
  void initState() {
    Get.find<ProfileController>().getProfileData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, PanicButtonScreen.routeName);
        },
        child: Container(
          height: 60.h,
          width: 60.w,
          
          decoration: BoxDecoration(
            color: AppColors.iconButtonThemeColor,
            //  color: Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
          child: Center(
            child: Text('Panic',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
          ),
        ),
      ),
      body: screens[selectedKey],
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(12.0.h),
        child: Stack(
          
          clipBehavior: Clip.none,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(50.0.r), // Set the border radius here
              ),
              elevation: 2,
              child: Container(
                height: 75.h,
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
                        size: 28.sp,
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
                        size: 28.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedKey = 2;
                        setState(() {});
                      },
                      child: Icon(
                        selectedKey == 2 ? Icons.list_alt_outlined : Icons.list,
                        color: AppColors.iconButtonThemeColor,
                        size: 28.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedKey = 3;
                        setState(() {});
                      },
                      child: Icon(
                        selectedKey == 3 ? Icons.person : Icons.person_outline,
                        color: AppColors.iconButtonThemeColor,
                        size: 28.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -24.h,
              left: 152.w,
              right: 152.w,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 2),
                  borderRadius:
                      BorderRadius.circular(50.0), // Set the border radius here
                ),
                child: GestureDetector(
                  onTap: () {
                    selectedKey = 4;
                    setState(() {});
                  },
                  child: Container(
                    height: 55.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      color: Color(0xffA57EA5),
                      borderRadius: BorderRadius.circular(100),
                      // border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
