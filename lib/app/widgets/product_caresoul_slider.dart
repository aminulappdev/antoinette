import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/modules/product/model/product_details_model.dart'; // Ensure this model is imported

class HomeCarouselSlider extends StatefulWidget {
  final List<Images> images;  
  const HomeCarouselSlider({
    super.key, required this.images,
  });

  @override
  _HomeCarouselSliderState createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 270.h,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 270.0.h,
              viewportFraction: 0.99,
              onPageChanged: (currentIndex, reason) {
                _selectedIndex.value = currentIndex;
              },
            ),
            items: widget.images.isEmpty
                ? [
                    Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Container(
                              height: 270.h,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/placeholder_image.png'),  // Default image
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ]
                : widget.images.map((image) {
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
                                  image: NetworkImage(image.url!),  // Access the url property of the Images object
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
          ),
        ),
        heightBox5,
        Container(
          height: 20.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.images.length; i++)
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
        ),
      ],
    );
  }
}
