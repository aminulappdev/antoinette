import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/widgets/address_card.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdderssScreen extends StatefulWidget {
  static const String routeName = '/profile-address-screen'; 
  const AdderssScreen({super.key});

  @override
  State<AdderssScreen> createState() => _AdderssScreenState();
}

class _AdderssScreenState extends State<AdderssScreen> {
  @override
  void initState() {
    Get.find<ProfileController>().getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProfileController>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(name: 'Address'),
                heightBox14,
                AddressCardWidget(
                  name: 'Home',
                  address: controller.profileData?.homeAddress == null
                      ? 'Add Address'
                      : '${controller.profileData?.homeAddress}',
                  editOntap: () {},
                  isShowBatch: false,
                ),
                heightBox12,
                AddressCardWidget(
                  name: 'Office',
                  address: controller.profileData?.officeAddress == null
                      ? 'Add Address'
                      : '${controller.profileData?.officeAddress}',
                  editOntap: () {},
                  isShowBatch: false,
                ),
                heightBox12,
                AddressCardWidget(
                  name: 'Delivery',
                  address: controller.profileData?.deliveryAddress == null
                      ? 'Add Address'
                      : '${controller.profileData?.deliveryAddress}',
                  editOntap: () {},
                  isShowBatch: false,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
