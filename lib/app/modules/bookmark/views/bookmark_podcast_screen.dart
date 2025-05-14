import 'package:antoinette/app/modules/bookmark/controller/bookmar_podcast_details_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_podcast_controller.dart';
import 'package:antoinette/app/modules/bookmark/views/bookmark_podcast_details_screen.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
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
  final TextEditingController searcCtrl = TextEditingController();
  String search = '';
  bool _isTapping = false; // Flag to prevent multiple taps

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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                          onTap: () {
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(
                              Icons.search_rounded,
                              size: 30.h,
                              color: AppColors.iconButtonThemeColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searcCtrl,
                            onChanged: (value) {
                              setState(() {
                                search = value;
                              });
                            },
                            decoration: const InputDecoration(
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
            SizedBox(height: 10.h),
            GetBuilder<BookmarkPodcastController>(builder: (controller) {
              if (controller.inProgress && controller.page == 1) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 645.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  itemCount: controller.bookmarkPodcastList.length,
                  itemBuilder: (context, index) {
                    var title = controller.bookmarkPodcastList[index].reference?.title;

                    if (searcCtrl.text.isEmpty) {
                      return buildPodcastItem(context, controller, index);
                    } else if (title != null &&
                        title.toLowerCase().contains(searcCtrl.text.toLowerCase())) {
                      return buildPodcastItem(context, controller, index);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildPodcastItem(
      BuildContext context, BookmarkPodcastController controller, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: GestureDetector(
        onTap: _isTapping
            ? null
            : () async {
                if (!_isTapping) {
                  setState(() {
                    _isTapping = true;
                  });
                  await getBookmarkPodcastScreen(
                      controller.bookmarkPodcastList[index].sId ?? '');
                  setState(() {
                    _isTapping = false;
                  });
                }
              },
        child: Container(
          height: 104.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 84.h,
                  width: 73.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: controller.bookmarkPodcastList[index].reference?.thumbnail != null
                          ? NetworkImage(
                              controller.bookmarkPodcastList[index].reference!.thumbnail!)
                          : const AssetImage(AssetsPath.demo),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: Text(
                        controller.bookmarkPodcastList[index].reference?.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 180.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30.h,
                            width: 64.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                'Episod 12', // Replace with dynamic data if available
                                style: GoogleFonts.poppins(fontSize: 10.sp),
                              ),
                            ),
                          ),
                          Container(
                            height: 30.h,
                            width: 64.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                '12 min', // Replace with dynamic data if available
                                style: GoogleFonts.poppins(fontSize: 10.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40.w),
                CircleAvatar(
                  radius: 21.r,
                  backgroundColor: const Color(0xffA57EA5),
                  child: const Icon(Icons.play_arrow),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getBookmarkPodcastScreen(String id) async {
    if (id.isEmpty) return; // Guard against empty ID
    final bool isSuccess =
        await bookmarkPodcastDetailsController.getBookmarkPodcastDetails(id);

    if (isSuccess && mounted) {
      Navigator.pushNamed(context, BookMarkPodcastDetailsScreen.routeName,
          arguments: bookmarkPodcastDetailsController.bookmarkPodcastModel);
    } else if (mounted) {
      showSnackBarMessage(
          context, bookmarkPodcastDetailsController.errorMessage ?? 'Error occurred', true);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searcCtrl.dispose();
    super.dispose();
  }
}