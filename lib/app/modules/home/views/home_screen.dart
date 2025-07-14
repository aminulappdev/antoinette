import 'package:antoinette/app/modules/checkin/views/check_in_screen.dart';
import 'package:antoinette/app/modules/common/views/notification_screen.dart';
import 'package:antoinette/app/modules/home/widgets/product_item_shimmer.dart';
import 'package:antoinette/app/modules/home/widgets/session_item_shimmer.dart';
import 'package:antoinette/app/modules/letters/views/letter_screen.dart';
import 'package:antoinette/app/modules/home/models/grid_view_model.dart';
import 'package:antoinette/app/modules/home/widgets/grid_feature.dart';
import 'package:antoinette/app/modules/home/widgets/header_section.dart';
import 'package:antoinette/app/modules/product/controllers/all_product_controller.dart';
import 'package:antoinette/app/modules/home/widgets/psycho_support_card.dart';
import 'package:antoinette/app/modules/home/widgets/see_all_section.dart';
import 'package:antoinette/app/modules/home/widgets/welcome_text.dart';
import 'package:antoinette/app/modules/product/views/product_screen.dart';
import 'package:antoinette/app/modules/product/widgets/product_card.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/session/controllers/all_session_controller.dart';
import 'package:antoinette/app/modules/session/views/session_screen.dart';
import 'package:antoinette/app/utils/get_storage.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AllProductController allProductController = Get.find<AllProductController>();
  final AllSessionController allSessionController = Get.find<AllSessionController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    // Defer data fetching until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileController.getProfileData();
      // Only write to storage if profile data is available
      if (profileController.profileModel?.data?.name != null) {
        box.write('user-name', profileController.profileModel!.data!.name);
      }
      await allSessionController.getSessionList();
    });
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }

  List<HomepageGridModel> gridList = [
    HomepageGridModel(
        icon: Icons.hearing,
        title: 'A Listening Ear',
        subtitle: '( Therapy Sessions )',
        navigationPath: SessionScreen.routeName),
    HomepageGridModel(
      icon: Icons.shopping_cart,
      title: 'Little Luxuries',
      subtitle: '( Shop for wellness & self-care products)',
      navigationPath: ProductScreen.routeName,
    ),
    HomepageGridModel(
        icon: Icons.menu_book,
        title: 'Letters to You',
        subtitle: '(Podcasts, articles & videos for your journey )',
        navigationPath: LetterScreen.routeName),
    HomepageGridModel(
        icon: Icons.check_circle,
        title: 'Safe Notes',
        subtitle: '(Check-In)',
        navigationPath: CheckInScreen.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await allProductController.refreshProducts();
          await allSessionController.getSessionList();
          await profileController.getProfileData();
          // Update storage after refresh
          if (profileController.profileModel?.data?.name != null) {
            box.write('user-name', profileController.profileModel!.data!.name);
          }
        },
        child: SingleChildScrollView(
          child: GetBuilder<ProfileController>(builder: (controller) {
            return Padding(
              padding: EdgeInsets.all(12.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox24,
                  HomePageHeader(
                    circleText: controller.inProgress
                        ? ''
                        : controller.profileData?.name?.isNotEmpty == true
                            ? controller.profileData!.name![0]
                            : '',
                    onTapNotification: () {
                      Navigator.pushNamed(context, NotificationScreen.routeName);
                    },
                  ),
                  heightBox16,
                  WelcomeTextHomePage(
                    time: getGreeting(),
                    name: controller.inProgress
                        ? ''
                        : controller.profileData?.name?.isNotEmpty == true
                            ? '${controller.profileData!.name} 👋'
                            : 'User 👋',
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    child: SizedBox(
                      height: 290.h,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.15,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                gridList[index].navigationPath,
                                arguments: true,
                              );
                            },
                            child: GridFeature(
                              icon: gridList[index].icon,
                              title: gridList[index].title,
                              subtitle: gridList[index].subtitle,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SeeAllSection(
                    title: 'Soft landings for hard days. Because not everything should be carried alone.',
                    ontap: () {
                      Navigator.pushNamed(context, SessionScreen.routeName,
                          arguments: true);
                    },
                  ),
                  heightBox8,
                  GetBuilder<AllSessionController>(builder: (controller) {
                    if (controller.inProgress && controller.page == 1) {
                      return SessionItemShimmerEffectWidget();
                    } else if (controller.sessionsList.isEmpty) {
                      return const SizedBox(
                        height: 100,
                        child: Center(child: Text('No data available')),
                      );
                    } else {
                      return SizedBox(
                        height: 175,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.sessionsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: PsychoSupportCard(
                                sessionItemModel: controller.sessionsList[index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                  heightBox12,
                  SeeAllSection(
                    title: 'Your Quiet Shelf of Care',
                    ontap: () {
                      Navigator.pushNamed(context, ProductScreen.routeName,
                          arguments: true);
                    },
                  ),
                  heightBox8,
                  GetBuilder<AllProductController>(builder: (controller) {
                    if (controller.inProgress && controller.initialInProgress) {
                      return ProductItemShimmerEffectWidget();
                    } else if (controller.productsList.isEmpty) {
                      return const SizedBox(
                        height: 100,
                        child: Center(child: Text('No data available')),
                      );
                    } else {
                      return SizedBox(
                        height: 134.h,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.productsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: ProductCard(
                                productsModel: controller.productsList[index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}