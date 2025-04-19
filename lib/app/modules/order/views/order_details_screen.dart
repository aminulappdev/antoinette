import 'package:antoinette/app/modules/product/widgets/price_row.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details-screen';
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox20,
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
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
                                          image: AssetImage(
                                              AssetsPath.womenBookRead),
                                          fit: BoxFit.fill)),
                                ),
                                widthBox8,
                                SizedBox(
                                  width: 230.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            width: 130,
                                            child: Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              'productName',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.sp),
                                            ),
                                          ),
                                          Container(
                                            height: 23.h,
                                            width: 70.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: Center(
                                                child: Text(
                                              'status',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.red),
                                            )),
                                          )
                                        ],
                                      ),
                                      heightBox12,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14.sp),
                                          ),
                                          Text(
                                            'Qty: ',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  heightBox10,
                  Text('Order Id : 156tfhgng'),
                  heightBox4,
                  Text('Order Id : 156tfhgng'),
                  heightBox4,
                  Text('Order Id : 156tfhgng'),
                  heightBox4,
                  Text('Order Id : 156tfhgng'),
                  heightBox4,
                  Text('Order Id : 156tfhgng'),
                  heightBox4,
                  PriceRow(name: 'esf', price: 'price', nameSize:  14, priceSize: 14),
                  PriceRow(name: 'esf', price: 'price', nameSize:  14, priceSize: 14),
                  PriceRow(name: 'esf', price: 'price', nameSize:  14, priceSize: 14),
                  PriceRow(name: 'esf', price: 'price', nameSize:  14, priceSize: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
