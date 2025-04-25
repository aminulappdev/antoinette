import 'package:antoinette/app/modules/history/controllers/all_booking_controller.dart';
import 'package:antoinette/app/modules/history/controllers/cancel_booking_controller.dart';
import 'package:antoinette/app/modules/history/views/reschedule_session.dart';
import 'package:antoinette/app/modules/history/widgets/two_option_card_widget.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController searcCtrl = TextEditingController();
  String search = '';

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
                DateTime dateString = controller.bookingList[index].createdAt!;
                print(dateString);
               //  String dateFormate = DateFormat('MMMM dd, yyyy').format(dateString);
                DateTime today = DateTime.now();

                DateTime bookingDate =
                    controller.bookingList[index].slot!.date!;
                String formateBookingDate =
                    DateFormat('MMMM dd, yyyy').format(bookingDate);

                var title = controller.bookingList[index].session?.title;
                if (today.isAfter(dateString)) {
                  if (controller.bookingList[index].paymentStatus == 'paid') {
                    if (searcCtrl.text.isEmpty) {
                      return TwoOptionCard(
                        op1Name: 'Reschedule',
                        op2Name: 'Cancel booking',
                        status: '${controller.bookingList[index].status}',
                        title: controller.bookingList[index].session?.title ??
                            'No title', // Null check for title
                        name: 'Dr. Jane Smith',
                        therapyType:
                            '${controller.bookingList[index].therapyType}',
                        date: formateBookingDate,
                        time:
                            '${controller.bookingList[index].slot?.startTime}',
                        imagePath:
                            '${controller.bookingList[index].session?.thumbnail}',
                        price: '${controller.bookingList[index].amount}',
                        op1Ontap: () {
                          print('Go to reschedule');
                          Navigator.pushNamed(
                            context,
                            RescheduleSessionScreen.routeName,
                            arguments: {
                              'bookingId': controller.bookingList[index].id,
                              'sessionId':
                                  controller.bookingList[index].session?.id,
                            },
                          );
                        },
                        op2Ontap: () {
                          cancelBookingOntap(controller.bookingList[index].id!);
                        },
                      );
                    } else if (controller.bookingList[index].session?.title
                            ?.toLowerCase()
                            .contains(searcCtrl.text.toLowerCase()) ??
                        false) {
                      // Safe null check for title
                      return TwoOptionCard(
                        op1Name: 'Reschedule',
                        op2Name: 'Cancel booking',
                        status: '${controller.bookingList[index].status}',
                        title: controller.bookingList[index].session?.title ??
                            'No title', // Null check for title
                        name: 'Dr. Jane Smith',
                        therapyType:
                            '${controller.bookingList[index].therapyType}',
                        date: formateBookingDate,
                        time:
                            '${controller.bookingList[index].slot?.startTime}',
                        imagePath:
                            '${controller.bookingList[index].session?.thumbnail}',
                        price: '${controller.bookingList[index].amount}',
                        op1Ontap: () {
                          print('Go to reschedule');
                          Navigator.pushNamed(
                            context,
                            RescheduleSessionScreen.routeName,
                            arguments: {
                              'bookingId': controller.bookingList[index].id,
                              'sessionId':
                                  controller.bookingList[index].session?.id,
                            },
                          );
                        },
                        op2Ontap: () {
                          cancelBookingOntap(controller.bookingList[index].id!);
                        },
                      );
                    } else {
                      return Container();
                    }
                  }
                }

                return Container();
              },
            ),
          ),
        ],
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
