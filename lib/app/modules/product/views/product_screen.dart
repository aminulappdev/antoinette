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
  AllProcuctController allProcuctController = Get.find<AllProcuctController>();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allProcuctController.inProgress) {
      allProcuctController.fetchAllProducts(null); // Trigger fetch more data
    }
  }

  void _onSearch() {
    String query = searchController.text;
    allProcuctController.onSearchQueryChangedSession(query); // Trigger search
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 24.r,
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    widthBox4,
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: _onSearch,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.search_rounded,
                                  size: 30.h,
                                  color: AppColors.iconButtonThemeColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                onChanged: (_) {
                                  _onSearch(); // Trigger search on text change
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
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
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
                heightBox12,
                SizedBox(
                  height: 700.h,
                  child: Obx(
                    () {
                      if (allProcuctController.inProgress &&
                          allProcuctController.page == 1) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: scrollController,
                              itemCount:
                                  allProcuctController.allProductsList.length,
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
                                    productsModel: allProcuctController
                                        .allProductsList[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(
                            replacement: Container(),
                            visible: allProcuctController.inProgress,
                            child: CircularProgressIndicator(),
                          ),
                          heightBox100,
                          heightBox16
                        ],
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
