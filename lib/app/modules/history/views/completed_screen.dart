import 'package:antoinette/app/modules/history/controllers/all_booking_controller.dart';
import 'package:antoinette/app/modules/history/widgets/rebook_card_widget.dart';
import 'package:antoinette/app/modules/history/widgets/two_option_card_widget.dart';
import 'package:antoinette/app/modules/session/controllers/session_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        width: MediaQuery.of(context).size.width, 
        child: ListView.builder(
          controller: scrollController,
          itemCount: controller.bookingList.length,
          itemBuilder: (context, index) {
            String dateString = '2025-03-18';
            DateTime date = DateTime.parse(dateString);
            DateTime today = DateTime.now();
            if (controller.bookingList[index].paymentStatus == 'paid') {
              // if (today.isBefore(date)) {
              if (controller.bookingList[index].status == 'confirmed') {
                return RebookCard(
                  status: '${controller.bookingList[index].status}',
                  title: '${controller.bookingList[index].session?.title}',
                  name: 'Dr. Jane Smith',
                  therapyType: '${controller.bookingList[index].therapyType}',
                  date: '${controller.bookingList[index].slot?.date}',
                  time: '${controller.bookingList[index].slot?.startTime}',
                  imagePath:
                      '${controller.bookingList[index].session?.thumbnail}',
                  price: '${controller.bookingList[index].amount}',
                  ontap: () {},
                );
              } else if (controller.bookingList[index].status == 'cancelled') {
                return TwoOptionCard(
                  op1Name: 'Rebook',
                  op2Name: 'View Refund',
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
                  op2Ontap: () {},
                );
              }

              // }
              // return Text('No data');
            }
            return Container();
          },
        ),
      );
    });
  }
}
