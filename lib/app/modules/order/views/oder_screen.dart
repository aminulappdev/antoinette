import 'package:antoinette/app/modules/order/controllers/all_orders_controllers.dart';
import 'package:antoinette/app/modules/order/views/order_details_screen.dart';
import 'package:antoinette/app/modules/order/widget/my_order_card.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderScreen extends StatefulWidget {
  static const String routeName = '/my-orders-screen';
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final AllOrderController allOrderController = Get.find<AllOrderController>();

  String selectedType = "All";
  final List<String> options = [
    "All",
    "pending",
    "processing",
    "Delivered",
  ];

  @override
  void initState() {
    allOrderController.getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox20,
            CustomAppBar(name: "My Orders"),
            Row(
              children: [
                Text("Choose Your Type:",
                    style: GoogleFonts.poppins(fontSize: 15.sp)),
                SizedBox(width: 10.h),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6ECE4),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedType,
                        isExpanded: true,
                        icon:
                            Icon(Icons.arrow_drop_down, color: Colors.black54),
                        items: options.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option,
                                style: GoogleFonts.poppins(fontSize: 12.sp)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedType = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GetBuilder<AllOrderController>(builder: (controller) {
                if (controller.inProgress) {
                  return Center(child: CircularProgressIndicator());
                }

                final filteredOrders = selectedType == 'All'
                    ? controller.ordersData ?? []
                    : (controller.ordersData ?? [])
                        .where((order) => order.status == selectedType)
                        .toList();

                if (filteredOrders.isEmpty) {
                  return Center(
                    child: Text('No orders found.',
                        style: GoogleFonts.poppins(fontSize: 14.sp)),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    final item = order.items[0];
                    final product = item.product;
                    final imageUrl = (product?.images.isNotEmpty ?? false)
                        ? product!.images[0].url
                        : '';

                    return MyOrderCard(
                      imagePath: imageUrl!,
                      price: '${order.amount}',
                      productName: product?.name ?? "Unknown",
                      quantity: '${item.quantity}',
                      isShowSeconBTN: order.status != 'pending',
                      status: '${order.status}',
                      mainBTNOntap: () {
                        Navigator.popAndPushNamed(
                          context,
                          OrderDetailsScreen.routeName,
                          arguments: order.id,
                        );
                      },
                      secondBTNOntap: () {},
                      secondBTNName: 'Buy Again',
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
