import 'package:antoinette/app/modules/history/controllers/all_booking_controller.dart';
import 'package:antoinette/app/modules/history/widgets/rebook_card_widget.dart';
import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  SessionDetailsController sessionDetailsController =
      SessionDetailsController();
  final AllBookingController allBookingController =
      Get.find<AllBookingController>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searcCtrl = TextEditingController();
  String search = '';

  @override
  void initState() {
    allBookingController.getBookingList();
    scrollController.addListener(_loadMoreData);
    // allSessionController.getSessionList();

    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allBookingController.inProgress) {
      allBookingController.getBookingList();
    }
    {
      allBookingController.getBookingList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllBookingController>(builder: (controller) {
      if (controller.inProgress && controller.page == 1) {
        return Center(child: CircularProgressIndicator());
      }
      return Column(
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
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              controller: scrollController,
              itemCount: controller.bookingList.length,
              itemBuilder: (context, index) {
                String dateString = '2025-03-18';
                // ignore: unused_local_variable
                DateTime date = DateTime.parse(dateString);
                // ignore: unused_local_variable
                DateTime today = DateTime.now();

                String bookingDateString =
                    controller.bookingList[index].slot!.date!;
                DateTime bookingDate = DateTime.parse(bookingDateString);
                String formattedBookingDate =
                    DateFormat('MMMM dd, yyyy').format(bookingDate);

                var title = controller.bookingList[index].session?.title;

                if (today.isAfter(bookingDate)) {
                  if (searcCtrl.text.isEmpty) {
                    if (controller.bookingList[index].status == 'confirmed') {
                      return RebookCard(
                        status: '${controller.bookingList[index].status}',
                        title:
                            '${controller.bookingList[index].session?.title}',
                        name: '${controller.bookingList[index].session!.therapist?.user?.name}',
                        therapyType:
                            '${controller.bookingList[index].therapyType}',
                        date: formattedBookingDate,
                        time:
                            '${controller.bookingList[index].slot?.startTime}',
                        imagePath:
                            '${controller.bookingList[index].session?.thumbnail}',
                        price: '${controller.bookingList[index].amount}',
                        ontap: () {
                          Navigator.pushNamed(
                              context, SessionDetailsScreen.routeName,
                              arguments:
                                  controller.bookingList[index].session?.id);
                        },
                      );
                    }
                  } else if (title!
                      .toLowerCase()
                      .contains(searcCtrl.text.toLowerCase())) {
                    if (controller.bookingList[index].status == 'confirmed') {
                      return RebookCard(
                        status: '${controller.bookingList[index].status}',
                        title:
                            '${controller.bookingList[index].session?.title}',
                        name: 'Dr. Jane Smith',
                        therapyType:
                            '${controller.bookingList[index].therapyType}',
                        date: formattedBookingDate,
                        time:
                            '${controller.bookingList[index].slot?.startTime}',
                        imagePath:
                            '${controller.bookingList[index].session?.thumbnail}',
                        price: '${controller.bookingList[index].amount}',
                        ontap: () {
                          Navigator.pushNamed(
                              context, SessionDetailsScreen.routeName,
                              arguments:
                                  controller.bookingList[index].session?.id);
                        },
                      );
                    } else {
                      return Container();
                    }
                  }
                }
                return null;
              },
            ),
          ),
        ],
      );
    });
  }
}
