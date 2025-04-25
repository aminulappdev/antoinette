import 'package:antoinette/app/modules/Letters/views/podcast_details.dart';
import 'package:antoinette/app/modules/letters/controllers/all_podcast_controller.dart';
import 'package:antoinette/app/modules/letters/controllers/poscast_details.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  AllPodcastController allPodcastController = Get.find<AllPodcastController>();
  PodcastDetailsController podcastDetailsController =
      PodcastDetailsController();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searcCtrl = TextEditingController();
  String search = '';

  @override
  void initState() {
    allPodcastController.getPodcastList();
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allPodcastController.inProgress) {
      allPodcastController.getPodcastList();
    }
    {
      allPodcastController.getPodcastList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.h),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(
                              Icons.search_rounded,
                              size: 30.h,
                              color: AppColors.iconButtonThemeColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searcCtrl,
                            onChanged: (value) {
                              setState(() {
                                search = value.toString();
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            heightBox10,
            Text(
              'Recommended for You',
              style: GoogleFonts.poppins(fontSize: 20.sp),
            ),
            GetBuilder<AllPodcastController>(builder: (controller) {
              if (controller.inProgress && controller.page == 1) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.podcastList.length,
                  itemBuilder: (context, index) {
                    if (controller.podcastList[index].status == 'published') {
                      var title = controller.allPodcastList[index].title;
                      if (searcCtrl.text.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: GestureDetector(
                            onTap: () {
                              getPodcastScreen(
                                  '${controller.podcastList[index].sId}');
                            },
                            child: Container(
                              height: 104.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 84.h,
                                      width: 73.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: controller.podcastList[index]
                                                        .thumbnail !=
                                                    null
                                                ? NetworkImage(
                                                    '${controller.podcastList[index].thumbnail}')
                                                : AssetImage(
                                                    AssetsPath.womenBookRead),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    widthBox4,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 180.h,
                                          child: Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            '${controller.podcastList[index].title}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                        heightBox4,
                                        SizedBox(
                                          width: 180.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 30.h,
                                                width: 64.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: Text(
                                                    'Episod ${controller.podcastList[index].episodeNumber}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10.sp),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 30.h,
                                                width: 64.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: Text(
                                                    '${controller.podcastList[index].duration} min',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10.sp),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    widthBox40,
                                    CircleAvatar(
                                      radius: 21.r,
                                      backgroundColor: Color(0xffA57EA5),
                                      child: Icon(Icons.play_arrow),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (title!
                          .toLowerCase()
                          .contains(searcCtrl.text.toLowerCase())) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: GestureDetector(
                            onTap: () {
                              getPodcastScreen(
                                  '${controller.podcastList[index].sId}');
                            },
                            child: Container(
                              height: 104.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 84.h,
                                      width: 73.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: controller.podcastList[index]
                                                        .thumbnail !=
                                                    null
                                                ? NetworkImage(
                                                    '${controller.podcastList[index].thumbnail}')
                                                : AssetImage(
                                                    AssetsPath.womenBookRead),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    widthBox4,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 180.h,
                                          child: Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            '${controller.podcastList[index].title}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                        heightBox4,
                                        SizedBox(
                                          width: 180.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 30.h,
                                                width: 64.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: Text(
                                                    'Episod ${controller.podcastList[index].episodeNumber}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10.sp),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 30.h,
                                                width: 64.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: Text(
                                                    '${controller.podcastList[index].duration} min',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10.sp),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    widthBox40,
                                    CircleAvatar(
                                      radius: 21.r,
                                      backgroundColor: Color(0xffA57EA5),
                                      child: Icon(Icons.play_arrow),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Future<void> getPodcastScreen(String id) async {
    final bool isSuccess = await podcastDetailsController.getPodcastDetails(id);

    if (isSuccess) {
      if (mounted) {
        Navigator.pushNamed(context, PodcastDetailsScreen.routeName,
            arguments: podcastDetailsController.podcastModel);
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, podcastDetailsController.errorMessage!, true);
        }
      }
    }
  }
}
