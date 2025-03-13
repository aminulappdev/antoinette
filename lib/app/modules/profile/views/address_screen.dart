import 'package:antoinette/app/modules/profile/views/add_address.dart';
import 'package:antoinette/app/modules/profile/widgets/address_card.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdderssScreen extends StatelessWidget {
  static const String routeName = '/profile-address-screen';
  const AdderssScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.all(16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(name: 'Address'),
              heightBox12,
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AddAdderssScreen.routeName);
                },
                child: Container(
                  height: 66.h,
                  width: 263.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Add address',
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp, color: Color(0xff626262)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              heightBox14,
              AddressCardWidget(
                name: 'Home',
                address: '123 Main Street, Berlin, Germany, 10115',
                editOntap: () {},
                isShowBatch: true,
              ),
              heightBox12,
              AddressCardWidget(
                name: 'Office',
                address: '123 Main Street, Berlin, Germany, 10115',
                editOntap: () {},
                isShowBatch: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

