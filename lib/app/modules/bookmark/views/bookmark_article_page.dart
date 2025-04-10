import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_details_controller.dart';
import 'package:antoinette/app/modules/bookmark/views/bookmark_article_details_page.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkArticleScreen extends StatefulWidget {
  const BookmarkArticleScreen({super.key});

  @override
  State<BookmarkArticleScreen> createState() => _BookmarkArticleScreenState();
}

class _BookmarkArticleScreenState extends State<BookmarkArticleScreen> {
  BookmarkArticleDetailsController bookmarkArticleDetailsController =
      BookmarkArticleDetailsController();
  BookmarkArticlesController bookmarkArticlesController =
      Get.find<BookmarkArticlesController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    bookmarkArticlesController.getbookmarkArticleList();
    print(bookmarkArticlesController.bookmarkarticlesList);
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !bookmarkArticlesController.inProgress) {
      bookmarkArticlesController.getbookmarkArticleList();
    }
    {
      bookmarkArticlesController.getbookmarkArticleList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: GetBuilder<BookmarkArticlesController>(builder: (controller) {
          if (controller.inProgress && controller.page == 1) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 680.h,
                child: ListView.builder(
                  itemCount: controller.bookmarkarticlesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: InkWell(
                        onTap: () {
                          getArticleScreen(
                              '${controller.bookmarkArticleList[index].sId}');
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
                                    '${controller.bookmarkArticleList[index].reference?.title}',
                                    style: GoogleFonts.poppins(fontSize: 10.sp),
                                  )),
                                ),
                                SizedBox(
                                  height: 120.h,
                                ),
                                Text('${controller.bookmarkArticleList[index].reference?.title}',
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
              )
            ],
          );
        }),
      ),
    );
  }

  Future<void> getArticleScreen(String id) async {
    final bool isSuccess =
        await bookmarkArticleDetailsController.getBookmarkArticleDetails(id);

    if (isSuccess) {
      if (mounted) {
        print('my data ..............................');
        print('${bookmarkArticleDetailsController.articleModel?.reference?.title}');
        print('${bookmarkArticleDetailsController.articleModel}');
        Navigator.pushNamed(context, BookmarkArticleDetailsScreen.routeName,
            arguments: bookmarkArticleDetailsController.articleModel);
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, bookmarkArticleDetailsController.errorMessage!, true);
        }
      }
    }
  }
}
