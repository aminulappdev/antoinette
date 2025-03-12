import 'package:antoinette/app/modules/CheckIn/views/check_in_screen.dart';
import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/product/widgets/product_card.dart';
import 'package:antoinette/app/modules/product/widgets/policy_custom_row.dart';
import 'package:antoinette/app/modules/product/widgets/see_more_button.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/product_caresoul_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details-screen';
  const ProductDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isExpandedProduct = false;
  bool _isExpandedPolicy = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Product Details'),
                heightBox12,
                HomeCarouselSlider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sunscreen',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      '\$89.99',
                      style: GoogleFonts.poppins(
                          fontSize: 16.h, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                heightBox8,
                Text(
                  'Product Details',
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                heightBox4,
                AnimatedCrossFade(
                  firstChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Name: UltraShield SPF 50+ Sunscreen'),
                      Text('Brand: SunGuard'),
                      Text('Type: Broad-Spectrum Protection'),
                      Text('SPF: 50+'),
                      Text('Formulation: Lotion'),
                      Text('Volume: 150 ml'),
                      Text('Price: \$18.99'),
                      Text(
                          'Key Ingredients: Avobenzone, Octinoxate, Titanium Dioxide'),
                      Text('Water Resistance: Up to 80 minutes'),
                      Text(
                          'Application: Apply generously on all exposed skin areas 15 minutes before sun exposure. Reapply every 2 hours or after swimming or sweating.'),
                      Text(
                          'Benefits: Helps prevent sunburn, premature skin aging, and skin cancer. Suitable for all skin types, including sensitive skin.'),
                    ],
                  ),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Name: UltraShield SPF 50+ Sunscreen'),
                      Text('Brand: SunGuard'),
                      Text('Type: Broad-Spectrum Protection'),
                      Text('SPF: 50+'),
                      Text('Formulation: Lotion'),
                      Text('Volume: 150 ml'),
                     
                    ],
                  ),
                  crossFadeState: _isExpandedProduct
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 300),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpandedProduct = !_isExpandedProduct;
                    });
                  },
                  child: SeeMoreButton(
                    isExpanded: _isExpandedProduct,
                  ),
                ),
                heightBox4,
                AnimatedCrossFade(
                  firstChild: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PolicyCustomRow(
                          name: 'Warranty Policy',
                          routeName: SignInScreen.routeName,
                        ),
                        PolicyCustomRow(
                          name: 'Return & Refund Policy',
                          routeName: SignInScreen.routeName,
                        ),
                        PolicyCustomRow(
                          name: 'Replacement Policy',
                          routeName: SignInScreen.routeName,
                        ),
                        PolicyCustomRow(
                          name: 'Return & Refund Policy',
                          routeName: SignInScreen.routeName,
                        ),
                        PolicyCustomRow(
                          name: 'Replacement Policy',
                          routeName: SignInScreen.routeName,
                        ),
                        
                      ],
                    ),
                  ),
                  secondChild: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PolicyCustomRow(
                          name: 'Warranty Policy',
                          routeName: SignInScreen.routeName,
                        ),
                        PolicyCustomRow(
                          name: 'Return & Refund Policy',
                          routeName: SignInScreen.routeName,
                        ),
                        PolicyCustomRow(
                          name: 'Replacement Policy',
                          routeName: SignInScreen.routeName,
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: _isExpandedPolicy
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 300),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpandedPolicy = !_isExpandedPolicy;
                        });
                      },
                      child: SeeMoreButton(
                        isExpanded: _isExpandedPolicy,
                      )),
                ),
                Text(
                  'You might also like',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                heightBox8,
                SizedBox(
                  height: 134,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: ProductCard(
                          name: 'Sunscreen',
                          price: '49.99',
                          imagePath: AssetsPath.medichine,
                        ),
                      );
                    },
                  ),
                ),
                heightBox12,
                 Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: 159,
                          height: 42,
                          child: GradientElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, CheckInScreen.routeName);
                              }, text: 'Buy now'),
                        ),
                      ),
                    ],
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
