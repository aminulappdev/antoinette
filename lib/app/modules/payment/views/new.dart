// import 'package:antoinette/app/modules/payment/controllers/all_package_controller.dart';
// import 'package:antoinette/app/modules/payment/controllers/my_subscription_controller.dart';
// import 'package:antoinette/app/modules/payment/controllers/payment_services.dart';
// import 'package:antoinette/app/modules/payment/controllers/subscription_controller.dart';
// import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
// import 'package:antoinette/app/utils/app_colors.dart';
// import 'package:antoinette/app/widgets/costom_app_bar.dart';
// import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
// import 'package:antoinette/app/widgets/show_snackBar_message.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SubscriptionScreen extends StatefulWidget {
//   static const String routeName = '/subscription-screen';
//   const SubscriptionScreen({super.key});

//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }

// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   final ProfileController profileController = Get.find<ProfileController>();
//   final SubscriptionController subscriptionController = Get.put(SubscriptionController());
//   final AllPackageController allPackageController = Get.find<AllPackageController>();
//   final MySubscriptionController mySubscriptionController = Get.find<MySubscriptionController>();
//   final PaymentService paymentService = PaymentService();
//   late String userId;
//   bool isStudent = false;

//   @override
//   void initState() {
//     super.initState();
//     userId = profileController.profileData?.id ?? '';
//     isStudent = profileController.profileData?.isStudent ?? false;
//     allPackageController.getAllPackage();
//     mySubscriptionController.getMySubscriptions();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: GetBuilder<AllPackageController>(
//         builder: (controller) {
//           if (controller.inProgress) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (controller.packageItemList == null || controller.packageItemList!.isEmpty) {
//             return const Center(child: Text("No packages available"));
//           } else {
//             // Separate packages into monthly and yearly
//             final monthlyPackages = controller.packageItemList!
//                 .where((pkg) => pkg.billingCycle!.toLowerCase() == 'monthly')
//                 .toList();
//             final yearlyPackages = controller.packageItemList!
//                 .where((pkg) => pkg.billingCycle!.toLowerCase() == 'yearly')
//                 .toList();

//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 12.h),
//                     const CustomAppBar(name: 'Subscriptions'),
//                     SizedBox(height: 24.h),
//                     SizedBox(
//                       height: 120,
//                       child: GetBuilder<MySubscriptionController>(
//                         builder: (controller) {
//                           if (controller.inProgress) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//                           final activeSubscriptions = controller.subscriptionData
//                                   ?.where(
//                                     (subscription) =>
//                                         subscription.paymentStatus == "paid" &&
//                                         subscription.status == "confirmed" &&
//                                         subscription.expiredAt.isAfter(DateTime.now()) &&
//                                         !subscription.isExpired &&
//                                         !subscription.isDeleted,
//                                   )
//                                   .toList() ??
//                               [];

//                           if (activeSubscriptions.isEmpty) {
//                             return const Center(child: Text("No active subscription"));
//                           }

//                           return ListView.builder(
//                             padding: EdgeInsets.zero,
//                             itemCount: activeSubscriptions.length,
//                             itemBuilder: (context, index) {
//                               final subscription = activeSubscriptions[index];
//                               DateTime expireDate = subscription.expiredAt;
//                               String formattedBookingDate = DateFormat('MMMM dd, yyyy').format(expireDate);
//                               int daysLeft = expireDate.difference(DateTime.now()).inDays;
//                               String daysLeftText = daysLeft > 0 ? '$daysLeft days left' : 'Expired';

//                               return Card(
//                                 child: Container(
//                                   width: width,
//                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           subscription.package?.billingCycle.toLowerCase() == "monthly"
//                                               ? 'Monthly Plan'
//                                               : 'Yearly Plan',
//                                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                                         ),
//                                         SizedBox(height: 4.h),
//                                         Text(
//                                           daysLeftText,
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                         SizedBox(height: 4.h),
//                                         Text(
//                                           'Expiry date: $formattedBookingDate',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     Text(
//                       'Premium Membership',
//                       style: TextStyle(
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.iconButtonThemeColor,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     // Monthly Packages Section
//                     if (monthlyPackages.isNotEmpty) ...[
//                       Text(
//                         'Monthly Plans',
//                         style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(height: 10.h),
//                       ListView.builder(
//                         padding: EdgeInsets.zero,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: monthlyPackages.length,
//                         itemBuilder: (context, pkgIndex) {
//                           final package = monthlyPackages[pkgIndex];
//                           return _buildPackageItem(package);
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                     ],
//                     // Yearly Packages Section
//                     if (yearlyPackages.isNotEmpty) ...[
//                       Text(
//                         'Yearly Plans',
//                         style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(height: 10.h),
//                       ListView.builder(
//                         padding: EdgeInsets.zero,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: yearlyPackages.length,
//                         itemBuilder: (context, pkgIndex) {
//                           final package = yearlyPackages[pkgIndex];
//                           return _buildPackageItem(package);
//                         },
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildPackageItem(dynamic package) {
//     dynamic price = isStudent ? (package.price / 2) : package.price;
//     bool isPackageActive = mySubscriptionController.hasActiveSubscription(package.billingCycle ?? '');

//     return Container(
//       margin: EdgeInsets.only(bottom: 24.h),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             package.title ?? '',
//             style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             package.subtitle ?? '',
//             style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
//           ),
//           SizedBox(height: 10.h),
//           Text(
//             "₦$price / ${package.billingCycle?.toLowerCase() ?? 'unknown'}",
//             style: GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             "Features:",
//             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
//           ),
//           SizedBox(height: 8.h),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(
//               package.description?.length ?? 0,
//               (descIndex) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.check_circle, size: 18, color: Colors.green),
//                     SizedBox(width: 6.w),
//                     Expanded(
//                       child: Text(
//                         package.description[descIndex] ?? '',
//                         style: TextStyle(fontSize: 14.sp),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 24.h),
//           SizedBox(
//             width: double.infinity,
//             child: GetBuilder<SubscriptionController>(
//               builder: (controller) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Opacity(
//                       opacity: isPackageActive || controller.inProgress ? 0.5 : 1.0,
//                       child: GradientElevatedButton(
//                         onPressed: (isPackageActive || controller.inProgress)
//                             ? () {
//                                 if (isPackageActive) {
//                                   showSnackBarMessage(
//                                       context, "You already have an active ${package.billingCycle} subscription", true);
//                                 }
//                               }
//                             : () => buyNowBTN(package.sId ?? ''),
//                         text: controller.inProgress
//                             ? ''
//                             : isPackageActive
//                                 ? 'Active Subscription'
//                                 : 'Buy Now',
//                       ),
//                     ),
//                     if (controller.inProgress)
//                       SizedBox(
//                         width: 24,
//                         height: 24,
//                         child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
//                       ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> buyNowBTN(String packageId) async {
//     try {
//       final bool isSuccess = await subscriptionController.getSubcription(userId, packageId);
//       if (isSuccess && subscriptionController.subscriptionResponseData != null) {
//         if (mounted) {
//           await paymentService.payment(
//             context,
//             'Subscription',
//             userId,
//             subscriptionController.subscriptionResponseData!.id!,
//           );
//           await mySubscriptionController.getMySubscriptions();
//           setState(() {});
//         }
//       } else {
//         if (mounted) {
//           showSnackBarMessage(context, subscriptionController.errorMessage ?? "Something went wrong", true);
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         showSnackBarMessage(context, "An error occurred: $e", true);
//       }
//     }
//   }
// }