import 'package:antoinette/app/modules/payment/controllers/all_package_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/payment_services.dart';
import 'package:antoinette/app/modules/payment/controllers/subscription_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatefulWidget {
  static const String routeName = '/subscription-screen';
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  SubscriptionController subscriptionController = SubscriptionController();
  AllPackageController allPackageController = Get.find<AllPackageController>();
  final PaymentService paymentService = PaymentService();
  late String userId;
  bool isStudent = false;

  @override
  void initState() {
    super.initState();
    userId = profileController.profileData?.sId ?? '';
    isStudent = profileController.profileData!.isStudent ?? false;
    allPackageController.getAllPackage();
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
                  Text(
                    'Premium Membership',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.iconButtonThemeColor,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 🔄 DYNAMIC PACKAGE LIST
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.packageItemList!.length,
                    itemBuilder: (context, pkgIndex) {
                      final package = controller.packageItemList![pkgIndex];
                      int? price = (package.price! / 2).toInt() ;
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
                              "\$$price / ${package.billingCycle}",
                              style: TextStyle(
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
                            SizedBox(
                              width: double.infinity,
                              child: GradientElevatedButton(
                                text: 'Buy Now',
                                onPressed: () {
                                  buyNowBTN(package.sId!);
                                },
                              ),
                            ),
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

  Future<void> buyNowBTN(String packageid) async {
    final bool isSuccess =
        await subscriptionController.getSubcription(userId, packageid);
    if (isSuccess) {
      if (mounted) {
        paymentService.payment(
          context,
          'Subscription',
          userId,
          subscriptionController.subscriptionResponseData!.id!,
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            subscriptionController.errorMessage ?? "Something went wrong",
            true);
      }
    }
  }
}
