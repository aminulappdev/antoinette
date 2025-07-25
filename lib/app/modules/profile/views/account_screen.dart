import 'dart:io';

import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/update_profile_controller.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/image_picker.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/profile-account-screen';
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? image;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final profileController = Get.find<ProfileController>();
      await profileController.getProfileData();

      nameCtrl.text = profileController.profileData?.name ?? '';
      numberCtrl.text = profileController.profileData?.contactNumber ?? 'No data';
      print('Number eta : ${profileController.profileData?.contactNumber}');
      
      setState(() {}); // If needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        final isStudent =
            controller.profileData?.studentVerify?.status == 'approved'
                ? true
                : false;
        // Format the expireAt date
        String formattedDate = '';
        if (controller.profileData?.studentVerify?.expireAt != null) {
          final expireAt = controller.profileData!.studentVerify!.expireAt;
          formattedDate = DateFormat('dd MMM yyyy').format(expireAt!);
        }

        return Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heightBox24,
                  CustomAppBar(name: 'Your Details'),
                  heightBox12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                child: image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          image!,
                                          width: 50.h,
                                          height: 50.h,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: controller.profileData
                                                            ?.photoUrl ==
                                                        null
                                                    ? AssetImage(
                                                        AssetsPath.demo)
                                                    : NetworkImage(
                                                        '${controller.profileData?.photoUrl}'),
                                                fit: BoxFit.fill)),
                                      ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      _imagePickerHelper.showAlertDialog(
                                          context, (File pickedImage) {
                                        setState(() {
                                          image = pickedImage;
                                        });
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.iconButtonThemeColor,
                                        radius: 12.r,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 16.h,
                                        )),
                                  ))
                            ],
                          ),
                          widthBox8,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isStudent
                                  ? Row(
                                      children: [
                                        Text(
                                          '${controller.profileData?.name}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14.sp),
                                        ),
                                        widthBox4,
                                        Icon(
                                          size: 16,
                                          Icons.verified,
                                          color: Colors.green,
                                        )
                                      ],
                                    )
                                  : Text(
                                      '${controller.profileData?.name}',
                                      style:
                                          GoogleFonts.poppins(fontSize: 14.sp),
                                    ),
                              Text(
                                '${controller.profileData?.email}',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp, color: Color(0xff626262)),
                              ),
                            ],
                          )
                        ],
                      ),
                      isStudent
                          ? Container(
                              height: 36.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                  color: AppColors.iconButtonThemeColor
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Text(
                                  'Validity: $formattedDate',
                                  style: GoogleFonts.poppins(
                                      fontSize: 10.sp, color: Colors.black),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  heightBox12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: AppColors.iconButtonThemeColor,
                        size: 18.h,
                      )
                    ],
                  ),
                  heightBox4,
                  TextFormField(
                    controller: nameCtrl,
                    decoration: InputDecoration(),
                  ),
                  heightBox12,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                  heightBox4,
                  TextFormField(
                    initialValue: '${controller.profileData?.email}',
                    enabled: false,
                    decoration: InputDecoration(),
                  ),
                  heightBox12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contact',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: AppColors.iconButtonThemeColor,
                        size: 18.h,
                      )
                    ],
                  ),
                  heightBox4,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    controller: numberCtrl,
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 200.h,
                  ),
                  GetBuilder<UpdateProfileController>(
                    builder: (controller) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          GradientElevatedButton(
                            onPressed: controller.inProgress
                                ? () {}
                                : () => onTapToNextButton(),
                            text: controller.inProgress ? '' : 'Update',
                          ),
                          if (controller.inProgress)
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await updateProfileController.updateProfile(
        isNameUpdate: true,
        name: nameCtrl.text,
        number: numberCtrl.text,
        image: image,
      );

      if (isSuccess) {
        if (mounted) {
          Get.find<ProfileController>().getProfileData();
          showSnackBarMessage(context, 'Profile updated');
          Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, updateProfileController.errorMessage!, true);
        }
      }
    }
  }
}