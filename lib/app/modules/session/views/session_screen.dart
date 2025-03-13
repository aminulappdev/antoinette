import 'package:antoinette/app/modules/home/widgets/psycho_support_card.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionScreen extends StatefulWidget {
  static const String routeName = '/session-screen';
  const SessionScreen({
    super.key,
  });

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSearchBar(
                  shouldBackButton: true,
                  shouldfontButton: false,
                ),
                heightBox12,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 200.w,
                    child: Text(
                      'Shop Your Health Must-Haves',
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                  ),
                ),
                heightBox12,
                SizedBox(
                  height: 700.h, 
                  width: 245.w,                             
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 6.h),
                        child: PsychoSupportCard(
                          status: 'Available',
                          price: '500',
                          time: '60',
                          imagePath: AssetsPath.doctor,
                          title: 'Find Balance & Clarity',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
