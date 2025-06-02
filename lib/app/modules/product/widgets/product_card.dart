import 'package:antoinette/app/modules/product/controllers/product_details_controllers.dart';
import 'package:antoinette/app/modules/product/model/all_product_pegination_model.dart';
import 'package:antoinette/app/modules/product/views/product_datails_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatefulWidget {
  final AllProductItemModel productsModel;
  const ProductCard({
    super.key,
    required this.productsModel,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  ProcuctDetailsController procuctDetailsController =
      ProcuctDetailsController();
  bool isLoading = false; // New state to track loading

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : getProductScreen, // Disable tap when loading
      child: Container(
        height: 134.h,
        width: 156.w,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100.h,
                  width: 156.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: widget.productsModel.images.isEmpty
                              ? AssetImage(AssetsPath.demo)
                              : NetworkImage(widget.productsModel.images[0].url ?? ''),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.h),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          widget.productsModel.name!,
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      widthBox4,
                      Text(
                        '₦${widget.productsModel.amount}',
                        style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (isLoading) // Show loader when loading
              Opacity(
                opacity: 0.1,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> getProductScreen() async {
    if (isLoading) return; // Prevent multiple clicks

    setState(() {
      isLoading = true; // Start loading
    });

    print('Hello');
    print(widget.productsModel.name);
    print(widget.productsModel.id);
    final bool isSuccess = await procuctDetailsController
        .getProductDetails(widget.productsModel.id!);

    if (isSuccess) {
      if (mounted) {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: procuctDetailsController.productModel);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, procuctDetailsController.errorMessage!, true);
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }
}