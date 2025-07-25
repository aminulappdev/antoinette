import 'package:antoinette/app/modules/product/model/product_details_model.dart';
import 'package:antoinette/app/modules/product/views/check_out_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/product_caresoul_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart'; 

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel; 
  static const String routeName = '/product-details-screen';
  const ProductDetailScreen({super.key, required this.productModel, });

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // bool _isExpandedProduct = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox24,
              CustomAppBar(name: 'Product Details'),
              heightBox12,
           HomeCarouselSlider(images: widget.productModel.images ?? []),
    
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: 280.w,
                    child: Text(
                      '${widget.productModel.name}',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  Text(
                    '₦${widget.productModel.amount}',
                    style: GoogleFonts.roboto(
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
              Html(data: widget.productModel.description),
           
                         heightBox12,
               Container(
                height: 70.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text('₦${widget.productModel.amount}',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        width: 159.w,
                        height: 42.h,
                        child: GradientElevatedButton(
                            onPressed: () {
                              //  Navigator.pushNamed(context, CheckOutScreen.routeName,arguments: widget.productModel);
                              Navigator.pushNamed(context, CheckOutScreen.routeName,arguments: widget.productModel);
                              print('Product id : ${widget.productModel.id}');
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
    );
  }


}
