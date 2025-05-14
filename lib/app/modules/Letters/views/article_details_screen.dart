import 'package:antoinette/app/modules/bookmark/controller/bookmark_article_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/delete_bookmark_controller.dart';
import 'package:antoinette/app/modules/letters/model/article_details_model.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final ArticleModel articleModel;
  static const String routeName = '/article-details-screen';
  const ArticleDetailsScreen({super.key, required this.articleModel});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  final BookMarkController bookMarkController = BookMarkController();
  final DeleteBookmarkController deleteBookmarkController = DeleteBookmarkController();
  late String userId;
  ProfileController profileController = Get.find<ProfileController>();
  BookmarkArticlesController bookmarkArticlesController =
      Get.find<BookmarkArticlesController>();

  bool isBookmarked = false; // Track whether the article is bookmarked or not
  String? bookmarkId; // Store the bookmark ID for deletion
  bool _isLoading = false; // Track loading state for bookmark action

  @override
  void initState() {
    super.initState();
    userId = profileController.profileData!.sId!;
    // Fetch bookmark list and check if current article is bookmarked
    bookmarkArticlesController.getbookmarkArticleList().then((_) {
      checkIfBookmarked();
    });
  }

  // Check if the current article is in the bookmark list
  void checkIfBookmarked() {
    final articleId = widget.articleModel.sId;
    final bookmarkItem = bookmarkArticlesController.bookmarkArticleList
        .firstWhereOrNull((item) => item.reference?.sId == articleId);
    setState(() {
      isBookmarked = bookmarkItem != null;
      bookmarkId = bookmarkItem?.sId;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? isoDate = widget.articleModel.publishedAt;
    DateTime parsedDate = DateTime.parse(isoDate!);
    String readableDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Container(
                  height: 200.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.articleModel.thumbnail != null
                          ? NetworkImage('${widget.articleModel.thumbnail}')
                          : const AssetImage(AssetsPath.demo),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 21.r,
                            backgroundColor:
                                const Color(0xff000000).withOpacity(0.1),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _isLoading
                              ? null // Disable tap during loading
                              : () async {
                                  setState(() {
                                    _isLoading = true; // Start loading
                                  });
                                  if (!isBookmarked) {
                                    // Add bookmark
                                    await bookmark(userId, widget.articleModel.sId ?? '');
                                  } else {
                                    // Remove bookmark
                                    await removeBookmark(bookmarkId ?? '');
                                  }
                                  // Refresh bookmark list after adding/removing
                                  await bookmarkArticlesController.getbookmarkArticleList();
                                  checkIfBookmarked(); // Update bookmark status
                                  setState(() {
                                    _isLoading = false; // Stop loading
                                  });
                                },
                          child: CircleAvatar(
                            radius: 21.r,
                            backgroundColor:
                                const Color(0xff000000).withOpacity(0.1),
                            child: _isLoading
                                ? SizedBox(
                                    width: 24.r,
                                    height: 24.r,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    isBookmarked
                                        ? Icons.favorite
                                        : Icons.favorite_border_sharp,
                                    color: isBookmarked ? Colors.red : Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                widget.articleModel.title ?? '',
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
              Text(
                'Author: ${widget.articleModel.author ?? 'Unknown'}',
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              Text(
                'Published Date: $readableDate',
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              SizedBox(height: 4.h),
              Html(data: widget.articleModel.description ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> bookmark(String user, String reference) async {
    if (reference.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showSnackBarMessage(context, 'Invalid article ID', true);
      return;
    }
    final bool isSuccess =
        await bookMarkController.addBookmark(user, reference, 'Article');

    if (isSuccess && mounted) {
      showSnackBarMessage(context, 'Bookmark added');
      setState(() {
        isBookmarked = true; // Update status only on success
      });
    } else if (mounted) {
      showSnackBarMessage(context, bookMarkController.errorMessage ?? 'Error occurred', true);
    }
  }

  Future<void> removeBookmark(String bookmarkId) async {
    if (bookmarkId.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showSnackBarMessage(context, 'Invalid bookmark ID', true);
      return;
    }
    final bool isSuccess = await deleteBookmarkController.deleteBookmark(bookmarkId);

    if (isSuccess && mounted) {
      showSnackBarMessage(context, 'Bookmark removed');
      setState(() {
        isBookmarked = false; // Update status only on success
      });
    } else if (mounted) {
      showSnackBarMessage(context, deleteBookmarkController.errorMessage ?? 'Error occurred', true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}