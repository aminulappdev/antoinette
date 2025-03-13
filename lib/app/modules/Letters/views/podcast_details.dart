import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PodcastDetailsScreen extends StatefulWidget {
  static const String routeName = '/podcast-details-screen';
  const PodcastDetailsScreen({super.key});

  @override
  State<PodcastDetailsScreen> createState() => _PodcastDetailsScreenState();
}

class _PodcastDetailsScreenState extends State<PodcastDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundColor: Color(0xff000000).withOpacity(0.1),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundColor: Color(0xff000000).withOpacity(0.1),
                      child: Icon(
                        Icons.favorite_border_sharp,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              heightBox16,
              Container(
                height: 274.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: AssetImage(AssetsPath.womenBookRead),
                      fit: BoxFit.fill),
                ),
              ),
              heightBox8,
              Text(
                'The Science of Self-Care',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Author: Dr. Sophia Williams',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  Text(
                    'Published Date: Feb 7, 2025',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                ],
              ),
              heightBox100,
              heightBox100,
              heightBox50,
              heightBox30,
              Text(
                'Next',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 4.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, PodcastDetailsScreen.routeName);
                  },
                  child: Container(
                    height: 104.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 84.h,
                            width: 73.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: AssetImage(AssetsPath.womenBookRead),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          widthBox4,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 120.w,
                                child: Text(
                                  'The Science of Self-Care',
                                  style: GoogleFonts.poppins(fontSize: 16.sp),
                                ),
                              ),
                              SizedBox(
                                width: 180.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: 64.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Center(
                                        child: Text(
                                          'Episod 12',
                                          style:
                                              GoogleFonts.poppins(fontSize: 10.sp),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: 64.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Center(
                                        child: Text(
                                          '12 min',
                                          style:
                                              GoogleFonts.poppins(fontSize: 10.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          widthBox40,
                          CircleAvatar(
                            radius: 21.r,
                            backgroundColor: Color(0xffA57EA5),
                            child: Icon(Icons.play_arrow),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
