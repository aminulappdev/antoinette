import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/profile-account-screen';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(name: 'Account'),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(AssetsPath.womenBookRead),
                  ),
                  widthBox8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aminul',
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      Text(
                        'aminul@gmail.com',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Color(0xff626262)),
                      ),
                    ],
                  )
                ],
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Full Name',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: AppColors.iconButtonThemeColor,
                    size: 18,
                  )
                ],
              ),
              heightBox4,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Aminul Islam'
                ),
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: AppColors.iconButtonThemeColor,
                    size: 18,
                  )
                ],
              ),
              heightBox4,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'aminul@gmail.com'
                ),
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: AppColors.iconButtonThemeColor,
                    size: 18,
                  )
                ],
              ),
              heightBox4,
              TextFormField(
                decoration: InputDecoration(
                
                ),

              ),

              SizedBox(height: 200,),
              GradientElevatedButton(onPressed: () {
                
              }, text: 'Save')

            ],
          ),
        ),
      ),
    );
  }
}
