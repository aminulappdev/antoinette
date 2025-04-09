import 'package:antoinette/app/modules/product/controllers/all_product_controller.dart';
import 'package:antoinette/app/modules/product/widgets/product_card.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final bool shouldBackButton;
  static const String routeName = '/product-screen';
  const ProductScreen({super.key, required this.shouldBackButton});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  AllProcuctController allProcuctController = Get.find<AllProcuctController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allProcuctController.inProgress) {
      allProcuctController.getProductList();
    }
    {
      allProcuctController.getProductList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchBar(
                  shouldBackButton: widget.shouldBackButton,
              
                ),
                heightBox12,
                SizedBox(
                  width: 200.w,
                  child: Text(
                    'Shop Your Health Must-Haves',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
                heightBox12,
                SizedBox(
                  height: 700.h,
                  child: GetBuilder<AllProcuctController>(
                    builder: (controller) {
                      if (controller.inProgress && controller.page == 1) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: scrollController,
                              itemCount: controller.allProductList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 1.35,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: ProductCard(
                                    productsModel:
                                        controller.allProductList[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(
                              replacement: Container(),
                              visible: controller.inProgress,
                              child: CircularProgressIndicator())
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
