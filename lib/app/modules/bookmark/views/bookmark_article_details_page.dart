import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/bookmark/model/bookmark_article_details_model.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookmarkArticleDetailsScreen extends StatefulWidget {
  final BookmarkArticleItemModel bookmarkArticleItemModel;
  static const String routeName = '/bookmark-article-details-screen';
  const BookmarkArticleDetailsScreen({super.key, required this.bookmarkArticleItemModel});

  @override
  State<BookmarkArticleDetailsScreen> createState() => _BookmarkArticleDetailsScreenState();
}

class _BookmarkArticleDetailsScreenState extends State<BookmarkArticleDetailsScreen> {

  final BookMarkController bookMarkController = BookMarkController();
  

  bool isBookmarked = false; // Track whether the article is bookmarked or not

  

  @override
  Widget build(BuildContext context) {
    String? isoDate = widget.bookmarkArticleItemModel.reference?.publishedAt;
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
                        context, BookmarkArticleDetailsScreen.routeName);
                  },
                  child: Container(
                    height: 200.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetsPath.womenBookRead), fit: BoxFit.fill),
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
                '${widget.bookmarkArticleItemModel.reference?.title}',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              Text(
                'Author: ${widget.bookmarkArticleItemModel.reference?.author}',
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

 
}
