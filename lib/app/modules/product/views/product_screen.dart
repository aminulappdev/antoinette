import 'package:antoinette/app/modules/product/controllers/all_product_controller.dart';
import 'package:antoinette/app/modules/product/widgets/product_card.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
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
  final AllProductController allProductController =
      Get.find<AllProductController>();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initial fetch
    allProductController.fetchAllProducts(null);
  }

  void _onSearch(String query) {
    allProductController.onSearchQueryChangedProducts(query); // Trigger search
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox24,
            Row(
              children: [
                if (widget.shouldBackButton)
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 24.r,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (widget.shouldBackButton) widthBox4,
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Icon(
                            Icons.search_rounded,
                            size: 30.h,
                            color: AppColors.iconButtonThemeColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            onChanged: _onSearch,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Search products...',
                              hintStyle: GoogleFonts.poppins(fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            heightBox12,
            SizedBox(
              width: 200.w,
              child: Text(
                'Shop Your Health Must-Haves',
                style: GoogleFonts.poppins(fontSize: 20.sp),
              ),
            ),
            heightBox12,
            Expanded(
              child: Obx(() {
                if (allProductController.inProgress &&
                    allProductController.allProductsList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                final filteredList = searchController.text.isEmpty
                    ? allProductController.allProductsList
                    : allProductController.allProductsList
                        .where((product) =>
                            product.name?.toLowerCase().contains(
                                searchController.text.toLowerCase()) ??
                            false)
                        .toList();
                if (filteredList.isEmpty && !allProductController.inProgress) {
                  return Center(
                    child: Text(
                      'Data session available',
                      style: GoogleFonts.poppins(fontSize: 16.sp),
                    ),
                  );
                }
                return GridView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: filteredList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.35,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: ProductCard(
                        productsModel: filteredList[index],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
