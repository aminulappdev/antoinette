import 'package:antoinette/app/modules/history/controllers/all_booking_controller.dart';
import 'package:antoinette/app/modules/history/controllers/cancel_booking_controller.dart';
import 'package:antoinette/app/modules/history/views/reschedule_session.dart';
import 'package:antoinette/app/modules/history/widgets/two_option_card_widget.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final AllBookingController allBookingController =
      Get.find<AllBookingController>();
  final CancelBookingController cancelBookingController =
      Get.find<CancelBookingController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    allBookingController.getBookingList();
    scrollController.addListener(_loadMoreData);
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
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200.h,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          controller: scrollController,
          itemCount: controller.bookingList.length,
          itemBuilder: (context, index) {
            String dateString = '2025-03-18';
            DateTime date = DateTime.parse(dateString);
            DateTime today = DateTime.now();
            if (today.isAfter(date)) {
              return TwoOptionCard(
                op1Name: 'Reschedule',
                op2Name: 'Cancel booking',
                status: '${controller.bookingList[index].status}',
                title: '${controller.bookingList[index].session?.title}',
                name: 'Dr. Jane Smith',
                therapyType: '${controller.bookingList[index].therapyType}',
                date: '${controller.bookingList[index].slot?.date}',
                time: '${controller.bookingList[index].slot?.startTime}',
                imagePath:
                    '${controller.bookingList[index].session?.thumbnail}',
                price: '${controller.bookingList[index].amount}',
                op1Ontap: () {
                  print('Go to reschedule');
                  Navigator.pushNamed(
                      context, RescheduleSessionScreen.routeName,
                      arguments: {
                        'bookingId': controller.bookingList[index].id,
                        'sessionId': controller.bookingList[index].session?.id
                      });
                },
                op2Ontap: () {
                  cancelBookingOntap('${controller.bookingList[index].id}');
                },
              );
            }
            return Container();
          },
        ),
      );
    });
  }

  Future<void> cancelBookingOntap(String id) async {
    final bool isSuccess = await cancelBookingController.cancelBooking(id);

    if (isSuccess) {
      if (mounted) {
        allBookingController.getBookingList();
        showSnackBarMessage(context, 'Booking done');
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, cancelBookingController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(context,
            cancelBookingController.errorMessage ?? 'Ekhanei problem', true);
      }
    }
  }
}
