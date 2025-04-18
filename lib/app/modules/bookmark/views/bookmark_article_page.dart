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
                          getBookmarkArticleScreen(
                              '${controller.bookmarkArticleList[index].sId}');
                        },
                        child: Container(
                          height: 200.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                              image: DecorationImage(
                                  image: controller.bookmarkArticleList[index]
                                              .reference!.thumbnail !=
                                          null
                                      ? NetworkImage(
                                          '${controller.bookmarkArticleList[index].reference!.thumbnail}')
                                      : AssetImage(AssetsPath.womenBookRead),fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.all(20.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          222, 255, 255, 255)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 50,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        '${controller.bookmarkArticleList[index].reference?.title}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 10.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                    '${controller.bookmarkArticleList[index].reference?.title}',
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

  Future<void> getBookmarkArticleScreen(String id) async {
    final bool isSuccess =
        await bookmarkArticleDetailsController.getBookmarkArticleDetails(id);

    if (isSuccess) {
      if (mounted) {
        print('my data ..............................');
        print(
            '${bookmarkArticleDetailsController.bookmarkArticleModel?.reference?.title}');
        print(
            '${bookmarkArticleDetailsController.bookmarkArticleModel?.reference?.description}');

        Navigator.pushNamed(context, BookmarkArticleDetailsScreen.routeName,
            arguments: bookmarkArticleDetailsController.bookmarkArticleModel);
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, bookmarkArticleDetailsController.errorMessage!, true);
        }
      }
    }
  }
}
