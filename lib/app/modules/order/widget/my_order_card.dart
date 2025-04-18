import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderCard extends StatelessWidget {
  final String productName;
  final String status;
  final String price;
  final String quantity;
  final String imagePath;
  final String secondBTNName;
  final VoidCallback mainBTNOntap;
  final VoidCallback secondBTNOntap;
  final bool isShowSeconBTN;
  const MyOrderCard({
    super.key,
    required this.productName,
    required this.status,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.mainBTNOntap,
    required this.secondBTNOntap,
    required this.isShowSeconBTN, required this.secondBTNName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(AssetsPath.womenBookRead),
                              fit: BoxFit.fill)),
                    ),
                    widthBox8,
                    SizedBox(
                      width: 230.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: 130,
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  productName,
                                  style: GoogleFonts.poppins(fontSize: 15.sp),
                                ),
                              ),
                              Container(
                                height: 23.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black12)),
                                child: Center(
                                    child: Text(
                                  status,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.red),
                                )),
                              )
                            ],
                          ),
                          heightBox12,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$$price',
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                              Text(
                                'Qty: $quantity',
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                heightBox8,
                isShowSeconBTN == false
                    ? InkWell(
                        onTap: mainBTNOntap,
                        child: SizedBox(
                          height: 40,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.iconButtonThemeColor),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                'View Details',
                                style: TextStyle(
                                    color: AppColors.iconButtonThemeColor),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: mainBTNOntap,
                            child: SizedBox(
                              width: 145,
                              height: 40,
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.iconButtonThemeColor),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(
                                        color: AppColors.iconButtonThemeColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: secondBTNOntap,
                            child: SizedBox(
                              width: 145,
                              height: 40,
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.iconButtonThemeColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text(
                                    secondBTNName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
