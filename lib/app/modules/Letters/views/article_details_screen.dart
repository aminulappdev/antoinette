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
  final BookMarkController bookMarkController = Get.find<BookMarkController>();
  final DeleteBookmarkController deleteBookmarkController = Get.find<DeleteBookmarkController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final BookmarkArticlesController bookmarkArticlesController = Get.find<BookmarkArticlesController>();

  bool isBookmarked = false;
  String? bookmarkId;
  bool _isLoading = false;
  String? userId;

  @override
  void initState() {
    super.initState();
    // Load profile data
    if (profileController.profileData != null) {
      userId = profileController.profileData!.sId;
      _loadBookmarkStatus();
    } else {
      profileController.getProfileData().then((_) {
        if (mounted) {
          setState(() {
            userId = profileController.profileData?.sId;
          });
          _loadBookmarkStatus();
        }
      });
    }
  }

  // Load bookmark status
  Future<void> _loadBookmarkStatus() async {
    if (userId == null || widget.articleModel.sId == null) {
      if (mounted) {
        showSnackBarMessage(context, 'Invalid user or article ID', true);
      }
      return;
    }
    try {
      await bookmarkArticlesController.refreshBookmarkList();
      _checkIfBookmarked();
    } catch (e) {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to load bookmark list: $e', true);
      }
    }
  }

  // Check if the article is bookmarked
  void _checkIfBookmarked() {
    final articleId = widget.articleModel.sId;
    if (articleId == null) {
      if (mounted) {
        showSnackBarMessage(context, 'Invalid article ID', true);
      }
      return;
    }
    final bookmarkItem = bookmarkArticlesController.bookmarkArticleList
        .firstWhereOrNull((item) => item.reference?.sId == articleId);
    if (mounted) {
      setState(() {
        isBookmarked = bookmarkItem != null;
        bookmarkId = bookmarkItem?.sId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? isoDate = widget.articleModel.publishedAt;
    String readableDate = '';
    if (isoDate != null) {
      try {
        DateTime parsedDate = DateTime.parse(isoDate);
        readableDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
      } catch (e) {
        readableDate = 'Unknown Date';
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundColor: const Color(0xff000000).withOpacity(0.1),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: _isLoading || userId == null || widget.articleModel.sId == null
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              if (!isBookmarked) {
                                await _bookmarkArticle();
                              } else {
                                await _removeBookmark();
                              }
                              // Refresh bookmark list
                              await bookmarkArticlesController.refreshBookmarkList();
                              _checkIfBookmarked();
                            } catch (e) {
                              if (mounted) {
                                showSnackBarMessage(context, 'Error: $e', true);
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundColor: const Color(0xff000000).withOpacity(0.1),
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
                              isBookmarked ? Icons.favorite : Icons.favorite_border_sharp,
                              color: isBookmarked ? Colors.red : Colors.white,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                height: 274.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: widget.articleModel.thumbnail != null
                        ? NetworkImage(widget.articleModel.thumbnail!)
                        : const AssetImage(AssetsPath.demo),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.articleModel.title ?? 'No Title',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              SizedBox(height: 12.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Author: ${widget.articleModel.author ?? 'Unknown'}',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  Text(
                    'Published Date: $readableDate',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Html(data: widget.articleModel.description ?? 'No Description'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _bookmarkArticle() async {
    if (userId == null || widget.articleModel.sId == null) {
      if (mounted) {
        showSnackBarMessage(context, 'Invalid user or article ID', true);
      }
      return;
    }
    try {
      final bool isSuccess = await bookMarkController.addBookmark(userId!, widget.articleModel.sId!, 'Article');
      if (isSuccess && mounted) {
        showSnackBarMessage(context, 'Bookmark added');
        setState(() {
          isBookmarked = true; // Update state on success
        });
      } else if (mounted) {
        showSnackBarMessage(context, bookMarkController.errorMessage ?? 'Failed to add bookmark', true);
      }
    } catch (e) {
      if (mounted) {
        showSnackBarMessage(context, 'Error adding bookmark: $e', true);
      }
    }
  }

  Future<void> _removeBookmark() async {
    if (bookmarkId == null) {
      if (mounted) {
        showSnackBarMessage(context, 'Invalid bookmark ID', true);
      }
      // Refresh list to ensure UI consistency
      await bookmarkArticlesController.refreshBookmarkList();
      _checkIfBookmarked();
      return;
    }
    try {
      final bool isSuccess = await deleteBookmarkController.deleteBookmark(bookmarkId!);
      if (isSuccess && mounted) {
        showSnackBarMessage(context, 'Bookmark removed');
        setState(() {
          isBookmarked = false; // Update state on success
          bookmarkId = null; // Reset bookmark ID
        });
      } else if (mounted) {
        // Handle "Content bookmark not found" error
        if (deleteBookmarkController.errorMessage?.contains('Content bookmark not found') == true) {
          showSnackBarMessage(context, 'Bookmark not found, refreshing list', true);
          await bookmarkArticlesController.refreshBookmarkList();
          _checkIfBookmarked();
        } else {
          showSnackBarMessage(context, deleteBookmarkController.errorMessage ?? 'Failed to remove bookmark', true);
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBarMessage(context, 'Error removing bookmark: $e', true);
      }
      // Refresh list in case of error to ensure UI consistency
      await bookmarkArticlesController.refreshBookmarkList();
      _checkIfBookmarked();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}