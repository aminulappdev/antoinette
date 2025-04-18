import 'package:antoinette/app/modules/history/controllers/all_booking_controller.dart';
import 'package:antoinette/app/modules/history/controllers/cancel_booking_controller.dart';
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

  @override
  void initState() {
    allBookingController.getBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllBookingController>(builder: (controller) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 300.h,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
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
                op1Ontap: () {},
                op2Ontap: () {
                  cancelBookingOntap('${controller.bookingList[index].id}');
                },
              );
            }
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
