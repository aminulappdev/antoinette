import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
  });

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 270.h,
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 270.0.h,
                  viewportFraction: 0.99,
                  onPageChanged: (currentIndex, reason) {
                    _selectedIndex.value = currentIndex;
                  },
                ),
                items: [1, 2, 3, 4].map(
                  (banner) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Container(
                              height: 270.h,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(AssetsPath.medichine),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
        Container(
          height: 20.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: Colors.white30, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        width: 12.w,
                        height: 12.h,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: value == i
                              ? AppColors.themeColor
                              : Colors.transparent,
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
