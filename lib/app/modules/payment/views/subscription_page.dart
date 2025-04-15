import 'package:antoinette/app/modules/payment/controllers/all_package_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/subscription_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SubscriptionScreen extends StatefulWidget {
  static const String routeName = '/subscription-screen';
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isMonthly = true;
  bool isYearly = false;
  ProfileController profileController = Get.find<ProfileController>();
  SubscriptionController subscriptionController = SubscriptionController();
  AllPackageController allPackageController = Get.find<AllPackageController>();
  String? packageId;
  String? userId;
  int indexx = 0;

  @override
  void initState() {
    super.initState();

    // Ensure profileData is not null
    if (profileController.profileData != null) {
      userId = profileController.profileData!.sId;
    } else {   
      userId = '';
    }

    allPackageController.getAllPackage();

    // Check if the package list is available and has data
    if (allPackageController.packageItemList != null && allPackageController.packageItemList!.isNotEmpty) {
      packageId = allPackageController.packageItemList![1].sId;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AllPackageController>(builder: (controller) {
          if (controller.inProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsets.all(height / 72),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(name: 'Subscriptions'),
                    SizedBox(
                      height: height / 24,
                    ),
                    Text(
                      'Premium Membership',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.iconButtonThemeColor),
                    ),
                    SizedBox(
                      height: height / 80,
                    ),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        itemCount: controller.packageItemList?[indexx].description?.length,
                        itemBuilder: (context, index) {

                        return  costomRow('${controller.packageItemList?[indexx].description?[index]}', height, width);
                      },),
                    ),
                    // costomRow('Unlock AI generate image', height, width),
                    // SizedBox(
                    //   height: height / 160,
                    // ),
                    // costomRow('Pro support from our team', height, width),
                    // SizedBox(
                    //   height: height / 160,
                    // ),
                    // costomRow('Early access to new features', height, width),
                    // SizedBox(
                    //   height: height / 30,
                    // ),
                    packageSection(height, width,
                        monthlyAmount:
                            controller.packageItemList![1].price.toString(),
                        yearlyAmount:
                            controller.packageItemList![0].price.toString()),
                    SizedBox(
                      height: height / 20,
                    ),
                    GradientElevatedButton(
                      onPressed: buyNowBTN,
                      text: 'Buy now',
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget packageSection(double height, double width,
      {String monthlyAmount = '0', String yearlyAmount = '0'}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            packageId = allPackageController.packageItemList?[1].sId;
            isMonthly = true;
            isYearly = false;
              setState(() {
              indexx = 0;
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: height / 4.5,
                width: width / 2.2,
                decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: isMonthly
                            ? AppColors.gradiantColors
                            : [Colors.black, Colors.black],
                      ),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(height / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientText(
                            'Monthly',
                            style: GoogleFonts.urbanist(
                                fontSize: height / 36,
                                fontWeight: FontWeight.w400),
                            colors: isMonthly
                                ? AppColors.gradiantColors
                                : [Colors.black, Colors.black],
                          ),
                          GradientText(
                            '\$${allPackageController.packageItemList?[1].price}',
                            style: GoogleFonts.urbanist(
                                fontSize: height / 30,
                                fontWeight: FontWeight.w800),
                            colors: isMonthly
                                ? AppColors.gradiantColors
                                : [Colors.black, Colors.black],
                          ),
                        ],
                      ),
                      GradientText(
                        'Select your plan',
                        style: GoogleFonts.urbanist(
                            fontSize: height / 50, fontWeight: FontWeight.w400),
                        colors: isMonthly
                            ? AppColors.gradiantColors
                            : [Colors.black, Colors.black],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isMonthly,
                child: Positioned(
                  top: -10,
                  right: 0,
                  child: Container(
                    height: height / 30,
                    width: height / 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppColors.gradiantColors,
                      ),
                    ),
                    child: Icon(Icons.done, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            packageId = allPackageController.packageItemList?[0].sId;
            isMonthly = false;
            isYearly = true;
            
            setState(() {
              indexx = 1;
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: height / 4.5,
                width: width / 2.2,
                decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: isYearly
                            ? AppColors.gradiantColors
                            : [Colors.black, Colors.black],
                      ),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(height / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          GradientText(
                            'Yearly',
                            style: GoogleFonts.urbanist(
                                fontSize: height / 36,
                                fontWeight: FontWeight.w400),
                            colors: isYearly
                                ? AppColors.gradiantColors
                                : [Colors.black, Colors.black],
                          ),
                          GradientText(
                            '\$${allPackageController.packageItemList?[0].price}',
                            style: GoogleFonts.urbanist(
                                fontSize: height / 30,
                                fontWeight: FontWeight.w800),
                            colors: isYearly
                                ? AppColors.gradiantColors
                                : [Colors.black, Colors.black],
                          ),
                        ],
                      ),
                      GradientText(
                        'Select your plan',
                        style: GoogleFonts.urbanist(
                            fontSize: height / 50, fontWeight: FontWeight.w400),
                        colors: isYearly
                            ? AppColors.gradiantColors
                            : [Colors.black, Colors.black],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isYearly,
                child: Positioned(
                  top: -10,
                  right: 0,
                  child: Container(
                    height: height / 30,
                    width: height / 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppColors.gradiantColors,
                      ),
                    ),
                    child: Icon(Icons.done, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget costomRow(String name, double height, double width) {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: AppColors.gradiantColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Icon(
            Icons.check_circle_sharp,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 60.w,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> buyNowBTN() async {
    final bool isSuccess =
        await subscriptionController.getSubcription(userId!, packageId!);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Done');
        // Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, subscriptionController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, subscriptionController.errorMessage!, true);
      }
    }
  }
}
