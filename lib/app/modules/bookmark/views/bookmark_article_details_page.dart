import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/bookmark/model/bookmark_article_details_model.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkArticleDetailsScreen extends StatefulWidget {
  final BookmarkArticleDetailsItemModel bookmarkArticleItemModel;
  static const String routeName = '/bookmark-article-details-screen';
  const BookmarkArticleDetailsScreen(
      {super.key, required this.bookmarkArticleItemModel});

  @override
  State<BookmarkArticleDetailsScreen> createState() =>
      _BookmarkArticleDetailsScreenState();
}

class _BookmarkArticleDetailsScreenState
    extends State<BookmarkArticleDetailsScreen> {
  final BookMarkController bookMarkController = BookMarkController();

  bool isBookmarked = false; // Track whether the article is bookmarked or not

  @override
  Widget build(BuildContext context) {
    // DateTime parsedDate = DateTime.parse(isoDate!);
    // String readableDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
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
                       color: Colors.grey,
                        image: DecorationImage(
                            image: widget.bookmarkArticleItemModel.reference
                                        ?.thumbnail !=
                                    null
                                ? NetworkImage(
                                    '${widget.bookmarkArticleItemModel.reference?.thumbnail}')
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
              // Text(
              //   'Published Date: $readableDate',
              //   style: GoogleFonts.poppins(fontSize: 12.sp),
              // ),
              heightBox4,
              Html(
                  data:
                      widget.bookmarkArticleItemModel.reference?.description)
            ],
          ),
        ),
      ),
    );
  }
}
