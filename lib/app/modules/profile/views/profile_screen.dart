import 'package:antoinette/app/modules/contact/views/contact_screen.dart';
import 'package:antoinette/app/modules/letters/views/bookmarks/bookmark_letter_screen.dart';
import 'package:antoinette/app/modules/profile/controllers/content_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/views/account_screen.dart';
import 'package:antoinette/app/modules/profile/views/address_screen.dart';
import 'package:antoinette/app/modules/profile/views/info_screen.dart';
import 'package:antoinette/app/modules/profile/widgets/profile_drawer_feature.dart';
import 'package:antoinette/app/modules/profile/widgets/profile_info.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile-screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Get.find<ContentController>().getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProfileController>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(12.0.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox12,
                  ProfileInfo(
                    name: '${controller.profileData?.name}',
                    email: '${controller.profileModel?.data?.email}',
                    imagePath: AssetsPath.womenBookRead,
                  ),
                  heightBox12,
                  ProfileDrawerFeature(
                    feature: 'Account',
                    icon: Icons.person,
                    ontap: () {
                      Navigator.pushNamed(context, AccountScreen.routeName);
                    },
                  ),
                  ProfileDrawerFeature(
                    feature: 'My Orders',
                    icon: Icons.shopping_bag,
                    ontap: () {},
                  ),
                  ProfileDrawerFeature(
                    feature: 'History',
                    icon: Icons.history,
                    ontap: () {},
                  ),
                  ProfileDrawerFeature(
                    feature: 'Address',
                    icon: Icons.location_on,
                    ontap: () {
                      Navigator.pushNamed(context, AdderssScreen.routeName);
                    },
                  ),
                  ProfileDrawerFeature(
                    feature: 'Trusted Contacts',
                    icon: Icons.people,
                    ontap: () {
                      Navigator.pushNamed(context, ContactScreen.routeName);
                    },
                  ),
                  ProfileDrawerFeature(
                    feature: 'Payment',
                    icon: Icons.payment,
                    ontap: () {},
                  ),
                  ProfileDrawerFeature(
                    feature: 'Bookmarks',
                    icon: Icons.bookmark,
                    ontap: () {
                      Navigator.pushNamed(context, BookmarkScreen.routeName);
                    },
                  ),
                  heightBox8,
                  Text(
                    'Settings',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  heightBox4,
                  ProfileDrawerFeature(
                    feature: 'Notification',
                    icon: Icons.notifications,
                    ontap: () {},
                  ),
                  heightBox8,
                  Text(
                    'Support',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  heightBox4,
                  GetBuilder<ContentController>(builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileDrawerFeature(
                          feature: 'Policies',
                          icon: Icons.security,
                          ontap: () {
                            Navigator.pushNamed(context, InfoScreen.routeName,
                                arguments: {
                                  'appBarTitle': 'Privacy and Policies',
                                  'data':
                                      '${controller.contentlist?[0].privacyPolicy}'
                                });
                          },
                        ),
                        ProfileDrawerFeature(
                          feature: 'Help Center',
                          icon: Icons.help,
                          ontap: () {},
                        ),
                        ProfileDrawerFeature(
                          feature: 'Terms & Condition',
                          icon: Icons.help,
                          ontap: () {
                            Navigator.pushNamed(context, InfoScreen.routeName,
                                arguments: {
                                  'appBarTitle': 'Terms & Conditions',
                                  'data':
                                      '${controller.contentlist?[0].termsAndConditions}'
                                });
                          },
                        ),
                        ProfileDrawerFeature(
                          feature: 'About Us',
                          icon: Icons.info,
                          ontap: () {
                            Navigator.pushNamed(
                                context, InfoScreen.routeName, arguments: {
                              'appBarTitle': 'About Us',
                              'data': '${controller.contentlist?[0].aboutUs}'
                            });
                          },
                        ),
                      ],
                    );
                  }),
                  heightBox30,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Seal your letter and sign off',
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp, color: Color(0xffA01D21)),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
