import 'package:antoinette/app/modules/payment/controllers/all_package_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/my_subscription_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/payment_services.dart';
import 'package:antoinette/app/modules/payment/controllers/subscription_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for font support

class SubscriptionScreen extends StatefulWidget {
  static const String routeName = '/subscription-screen';
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  AllPackageController allPackageController = Get.find<AllPackageController>();
 // final PaymentService paymentService = PaymentService();
  final MySubscriptionController mySubscriptionController =
      Get.find<MySubscriptionController>();
  late String userId;
  bool isStudent = false;
  bool isSubscriptionActive = false;

  @override
  void initState() {
    super.initState();
    userId = profileController.profileData?.sId ?? '';
    isStudent = profileController.profileData!.isStudent ?? false;
    allPackageController.getAllPackage();
    mySubscriptionController.getMySubscriptions().then((_) {
      _checkSubscriptionStatus();
    });
  }

  void _checkSubscriptionStatus() {
    if (mySubscriptionController.subscriptionData != null &&
        mySubscriptionController.subscriptionData!.isNotEmpty) {
      DateTime expireDate =
          mySubscriptionController.subscriptionData![0].expiredAt!;
      DateTime today = DateTime.now();
      isSubscriptionActive = expireDate.isAfter(today);
    } else {
      isSubscriptionActive = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<AllPackageController>(
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.packageItemList == null ||
              controller.packageItemList!.isEmpty) {
            return const Center(child: Text("No packages available"));
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(name: 'Subscriptions'),
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 120,
                    child: GetBuilder<MySubscriptionController>(
                      builder: (controller) {
                        if (controller.inProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (controller.subscriptionData!.isEmpty) {
                          return const Center(
                              child: Text("No subscription available"));
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            DateTime expireDate =
                                controller.subscriptionData![index].expiredAt!;
                            DateTime today = DateTime.now();
                            String formattedBookingDate =
                                DateFormat('MMMM dd, yyyy').format(expireDate);

                            // Calculate days left
                            int daysLeft = expireDate
                                .difference(today)
                                .inDays; // Calculate difference in days
                            String daysLeftText = daysLeft > 0
                                ? '$daysLeft days left'
                                : 'Expired'; // Show "Expired" if days are 0 or negative

                            return Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Basic Plan',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      heightBox4,
                                      Text(
                                        daysLeftText,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      heightBox4,
                                      Text(
                                        'Expiry date $formattedBookingDate',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      heightBox4,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    'Premium Membership',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.iconButtonThemeColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // 🔄 DYNAMIC PACKAGE LIST
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.packageItemList!.length,
                    itemBuilder: (context, pkgIndex) {
                      final package = controller.packageItemList![pkgIndex];
                      int? price = isStudent == true
                          ? (package.price! / 2).toInt()
                          : package.price;
                      return Container(
                        margin: EdgeInsets.only(bottom: 24.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 Title
                            Text(
                              package.title ?? '',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),

                            // 🔹 Subtitle
                            Text(
                              package.subtitle ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // 🔹 Price and Billing

                            Text(
                              "₦$price / ${package.billingCycle}",
                              style: GoogleFonts.roboto(
                                // Added GoogleFonts to support ₦
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // 🔹 Features List
                            Text(
                              "Features:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                package.description?.length ?? 0,
                                (descIndex) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.check_circle,
                                          size: 18, color: Colors.green),
                                      SizedBox(width: 6.w),
                                      Expanded(
                                        child: Text(
                                          package.description![descIndex],
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // ✅ BUY NOW BUTTON
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: GetBuilder<SubscriptionController>(
                            //     builder: (controller) {
                            //       return Stack(
                            //         alignment: Alignment.center,
                            //         children: [
                            //           Opacity(
                            //             opacity:
                            //                 isSubscriptionActive ? 0.5 : 1.0,
                            //             child: GradientElevatedButton(
                            //               onPressed: (isSubscriptionActive ||
                            //                       controller.inProgress)
                            //                   ? () {}
                            //                   : () => buyNowBTN(package.sId!),
                            //               text: controller.inProgress
                            //                   ? ''
                            //                   : isSubscriptionActive
                            //                       ? 'Active Subscription'
                            //                       : 'Buy Now',
                            //             ),
                            //           ),
                            //           if (controller.inProgress)
                            //             SizedBox(
                            //               width: 24,
                            //               height: 24,
                            //               child: CircularProgressIndicator(
                            //                 strokeWidth: 2,
                            //                 color: Colors.white,
                            //               ),
                            //             ),
                            //         ],
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Future<void> buyNowBTN(String packageid) async {
  //   final bool isSuccess =
  //       await subscriptionController.getSubcription(userId, packageid);
  //   if (isSuccess) {
  //     if (mounted) {
  //       paymentService.payment(
  //         context,
  //         'Subscription',
  //         userId,
  //         subscriptionController.subscriptionResponseData!.id!,
  //       );
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(
  //           context,
  //           subscriptionController.errorMessage ?? "Something went wrong",
  //           true);
  //     }
  //   }
  // }
}
