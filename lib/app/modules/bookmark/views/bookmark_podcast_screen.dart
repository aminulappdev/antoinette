import 'package:antoinette/app/modules/bookmark/controller/bookmar_podcast_details_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_podcast_controller.dart';
import 'package:antoinette/app/modules/bookmark/views/bookmark_podcast_details_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkPodcastScreen extends StatefulWidget {
  const BookmarkPodcastScreen({super.key});

  @override
  State<BookmarkPodcastScreen> createState() => _BookmarkPodcastScreenState();
}

class _BookmarkPodcastScreenState extends State<BookmarkPodcastScreen> {
  BookmarkPodcastDetailsController bookmarkPodcastDetailsController =
      BookmarkPodcastDetailsController();
  BookmarkPodcastController bookmarkPodcastController =
      Get.find<BookmarkPodcastController>();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    bookmarkPodcastController.getbookmarkArticleList();
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !bookmarkPodcastController.inProgress) {
      bookmarkPodcastController.getbookmarkArticleList();
    }
    {
      bookmarkPodcastController.getbookmarkArticleList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<BookmarkPodcastController>(
              
              builder: (controller) {
              if (controller.inProgress && controller.page == 1) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 645.h,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.bookmarkPodcastList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: GestureDetector(
                        onTap: () {
                          getBookmarkPodcastScreen(
                              '${controller.bookmarkPodcastList[index].sId}');
                          // getBookmarkPodcastScreen(
                          //     '67f7576f01987bd380ea973f');
                        },
                        child: Container(
                          height: 104.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 84.h,
                                  width: 73.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(

                                        image: controller
                                                    .bookmarkPodcastList[index]
                                                    .reference!
                                                    .thumbnail !=
                                                null
                                            ? NetworkImage(
                                                '${controller.bookmarkPodcastList[index].reference!.thumbnail}')
                                            : AssetImage(
                                                AssetsPath.womenBookRead),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                widthBox4,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 180.h,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        '${controller.bookmarkPodcastList[index].reference?.title}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                    heightBox4,
                                    SizedBox(
                                      width: 180.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 64.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                              child: Text(
                                                'Episod 12',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10.sp),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30.h,
                                            width: 64.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                              child: Text(
                                                '12 min',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10.sp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                widthBox40,
                                CircleAvatar(
                                  radius: 21.r,
                                  backgroundColor: Color(0xffA57EA5),
                                  child: Icon(Icons.play_arrow),
                                )
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

  Future<void> getBookmarkPodcastScreen(String id) async {
    final bool isSuccess =
        await bookmarkPodcastDetailsController.getBookmarkPodcastDetails(id);

    if (isSuccess) {
      if (mounted) {
        Navigator.pushNamed(context, BookMarkPodcastDetailsScreen.routeName,
            arguments: bookmarkPodcastDetailsController.bookmarkPodcastModel);
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, bookmarkPodcastDetailsController.errorMessage!, true);
        }
      }
    }
  }
}
