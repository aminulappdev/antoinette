// import 'package:antoinette/app/modules/order/controllers/all_orders_controllers.dart';
// import 'package:antoinette/app/modules/order/widget/my_order_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AllScreen extends StatefulWidget {
//   const AllScreen({super.key});

//   @override
//   State<AllScreen> createState() => _AllScreenState();
// }

// class _AllScreenState extends State<AllScreen> {
//   final AllOrderController allOrderController = Get.find<AllOrderController>();

//   String selectedType = "All";
//   final List<String> options = [
//     "All",
//     "pending",
//     "processing",
//     "Delivered",
//   ];

//   @override
//   void initState() {
//     allOrderController.getOrderList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text("Choose Your Type:",
//                 style: GoogleFonts.poppins(fontSize: 15.sp)),
//             SizedBox(width: 10.h),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF6ECE4),
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: selectedType,
//                     isExpanded: true,
//                     icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
//                     items: options.map((String option) {
//                       return DropdownMenuItem<String>(
//                         value: option,
//                         child: Text(option,
//                             style: GoogleFonts.poppins(fontSize: 12.sp)),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedType = newValue!;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         GetBuilder<AllOrderController>(builder: (controller) {
//           if (controller.inProgress) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return SizedBox(
//             height: MediaQuery.of(context).size.height - 200,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.builder(
//               itemCount: controller.ordersData?.length,
//               itemBuilder: (context, index) {
//                 if (selectedType == 'All') {
//                   return MyOrderCard(
//                     imagePath:
//                         '${controller.ordersData![index].items[0].product?.images[0].url}',
//                     price: '${controller.ordersData?[index].amount}',
//                     productName:
//                         '${controller.ordersData![index].items[0].product?.name}',
//                     quantity:
//                         '${controller.ordersData?[index].items[0].quantity}',
//                     isShowSeconBTN:
//                         controller.ordersData?[index].status == 'pending'
//                             ? false
//                             : true,
//                     status: '${controller.ordersData?[index].status}',
//                     mainBTNOntap: () {},
//                     secondBTNOntap: () {},
//                     secondBTNName: 'Buy Again',
//                   );
//                 }
//                 else if (controller.ordersData?[index].status == selectedType) {
//                   return MyOrderCard(
//                     imagePath:
//                         '${controller.ordersData![index].items[0].product?.images[0].url}',
//                     price: '${controller.ordersData?[index].amount}',
//                     productName:
//                         '${controller.ordersData![index].items[0].product?.name}',
//                     quantity:
//                         '${controller.ordersData?[index].items[0].quantity}',
//                     isShowSeconBTN:
//                         controller.ordersData?[index].status == 'pending'
//                             ? false
//                             : true,
//                     status: '${controller.ordersData?[index].status}',
//                     mainBTNOntap: () {},
//                     secondBTNOntap: () {},
//                     secondBTNName: 'Buy Again',
//                   );
//                 }
//               },
//             ),
//           );
//         })
//       ],
//     );
//   }
// }
