import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_details_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/delete_bookmark_controller.dart';
import 'package:antoinette/app/modules/bookmark/views/bookmark_article_details_page.dart';
import 'package:antoinette/app/utils/app_colors.dart';
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
  final BookmarkArticleDetailsController bookmarkArticleDetailsController = BookmarkArticleDetailsController();
  final BookmarkArticlesController bookmarkArticlesController = Get.find<BookmarkArticlesController>();
  final DeleteBookmarkController deleteBookmarkController = Get.find<DeleteBookmarkController>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searcCtrl = TextEditingController();
  String search = '';
  bool _isTapping = false;

  @override
  void initState() {
    print('Open bookmark article page');
    bookmarkArticlesController.refreshBookmarkList(); // Fetch fresh list on init
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 && !bookmarkArticlesController.inProgress) {
      bookmarkArticlesController.getbookmarkArticleList();
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
            // Search bar (not dependent on Obx)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey[300]!),
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
            // Use Obx only for the list portion that depends on bookmarkArticleList
            Obx(() {
              if (bookmarkArticlesController.inProgress && bookmarkArticlesController.initialInProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 680.h,
                child: bookmarkArticlesController.bookmarkArticleList.isEmpty
                    ? const Center(child: Text('No bookmarks found'))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        itemCount: bookmarkArticlesController.bookmarkArticleList.length,
                        itemBuilder: (context, index) {
                          var title = bookmarkArticlesController.bookmarkArticleList[index].reference?.title;
                          if (searcCtrl.text.isEmpty ||
                              (title != null && title.toLowerCase().contains(searcCtrl.text.toLowerCase()))) {
                            return buildArticleItem(context, bookmarkArticlesController, index);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildArticleItem(BuildContext context, BookmarkArticlesController controller, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: InkWell(
        onTap: _isTapping
            ? null
            : () async {
                if (!_isTapping) {
                  setState(() {
                    _isTapping = true;
                  });
                  await getBookmarkArticleScreen(controller.bookmarkArticleList[index].sId ?? '');
                  setState(() {
                    _isTapping = false;
                  });
                }
              },
        child: Container(
          height: 200.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: controller.bookmarkArticleList[index].reference?.thumbnail != null
                  ? NetworkImage(controller.bookmarkArticleList[index].reference!.thumbnail!)
                  : const AssetImage(AssetsPath.demo),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(222, 255, 255, 255),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 50,
                          child: Text(
                            controller.bookmarkArticleList[index].reference?.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.poppins(fontSize: 10.sp),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      controller.bookmarkArticleList[index].reference?.title ?? '',
                      style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.h,
                child: GestureDetector(
                  onTap: _isTapping
                      ? null
                      : () async {
                          if (!_isTapping) {
                            setState(() {
                              _isTapping = true;
                            });
                            await _removeBookmark(controller.bookmarkArticleList[index].sId ?? '');
                            setState(() {
                              _isTapping = false;
                            });
                          }
                        },
                  child: CircleAvatar(
                    radius: 21.r,
                    backgroundColor: const Color(0xff000000).withOpacity(0.1),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getBookmarkArticleScreen(String id) async {
    if (id.isEmpty) return;
    final bool isSuccess = await bookmarkArticleDetailsController.getBookmarkArticleDetails(id);

    if (isSuccess && mounted) {
      print('Bookmark article details: ${bookmarkArticleDetailsController.bookmarkArticleModel?.reference?.title}');
      Navigator.pushNamed(context, BookmarkArticleDetailsScreen.routeName,
          arguments: bookmarkArticleDetailsController.bookmarkArticleModel);
    } else if (mounted) {
      showSnackBarMessage(
          context, bookmarkArticleDetailsController.errorMessage ?? 'Error occurred', true);
    }
  }

  Future<void> _removeBookmark(String bookmarkId) async {
    if (bookmarkId.isEmpty) {
      if (mounted) {
        showSnackBarMessage(context, 'Invalid bookmark ID', true);
      }
      return;
    }
    try {
      final bool isSuccess = await deleteBookmarkController.deleteBookmark(bookmarkId);
      if (isSuccess && mounted) {
        showSnackBarMessage(context, 'Bookmark removed');
        await bookmarkArticlesController.refreshBookmarkList();
      } else if (mounted) {
        if (deleteBookmarkController.errorMessage?.contains('Content bookmark not found') == true) {
          showSnackBarMessage(context, 'Bookmark not found, refreshing list', true);
          await bookmarkArticlesController.refreshBookmarkList();
        } else {
          showSnackBarMessage(context, deleteBookmarkController.errorMessage ?? 'Failed to remove bookmark', true);
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBarMessage(context, 'Error removing bookmark: $e', true);
      }
      await bookmarkArticlesController.refreshBookmarkList();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searcCtrl.dispose();
    super.dispose();
  }
}