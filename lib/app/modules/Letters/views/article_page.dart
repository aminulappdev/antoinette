import 'package:antoinette/app/modules/letters/views/article_details_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended for You',
              style: GoogleFonts.poppins(fontSize: 20.sp),
            ),
            SizedBox(
              height: 536.h,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 2.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ArticleDetailsScreen.routeName);
                      },
                      child: Container(
                        height: 200.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AssetsPath.womenBookRead)),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding:  EdgeInsets.all(12.0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 27.h,
                                width: 82.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        222, 255, 255, 255)),
                                child: Center(
                                    child: Text(
                                  'Mental Health',
                                  style: GoogleFonts.poppins(fontSize: 10.sp),
                                )),
                              ),
                              SizedBox(
                                height: 120.h,
                              ),
                              Text('Mind & Body Space',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.sp, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
