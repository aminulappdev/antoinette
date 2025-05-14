
import 'dart:io';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/bookmark_podcast_controller.dart';
import 'package:antoinette/app/modules/bookmark/controller/delete_bookmark_controller.dart';
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
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PodcastDetailsScreen extends StatefulWidget {
  final PodcastModel podcastModel;
  static const String routeName = '/podcast-details-screen';
  const PodcastDetailsScreen({super.key, required this.podcastModel});

  @override
  State<PodcastDetailsScreen> createState() => _PodcastDetailsScreenState();
}

class _PodcastDetailsScreenState extends State<PodcastDetailsScreen> {
  final BookMarkController bookMarkController = BookMarkController();
  final DeleteBookmarkController deleteBookmarkController = DeleteBookmarkController();
  BookmarkPodcastController bookmarkPodcastController =
      Get.find<BookmarkPodcastController>();
  late String userId;
  ProfileController profileController = Get.find<ProfileController>();
  late AudioPlayer player;
  bool isBookmarked = false; // Track whether the podcast is bookmarked or not
  String? bookmarkId; // Store the bookmark ID for deletion
  bool _isLoading = false; // Track loading state for bookmark action

  @override
  void initState() {
    super.initState();
    userId = profileController.profileData!.sId!;
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    initializeAudio();
    // Fetch bookmark list and check if current podcast is bookmarked
    bookmarkPodcastController.getbookmarkArticleList().then((_) {
      checkIfBookmarked();
    });
  }

  // Check if the current podcast is in the bookmark list
  void checkIfBookmarked() {
    final podcastId = widget.podcastModel.sId;
    final bookmarkItem = bookmarkPodcastController.bookmarkPodcastList
        .firstWhereOrNull((item) => item.reference?.sId == podcastId);
    setState(() {
      isBookmarked = bookmarkItem != null;
      bookmarkId = bookmarkItem?.sId;
    });
  }

  Future<void> initializeAudio() async {
    final String url = widget.podcastModel.fileLink ?? '';
    print(url);

    if (url.isEmpty) {
      showSnackBarMessage(context, 'Invalid audio URL', true);
      return;
    }

    try {
      // Try to play directly from URL
      await player.setSource(UrlSource(url));
      print('✅ Playing from URL directly: $url');
    } catch (e) {
      print('❌ Failed to play from URL. Trying to download. Error: $e');

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final dir = await getTemporaryDirectory();
          final file = File('${dir.path}/temp_audio.mp3');
          await file.writeAsBytes(response.bodyBytes);
          print('✅ File downloaded at ${file.path}');

          await player.setSource(DeviceFileSource(file.path));
        } else {
          showSnackBarMessage(context, 'Server error (${response.statusCode})', true);
          print('❌ Server responded with ${response.statusCode}');
        }
      } catch (e) {
        showSnackBarMessage(context, 'Could not download or play audio.', true);
        print('❌ Exception while downloading: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String? isoDate = widget.podcastModel.publishedAt;
    DateTime parsedDate = DateTime.parse(isoDate!);
    String readableDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
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
                  onTap: _isLoading
                      ? null // Disable tap during loading
                      : () async {
                          setState(() {
                            _isLoading = true; // Start loading
                          });
                          if (!isBookmarked) {
                            // Add bookmark
                            await bookmark(userId, widget.podcastModel.sId ?? '');
                          } else {
                            // Remove bookmark
                            await removeBookmark(bookmarkId);
                          }
                          // Refresh bookmark list after adding/removing
                          await bookmarkPodcastController.getbookmarkArticleList();
                          checkIfBookmarked(); // Update bookmark status
                          setState(() {
                            _isLoading = false; // Stop loading
                          });
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
                            isBookmarked
                                ? Icons.favorite
                                : Icons.favorite_border_sharp,
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
                  image: widget.podcastModel.thumbnail != null
                      ? NetworkImage('${widget.podcastModel.thumbnail}')
                      : const AssetImage(AssetsPath.demo) as ImageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.podcastModel.title ?? '',
              style: GoogleFonts.poppins(fontSize: 15.sp),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Author: ${widget.podcastModel.author ?? 'Unknown'}',
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
                Text(
                  'Published Date: $readableDate',
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            PlayerWidget(player: player),
          ],
        ),
      ),
    );
  }

  Future<void> bookmark(String user, String reference) async {
    if (reference.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showSnackBarMessage(context, 'Invalid podcast ID', true);
      return;
    }
    final bool isSuccess =
        await bookMarkController.addBookmark(user, reference, 'Podcast');

    if (isSuccess && mounted) {
      showSnackBarMessage(context, 'Bookmark added');
      setState(() {
        isBookmarked = true; // Update status only on success
      });
    } else if (mounted) {
      showSnackBarMessage(context, bookMarkController.errorMessage ?? 'Error occurred', true);
      setState(() {
        _isLoading = false; // Ensure loading stops on error
      });
    }
  }

  Future<void> removeBookmark(String? bookmarkId) async {
    if (bookmarkId == null || bookmarkId.isEmpty) {
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
        this.bookmarkId = null; // Clear bookmark ID
      });
    } else if (mounted) {
      showSnackBarMessage(context, deleteBookmarkController.errorMessage ?? 'Error occurred', true);
      setState(() {
        _isLoading = false; // Ensure loading stops on error
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
