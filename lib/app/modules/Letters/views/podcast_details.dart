import 'package:antoinette/app/modules/letters/model/podcast_details_model.dart';
import 'package:antoinette/app/modules/letters/views/player_widget.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    player.setSource(UrlSource( widget.podcastModel.fileLink ?? ''));
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
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundColor: const Color(0xff000000).withOpacity(0.1),
                      child: const Icon(Icons.favorite_border_sharp, color: Colors.white),
                    ),
                  )
                ],
              ),
              heightBox16,
              Container(
                height: 274.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(AssetsPath.audioImage),
                    fit: BoxFit.fill,
                  ),
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

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
