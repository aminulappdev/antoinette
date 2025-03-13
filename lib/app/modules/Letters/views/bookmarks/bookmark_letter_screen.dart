
import 'package:antoinette/app/modules/letters/views/bookmarks/bookmark_letter_bar.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
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
    return  SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding:  EdgeInsets.all(12.0.h),
              child: CustomAppBar(name: 'Bookmarks'),
            ),
            BookmarkBar(),           
          ],
        ),
      ),
    );
  }
}