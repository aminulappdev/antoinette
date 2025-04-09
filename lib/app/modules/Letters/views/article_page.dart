import 'package:antoinette/app/modules/letters/controllers/all_articles_controller.dart';
import 'package:antoinette/app/modules/letters/views/article_details_screen.dart';
import 'package:antoinette/app/modules/letters/controllers/article_details_controller.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
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

  ArticleDetailsController articletDetailsController =
      ArticleDetailsController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    allArticlesController.getArticlesList();
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
            GetBuilder<AllArticlesController>(
              builder: (controller) {
                if (controller.inProgress && controller.page == 1) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.articlesList.length,
                    itemBuilder: (context, index) {
                      if (controller.articlesList[index].status ==
                          'published') {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: InkWell(
                            onTap: () {
                              getArticleScreen(
                                  '${controller.articlesList[index].sId}');
                            },
                            child: Container(
                              height: 200.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          AssetsPath.womenBookRead)),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: EdgeInsets.all(12.0.h),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 27.h,
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              222, 255, 255, 255)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            '${controller.articlesList[index].title}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100.h,
                                    ),
                                    Text(
                                      maxLines: 2,
                                        '${controller.articlesList[index].description}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                        
                      }
                      else{
                        return Container();
                      }
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> getArticleScreen(String id) async {

    final bool isSuccess =
        await articletDetailsController.getArticleDetails(id);

    if (isSuccess) {
      if (mounted) {
        Navigator.pushNamed(context, ArticleDetailsScreen.routeName,
            arguments: articletDetailsController.articleModel);
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, articletDetailsController.errorMessage!, true);
        }
      }
    }
  }
}
