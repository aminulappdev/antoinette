



import 'package:antoinette/app/modules/bookmark/views/bookmark_letter_bar.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class BookmarkScreen extends StatefulWidget {
  static const String routeName = '/bookmark-screen';
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox24,
            Padding(
            padding:  EdgeInsets.all(12.0.h),
              child: CustomAppBar(name: 'Bookmarks'),
            ),
                     BookmarkBar()
          ],
        ),
      ),
    );
  }
}