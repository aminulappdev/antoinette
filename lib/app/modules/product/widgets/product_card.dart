import 'package:antoinette/app/modules/product/views/check_out_screen.dart';
import 'package:antoinette/app/modules/product/views/product_datails_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  const ProductCard({
    super.key, required this.name, required this.price, required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        Navigator.pushNamed(context, ProductDetailScreen.routeName);
      },
      child: Container(
        height: 134,
        width: 156,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 156,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        imagePath,
                      ),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.all(8.0.h),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  widthBox4,
                  Text(
                    '\$$price',
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
      ),
    );
  }
}