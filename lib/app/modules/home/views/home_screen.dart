import 'package:antoinette/app/modules/home/widgets/grid_feature.dart';
import 'package:antoinette/app/modules/home/widgets/header_section.dart';
import 'package:antoinette/app/modules/product/widgets/product_card.dart';
import 'package:antoinette/app/modules/home/widgets/psycho_support_card.dart';
import 'package:antoinette/app/modules/home/widgets/see_all_section.dart';
import 'package:antoinette/app/modules/home/widgets/welcome_text.dart';
import 'package:antoinette/app/modules/product/views/product_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomePageHeader(
                  circleText: 's',
                  onTapNotification: () {},
                  onTapPublic: () {},
                ),
                heightBox16,
                WelcomeTextHomePage(
                  time: 'Morning',
                  name: 'Sarah',
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: SizedBox(
                    height: 290,
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.15,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GridFeature(
                          icon: Icons.shopping_bag,
                          title: 'Little Luxuries',
                          subtitle:
                              '( Shop for wellness & self-care products )',
                        );
                      },
                    ),
                  ),
                ),
                SeeAllSection(
                  title: 'Expert Psychological Support at Your Fingertips',
                  ontap: () {},
                ),
                heightBox8,
                SizedBox(
                  height: 175,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: PsychoSupportCard(
                          status: 'Available',
                          price: '500',
                          time: '60',
                          imagePath: AssetsPath.doctor,
                          title: 'Find Balance & Clarity',
                        ),
                      );
                    },
                  ),
                ),
                heightBox12,
                SeeAllSection(
                  title: 'Shop Your Health Must-Haves',
                  ontap: () {
                    Navigator.pushNamed(context, ProductScreen.routeName,arguments: true);
                  },
                ),
                heightBox8,
                SizedBox(
                  height: 134,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: ProductCard(
                          name: 'Sunscreen',
                          price: '49.99',
                          imagePath: AssetsPath.medichine,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
