import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/bookmark/model/bookmark_podcast_details_model.dart';
import 'package:antoinette/app/modules/letters/views/player_widget.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookMarkPodcastDetailsScreen extends StatefulWidget {
  final BookmarkPodcastDetailsItemModel bookmarkPodcastDetailsItemModel;
  static const String routeName = '/bookmark-podcast-details-screen';
  const BookMarkPodcastDetailsScreen(
      {super.key, required this.bookmarkPodcastDetailsItemModel});

  @override
  State<BookMarkPodcastDetailsScreen> createState() =>
      _BookMarkPodcastDetailsScreenState();
}

class _BookMarkPodcastDetailsScreenState
    extends State<BookMarkPodcastDetailsScreen> {
  final BookMarkController bookMarkController = BookMarkController();
  late String userId;
  ProfileController profileController = Get.find<ProfileController>();
  late AudioPlayer player;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    userId = profileController.profileData!.sId!;
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    player.setSource(UrlSource(
        widget.bookmarkPodcastDetailsItemModel.reference?.fileLink ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    // String? isoDate = widget.bookmarkPodcastModel.publishedAt;
    // DateTime parsedDate = DateTime.parse(isoDate!);
    // String readableDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundColor: const Color(0xff000000).withOpacity(0.1),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ],
              ),
              heightBox16,
              Container(
                height: 274.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: widget.bookmarkPodcastDetailsItemModel.reference
                                  ?.thumbnail !=
                              null
                          ? NetworkImage(
                              '${widget.bookmarkPodcastDetailsItemModel.reference?.thumbnail}')
                          : AssetImage(AssetsPath.womenBookRead),
                      fit: BoxFit.fill),
                ),
              ),
              heightBox8,
              Text(
                widget.bookmarkPodcastDetailsItemModel.reference?.title ?? '',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Author: ${widget.bookmarkPodcastDetailsItemModel.reference?.author ?? ''}',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  // Text(
                  //   'Published Date: $readableDate',
                  //   style: GoogleFonts.poppins(fontSize: 12.sp),
                  // ),
                ],
              ),
              heightBox30,
              PlayerWidget(player: player),
            ],
          ),
        ),
      ),
    );
  }
}
