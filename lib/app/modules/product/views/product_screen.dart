import 'package:antoinette/app/modules/product/widgets/product_card.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final bool shouldBackButton;
  static const String routeName = '/product-screen';
  const ProductScreen({super.key, required this.shouldBackButton});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchBar(shouldBackButton: widget.shouldBackButton,shouldfontButton: false,),
                heightBox12,
                SizedBox(
                  width: 200.w,
                  child: Text(
                    'Shop Your Health Must-Haves',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
                heightBox12,
                SizedBox(
                  height: 700.h,
                  child: GridView.builder(
                    itemCount: 12,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.35,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: ProductCard(
                            name: 'Sunscream',
                            price: '50.00',
                            imagePath: AssetsPath.medichine),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

