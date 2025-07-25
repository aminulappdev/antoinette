import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/order/controllers/cancel_order_controller.dart';
import 'package:antoinette/app/modules/order/controllers/order_details_controller.dart';
import 'package:antoinette/app/modules/order/views/oder_screen.dart';

import 'package:antoinette/app/modules/product/widgets/price_row.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  static const String routeName = '/order-details-screen';
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrderDetailsController orderDetailsController =
      Get.find<OrderDetailsController>();
  final CancelOrderController cancelOrderController =
      Get.find<CancelOrderController>();

  @override
  void initState() {
    orderDetailsController.getOrderDetails(widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(
            context,
            MyOrderScreen.routeName,
          );
          return Future.value(false);
        },
        child: GetBuilder<OrderDetailsController>(builder: (controller) {
          if (controller.inProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                heightBox24,
                CustomAppBar(name: 'Details'),
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
                            padding: const EdgeInsets.all(18.0),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image:
                                                  AssetImage(AssetsPath.demo),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  '${controller.orderDetailsData!.items[0].product?.name}',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                              Container(
                                                height: 23.h,
                                                width: 70.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.black12)),
                                                child: Center(
                                                    child: Text(
                                                  '${controller.orderDetailsData!.status}',
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
                                                '₦${controller.orderDetailsData!.amount}',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14.sp),
                                              ),
                                              Text(
                                                'Qty: ${controller.orderDetailsData!.items[0].product?.quantity}',
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
                      Text('Order Id : ${controller.orderDetailsData!.id}'),
                      heightBox4,
                      Text(
                          'Delivery Address : ${controller.orderDetailsData!.billingDetails?.address}'),
                      heightBox4,
                      Text(
                          'Date : ${controller.orderDetailsData!.billingDetails?.pickupDate}'),
                      heightBox4,
                      Text('Payment Method : Card'),
                      heightBox30,
                      Text(
                        'Price Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      heightBox8,
                      PriceRow(
                          name:
                              'Price(${controller.orderDetailsData!.items[0].quantity})',
                          price:
                              '${controller.orderDetailsData!.items[0].price}',
                          nameSize: 14,
                          priceSize: 14),
                      heightBox10,
                      PriceRow(
                          name: 'Delivery Fee',
                          price:
                              '${controller.orderDetailsData!.deliveryCharge}',
                          nameSize: 14,
                          priceSize: 14),
                      heightBox5,
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                      heightBox10,
                      PriceRow(
                          name: 'Total',
                          price: '${controller.orderDetailsData!.amount}',
                          nameSize: 14,
                          priceSize: 14),
                      heightBox30,
                      controller.orderDetailsData!.status == 'pending'
                          ? GradientElevatedButton(
                              onPressed: () {
                                cancelOrder(widget.orderId);
                              },
                              text: 'Cancel order')
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> cancelOrder(String orderId) async {
    final bool isSuccess = await cancelOrderController.cancelOrder(orderId);

    if (isSuccess) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, MainButtonNavbarScreen.routeName, (route) => false);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            cancelOrderController.errorMessage ?? 'Login failed', true);
      }
    }
  }
}
