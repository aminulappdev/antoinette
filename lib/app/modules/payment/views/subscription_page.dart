import 'package:antoinette/app/modules/payment/controllers/all_package_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/cancel_subscription_controller.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SubscriptionScreen extends StatefulWidget {
  static const String routeName = '/subscription-screen';
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  final AllPackageController allPackageController =
      Get.find<AllPackageController>();
  final MySubscriptionController mySubscriptionController =
      Get.find<MySubscriptionController>();
  final PaymentService paymentService = PaymentService();
  final CancelSubscriptionController cancelSubscriptionController =
      CancelSubscriptionController();
  late String userId;
  bool isStudent = false;
  final Map<String, bool> _isLoadingMap = {};

  @override
  void initState() {
    super.initState();

    userId = profileController.profileData?.id ?? '';
    allPackageController.getAllPackage();
    isStudent =
        profileController.profileData!.studentVerify?.status == 'approved'
            ? true
            : false;
    mySubscriptionController.getMySubscriptions();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AllPackageController>(
        builder: (controller) {
          
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.packageItemList == null ||
              controller.packageItemList!.isEmpty) {
            return const Center(child: Text("No packages available"));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
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
                          final activeSubscriptions = controller
                                  .subscriptionData
                                  ?.where((subscription) =>
                                      subscription.paymentStatus == "paid" &&
                                      subscription.status == "confirmed" &&
                                      subscription.expiredAt
                                          .isAfter(DateTime.now()) &&
                                      subscription.isExpired &&
                                      subscription.isDeleted)
                                  .toList() ??
                              [];
                          print('length is ${activeSubscriptions.length}');
                          if (activeSubscriptions.isEmpty) {
                            return const Center(
                                child: Text("No active subscription"));
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: activeSubscriptions.length,
                            itemBuilder: (context, index) {
                              final subscription = activeSubscriptions[index];
                              DateTime expireDate = subscription.expiredAt;
                              String formattedDate = DateFormat('MMMM dd, yyyy')
                                  .format(expireDate);
                              int daysLeft =
                                  expireDate.difference(DateTime.now()).inDays;
                              String daysLeftText = daysLeft > 0
                                  ? '$daysLeft days left'
                                  : 'Expired';

                              return Card(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            subscription.package?.billingCycle
                                                        .toLowerCase() ==
                                                    "monthly"
                                                ? 'Monthly Plan'
                                                : 'Yearly Plan',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cancelSubscription(
                                                  subscription.id);
                                            },
                                            child: Container(
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: AppColors
                                                        .iconButtonThemeColor),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                                  child: Text(
                                                    'Cancel auto subscription',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(daysLeftText,
                                          style: const TextStyle(fontSize: 14)),
                                      SizedBox(height: 4.h),
                                      Text('Expiry date: $formattedDate',
                                          style: const TextStyle(fontSize: 14)),
                                    ],
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
                    SizedBox(height: 16.h),
                    GetBuilder<AllPackageController>(builder: (controller) {
                      if (allPackageController.inProgress) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return GetBuilder<MySubscriptionController>(
                          builder: (subController) {
                        final activePackageIds = subController.subscriptionData
                                ?.where((sub) =>
                                    sub.paymentStatus == "paid" &&
                                    sub.status == "confirmed" &&
                                    sub.expiredAt.isAfter(DateTime.now()) &&
                                    !sub.isExpired &&
                                    !sub.isDeleted)
                                .map((sub) => sub.package?.id)
                                .toSet() ??
                            {};

                        final hasAnyActive = activePackageIds.isNotEmpty;

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              allPackageController.packageItemList!.length,
                          itemBuilder: (context, index) {
                            final package =
                                allPackageController.packageItemList![index];
                            final isActive =
                                activePackageIds.contains(package.sId);
                            final isAnotherActive = hasAnyActive && !isActive;
                            final isLoading =
                                _isLoadingMap[package.sId ?? ''] ?? false;

                            return GetBuilder<ProfileController>(
                                builder: (controller) {
                              final bool isStudent = controller
                                          .profileData!.studentVerify?.status ==
                                      'approved'
                                  ? true
                                  : false;
                              return Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          package.title ?? 'Package',
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        isStudent
                                            ? Container(
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .iconButtonThemeColor),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.school,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    isStudent
                                        ? Row(
                                            children: [
                                              Text(
                                                "\u20A6${package.price}",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.red,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              widthBox4,
                                              Text(
                                                "\u20A6${package.price! / 2}",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "\u20A6${package.price}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      "Features:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(height: 8.h),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: (package.description ?? [])
                                          .map((feature) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 4.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('• ',
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colors
                                                          .grey.shade600)),
                                              Expanded(
                                                child: Text(
                                                  feature,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: 16.h),
                                    isActive
                                        ? Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Opacity(
                                                opacity: 0.5,
                                                child: GradientElevatedButton(
                                                    onPressed: () {},
                                                    text: 'Already Subscribed'),
                                              ),
                                              if (isLoading)
                                                const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                            ],
                                          )
                                        : isAnotherActive
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Opacity(
                                                    opacity: 0.5,
                                                    child: GradientElevatedButton(
                                                        onPressed: () {},
                                                        text:
                                                            'Another plan activated'),
                                                  ),
                                                  if (isLoading)
                                                    const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                    ),
                                                ],
                                              )
                                            : Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  GradientElevatedButton(
                                                    onPressed: (isActive ||
                                                            isLoading ||
                                                            isAnotherActive)
                                                        ? () {} // Do nothing
                                                        : () => buyNowBTN(
                                                            package.sId ?? ''),
                                                    text: isActive
                                                        ? 'Active'
                                                        : isAnotherActive
                                                            ? 'Already Subscribed'
                                                            : 'Buy Now',
                                                  ),
                                                  if (isLoading)
                                                    const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      });
                    }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> buyNowBTN(String packageId) async {
    if (_isLoadingMap[packageId] ?? false) return;

    setState(() {
      _isLoadingMap[packageId] = true;
    });

    try {
      final bool isSuccess =
          await subscriptionController.getSubcription(userId, packageId);
      if (isSuccess &&
          subscriptionController.subscriptionResponseData != null) {
        if (mounted) {
          await paymentService.payment(
            context,
            'Subscription',
            userId,
            subscriptionController.subscriptionResponseData!.id!,
          );
          await mySubscriptionController.getMySubscriptions();
          setState(() {});
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            subscriptionController.errorMessage ?? "Something went wrong",
            true,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBarMessage(context, "An error occurred: $e", true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMap[packageId] = false;
        });
      }
    }
  }

  Future<void> cancelSubscription(String subscriptionId) async {
    final bool isSuccess =
        await cancelSubscriptionController.cancelSubscription(subscriptionId);
    if (isSuccess) {
      if (mounted) {
        print('Sucess hoiche');
        showSnackBarMessage(
          context,
          "Cancel successfully done",
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          subscriptionController.errorMessage ?? "Something went wrong",
          true,
        );
      }
    }
  }
}
