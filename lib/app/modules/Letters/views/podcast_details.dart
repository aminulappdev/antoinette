import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/letters/model/podcast_details_model.dart';
import 'package:antoinette/app/modules/letters/views/player_widget.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PodcastDetailsScreen extends StatefulWidget {
  final PodcastModel podcastModel;
  static const String routeName = '/podcast-details-screen';
  const PodcastDetailsScreen({super.key, required this.podcastModel});

  @override
  State<PodcastDetailsScreen> createState() => _PodcastDetailsScreenState();
}

class _PodcastDetailsScreenState extends State<PodcastDetailsScreen> {
  final BookMarkController bookMarkController = BookMarkController();
  late String userId;
  ProfileController profileController = Get.find<ProfileController>();
  late AudioPlayer player;
  bool isBookmarked = false; // Track whether the article is bookmarked or not

  @override
  void initState() {
    super.initState();
    userId = profileController.profileData!.sId!;
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    // player.setSource(UrlSource(widget.podcastModel.fileLink ?? ''));
    player.setSource(UrlSource('https://file-examples.com/storage/fe32d8b189680228b9ad370/2017/11/file_example_MP3_700KB.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    String? isoDate = widget.podcastModel.publishedAt;
    DateTime parsedDate = DateTime.parse(isoDate!);
    String readableDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });
                      bookmark(userId, '${widget.podcastModel.sId}');
                    },
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundColor: const Color(0xff000000).withOpacity(0.1),
                      child: Icon(
                        isBookmarked
                            ? Icons.favorite
                            : Icons.favorite_border_sharp,
                        color: isBookmarked ? Colors.red : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              heightBox16,
              Container(
                height: 274.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: widget.podcastModel.thumbnail != null
                          ? NetworkImage('${widget.podcastModel.thumbnail}')
                          : AssetImage(AssetsPath.womenBookRead),
                      fit: BoxFit.fill),
                ),
              ),
              heightBox8,
              Text(
                widget.podcastModel.title ?? '',
                style: GoogleFonts.poppins(fontSize: 15.sp),
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Author: ${widget.podcastModel.author ?? ''}',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  Text(
                    'Published Date: $readableDate',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
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

  Future<void> bookmark(String user, String reference) async {
    final bool isSuccess =
        await bookMarkController.addBookmark(user, reference, 'Podcast');

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Bookmark added');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, bookMarkController.errorMessage!, true);
      }
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
