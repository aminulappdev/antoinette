import 'package:antoinette/app/modules/letters/model/article_details_model.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
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
  late String userId;
  ProfileController profileController = Get.find<ProfileController>();

  bool isBookmarked = false; // Track whether the article is bookmarked or not

  @override
  void initState() {
    super.initState();
    userId = profileController.profileData!.sId!;
    // Check if the article is already bookmarked
  }

  @override
  Widget build(BuildContext context) {
    String? isoDate = widget.articleModel.publishedAt;
    DateTime parsedDate = DateTime.parse(isoDate!);
    String readableDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
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
                            image: widget.articleModel.thumbnail != null
                                ? NetworkImage(
                                    '${widget.articleModel.thumbnail}')
                                : AssetImage(AssetsPath.womenBookRead),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)),
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
                              radius: 21,
                              backgroundColor:
                                  Color(0xff000000).withOpacity(0.1),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Toggle the bookmark status
                              setState(() {
                                isBookmarked = !isBookmarked;
                              });
                              bookmark(userId, '${widget.articleModel.sId}');
                            },
                            child: CircleAvatar(
                              radius: 21.r,
                              backgroundColor:
                                  Color(0xff000000).withOpacity(0.1),
                              child: Icon(
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
              ),
              Text(
                '${widget.articleModel.title}',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              Text(
                'Author: ${widget.articleModel.author}',
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              heightBox4,
              Text(
                'Published Date: $readableDate',
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              heightBox4,
              Text(
                'Introduction',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              heightBox4,
              Text(
                'In our fast-paced world, mental and physical health are often treated as separate entities. However, science continues to reveal that our mind and body are deeply interconnected. Stress, anxiety, and emotional struggles can manifest as physical symptoms, just as physical habits—like movement and nutrition—can significantly impact mental well-being. Welcome to Mind & Body Space, where we explore how to create harmony between the two.',
                style: GoogleFonts.poppins(fontSize: 10.sp),
                textAlign: TextAlign.justify,
              ),
              heightBox4,
              Text(
                'The Science Behind the Mind-Body Connection',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              heightBox4,
              Text(
                'In our fast-paced world, mental and physical health are often treated as separate entities. However, science continues to reveal that our mind and body are deeply interconnected. Stress, anxiety, and emotional struggles can manifest as physical symptoms, just as physical habits—like movement and nutrition—can significantly impact mental well-being. Welcome to Mind & Body Space, where we explore how to create harmony between the two.',
                style: GoogleFonts.poppins(fontSize: 10.sp),
                textAlign: TextAlign.justify,
              ),
              heightBox4,
              Text(
                'Sleep: The Foundation of Mental & Physical Wellness',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              heightBox4,
              Text(
                'In our fast-paced world, mental and physical health are often treated as separate entities. However, science continues to reveal that our mind and body are deeply interconnected. Stress, anxiety, and emotional struggles can manifest as physical symptoms, just as physical habits—like movement and nutrition—can significantly impact mental well-being. Welcome to Mind & Body Space, where we explore how to create harmony between the two.',
                style: GoogleFonts.poppins(fontSize: 10.sp),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> bookmark(String user, String reference) async {
    final bool isSuccess =
        await bookMarkController.addBookmark(user, reference, 'Article');

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(
            context, 'Bookmark ${isBookmarked ? 'added' : 'removed'}');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, bookMarkController.errorMessage!, true);
      }
    }
  }
}
