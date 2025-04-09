import 'package:antoinette/app/modules/therapy/views/text_therapy_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HealingNoteScreen extends StatefulWidget {
  static const String routeName = '/healing-note-screen';
  const HealingNoteScreen({super.key});

  @override
  State<HealingNoteScreen> createState() => _HealingNoteScreenState();
}

class _HealingNoteScreenState extends State<HealingNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                heightBox24,
                CustomSearchBar(shouldBackButton: false,),
                heightBox12,
                SizedBox(
                  height: 650.h,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, TextTherapyScreen.routeName);
                        },
                        child: Container(
                          height: 66.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8.w),
                            child: Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(image: AssetImage(AssetsPath.doctor),fit: BoxFit.fill)
                                  ),
                                ),
                                widthBox8,
                                Padding(
                                  padding:  EdgeInsets.all(2.0.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Dr. Jane Smith',style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                                      heightBox12,
                                      Text('That sounds tough. Stress from work can ',style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
