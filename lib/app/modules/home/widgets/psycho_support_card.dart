
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PsychoSupportCard extends StatelessWidget {
  final String status;
  final String time;
  final String price;
  final String imagePath;
  final String title;
  const PsychoSupportCard({
    super.key, required this.status, required this.time, required this.price, required this.imagePath, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: 237,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            height: 133,
            width: 237,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AssetsPath.psycoSupport,
                    ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: Colors.green),
                  ),
                  heightBox50,
                  heightBox30,
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duration: $time mins',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        ' Per session: \$$price',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 2),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: 18,
                ),
                widthBox4,
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}