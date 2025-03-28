import 'package:antoinette/app/modules/letters/controllers/all_articles_controller.dart';
import 'package:antoinette/app/modules/letters/views/article_details_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  AllArticlesController allArticlesController =
      Get.find<AllArticlesController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allArticlesController.inProgress) {
      allArticlesController.getArticlesList();
    }
    {
      allArticlesController.getArticlesList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.h),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended for You',
              style: GoogleFonts.poppins(fontSize: 20.sp),
            ),
            GetBuilder<AllArticlesController>(builder: (controller) {
              if (controller.inProgress && controller.page == 1) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.articlesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ArticleDetailsScreen.routeName);
                        },
                        child: Container(
                          height: 200.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AssetsPath.womenBookRead)),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.all(12.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 27.h,
                                  width: 82.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          222, 255, 255, 255)),
                                  child: Center(
                                      child: Text(
                                    '${controller.articlesList[index].title}',
                                    style: GoogleFonts.poppins(fontSize: 10.sp),
                                  )),
                                ),
                                SizedBox(
                                  height: 120.h,
                                ),
                                Text(
                                    '${controller.articlesList[index].description}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp, color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
