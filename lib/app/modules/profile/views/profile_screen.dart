import 'package:antoinette/app/modules/authentication/views/sign_in_screen.dart';
import 'package:antoinette/app/modules/contact/views/contact_screen.dart';
import 'package:antoinette/app/modules/history/views/history_screen.dart';
import 'package:antoinette/app/modules/order/views/oder_screen.dart';
import 'package:antoinette/app/modules/payment/views/subscription_page.dart';
import 'package:antoinette/app/modules/profile/controllers/content_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/delete_account_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/views/account_screen.dart';
import 'package:antoinette/app/modules/profile/views/info_screen.dart';
import 'package:antoinette/app/modules/profile/views/static_screen.dart';
import 'package:antoinette/app/modules/profile/widgets/profile_drawer_feature.dart';
import 'package:antoinette/app/modules/profile/widgets/profile_info.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../bookmark/views/bookmark_letter_screen.dart';
import '../../common/views/notification_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DeleteAccountController deleteAccountController =
      DeleteAccountController();
  @override
  void initState() {
    Get.find<ContentController>().getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox24,
                ProfileInfo(
                  name: '${controller.profileData?.name}',
                  email: '${controller.profileModel?.data?.email}',
                  imagePath: '${controller.profileModel?.data?.photoUrl}',
                ),
                heightBox12,
                ProfileDrawerFeature(
                  feature: 'Your Details',
                  icon: Icons.person,
                  ontap: () {
                    Navigator.pushNamed(context, AccountScreen.routeName);
                  },
                ),
                ProfileDrawerFeature(
                  feature: 'Things You’ve Chosen',
                  icon: Icons.shopping_bag,
                  ontap: () {
                    Navigator.pushNamed(context, MyOrderScreen.routeName);
                  },
                ),
                ProfileDrawerFeature(
                  feature: 'Where You’ve Been',
                  icon: Icons.history,
                  ontap: () {
                    Navigator.pushNamed(context, HistoryScreen.routeName);
                  },
                ),
                // ProfileDrawerFeature(
                //   feature: 'Where We Send Care',
                //   icon: Icons.location_on,
                //   ontap: () {
                //     Navigator.pushNamed(context, AdderssScreen.routeName);
                //   },
                // ),
                ProfileDrawerFeature(
                  feature: 'People Who’ll Be Notified If You’re Not Okay',
                  icon: Icons.people,
                  ontap: () {
                    Navigator.pushNamed(context, ContactScreen.routeName);
                  },
                ),
                ProfileDrawerFeature(
                  feature: 'Subscription',
                  icon: Icons.payment,
                  ontap: () {
                    Navigator.pushNamed(context, SubscriptionScreen.routeName);
                  },
                ),
                ProfileDrawerFeature(
                  feature: 'Saved for When You’re Ready',
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
                  feature: 'Messages From Us',
                  icon: Icons.notifications,
                  ontap: () {
                    Navigator.pushNamed(context, NotificationScreen.routeName);
                  },
                ),
                heightBox8,
                Text(
                  'Support',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                heightBox4,
                GetBuilder<ContentController>(
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileDrawerFeature(
                          feature: 'In Case You Need It',
                          icon: Icons.person,
                          ontap: () {
                            Get.to(StaticScreen());
                          },
                        ),
                        ProfileDrawerFeature(
                          feature: 'How We Keep You Safe',
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
                          feature: 'The Rules We Live By',
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
                          feature: 'Why We Exist',
                          icon: Icons.info,
                          ontap: () {
                            Navigator.pushNamed(
                                context, InfoScreen.routeName, arguments: {
                              'appBarTitle': 'About Us',
                              'data': '${controller.contentlist?[0].aboutUs}'
                            });
                          },
                        ),
                        heightBox8,
                        Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        heightBox4,
                        ProfileDrawerFeature(
                          feature: 'Logout',
                          icon: Icons.logout,
                          ontap: onTapLogoutBTN,
                        ),
                        heightBox8,
                        Text(
                          'Delete Account',
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        heightBox4,
                        GetBuilder<ProfileController>(builder: (controller) {
                          return ProfileDrawerFeature(
                            feature: 'Delete account',
                            icon: Icons.delete,
                            ontap: () {
                              onTapDeleteBTN('${controller.profileData?.id}');
                            },
                          );
                        }),
                      ],
                    );
                  },
                ),
                heightBox30,
                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'Seal your letter and sign off',
                //     style: GoogleFonts.poppins(
                //         fontSize: 14.sp, color: Color(0xffA01D21)),
                //   ),
                // )
              ],
            ),
          ),
        );
      }),
    );
  }

  void onTapLogoutBTN() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            'Do you want to log out from this account?',
            style: GoogleFonts.poppins(fontSize: 20),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              // Google Sign-Out
              try {
                await GoogleSignIn().signOut();

                print('Google signed out');
              } catch (e) {
                print('Error signing out from Google: $e');
              }

              // Clear local token
              box.remove('user-login-access-token');
              box.remove('isJournalPasswordSet');

              print(
                  'Token after logout: ${box.read('user-login-access-token')}');

              // Redirect to Sign In
              Navigator.pushNamedAndRemoveUntil(
                context,
                SignInScreen.routeName,
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              height: 32.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff305FA1).withOpacity(0.1),
                border: Border.all(color: Color(0xff305FA1)),
              ),
              child: Center(
                child: Text(
                  'YES',
                  style: TextStyle(color: Color(0xff305FA1), fontSize: 14),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 32.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffA13430).withOpacity(0.1),
                border: Border.all(color: Color(0xffA13430)),
              ),
              child: Center(
                child: Text(
                  'NO',
                  style: TextStyle(color: Color(0xffA13430), fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapDeleteBTN(String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            'Do you want to delete this account?',
            style: GoogleFonts.poppins(fontSize: 20),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              // Google Sign-Out
              try {
                await GoogleSignIn().signOut();
                final bool isSuccess =
                    await deleteAccountController.deleteProfile(id);
                if (isSuccess) {
                  print('User account deleted');
                }
                print('Google signed out');
              } catch (e) {
                print('Error signing out from Google: $e');
              }

              // Clear local token
              box.remove('user-login-access-token');
              Navigator.pushNamedAndRemoveUntil(
                context,
                SignInScreen.routeName,
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              height: 32.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff305FA1).withOpacity(0.1),
                border: Border.all(color: Color(0xff305FA1)),
              ),
              child: Center(
                child: Text(
                  'YES',
                  style: TextStyle(color: Color(0xff305FA1), fontSize: 14),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 32.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffA13430).withOpacity(0.1),
                border: Border.all(color: Color(0xffA13430)),
              ),
              child: Center(
                child: Text(
                  'NO',
                  style: TextStyle(color: Color(0xffA13430), fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
