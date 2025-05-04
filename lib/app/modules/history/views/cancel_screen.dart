import 'package:antoinette/app/modules/history/controllers/all_booking_controller.dart';
import 'package:antoinette/app/modules/history/controllers/cancel_booking_controller.dart';
import 'package:antoinette/app/modules/history/controllers/payment_booking_id.dart';
import 'package:antoinette/app/modules/history/controllers/refumd_payment_controller.dart';
import 'package:antoinette/app/modules/history/widgets/two_option_card_widget.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  final AllBookingController allBookingController =
      Get.find<AllBookingController>();
  final CancelBookingController cancelBookingController =
      Get.find<CancelBookingController>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searcCtrl = TextEditingController();
  final PaymentByBookingIDController paymentByBookingIDController =
      PaymentByBookingIDController();
  final RefundPaymentController refundPaymentController =
      RefundPaymentController();
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
              String bookingDateString = controller.bookingList[index].slot!.date!;
DateTime bookingDate = DateTime.parse(bookingDateString);
String formattedBookingDate = DateFormat('MMMM dd, yyyy').format(bookingDate);


                if (controller.bookingList[index].status == 'cancelled') {
                  print('Cancelled data ache...........');
                  if (searcCtrl.text.isEmpty) {
                    return TwoOptionCard(
                      op1Name: 'Reebook',
                      op2Name: 'View Refund',
                      status: '${controller.bookingList[index].status}',
                      title: controller.bookingList[index].session?.title ??
                          'No title', // Null check for title
                      name: 'Dr. Jane Smith',
                      therapyType:
                          '${controller.bookingList[index].therapyType}',
                      date: formattedBookingDate,
                      time: '${controller.bookingList[index].slot?.startTime}',
                      imagePath:
                          '${controller.bookingList[index].session?.thumbnail}',
                      price: '${controller.bookingList[index].amount}',
                      op1Ontap: () {
                        Navigator.pushNamed(
                            context, SessionDetailsScreen.routeName,
                            arguments:
                                controller.bookingList[index].session?.id);
                      },
                      op2Ontap: () {
                        refundPaynemt('${controller.bookingList[index].id}',
                            '${controller.bookingList[index].amount}');
                      },
                    );
                  } else if (controller.bookingList[index].session?.title
                          ?.toLowerCase()
                          .contains(searcCtrl.text.toLowerCase()) ??
                      false) {
                    // Safe null check for title
                    return TwoOptionCard(
                      op1Name: 'Reebook',
                      op2Name: 'View Refund',
                      status: '${controller.bookingList[index].status}',
                      title: controller.bookingList[index].session?.title ??
                          'No title', // Null check for title
                      name: 'Dr. Jane Smith',
                      therapyType:
                          '${controller.bookingList[index].therapyType}',
                      date: formattedBookingDate,
                      time: '${controller.bookingList[index].slot?.startTime}',
                      imagePath:
                          '${controller.bookingList[index].session?.thumbnail}',
                      price: '${controller.bookingList[index].amount}',
                      op1Ontap: () {
                        Navigator.pushNamed(
                            context, SessionDetailsScreen.routeName,
                            arguments:
                                controller.bookingList[index].session?.id);
                      },
                      op2Ontap: () {
                         refundPaynemt('${controller.bookingList[index].id}',
                            '${controller.bookingList[index].amount}');
                      },
                    );
                  } else {
                    return Container();
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

  Future<void> refundPaynemt(String id, dynamic amount) async {
    bool isSuccess =
        await paymentByBookingIDController.getPaymentByBookingId(id);

    if (isSuccess) {
      if (paymentByBookingIDController.paymentByBookingIdModel != null &&
          paymentByBookingIDController.paymentByBookingIdModel!.data != null &&
          paymentByBookingIDController
                  .paymentByBookingIdModel!.data!.paymentIntentId !=
              null) {
        var paymentIndentId = paymentByBookingIDController
            .paymentByBookingIdModel!.data!.paymentIntentId!;

        bool isSuccess = await refundPaymentController.refundPayment(
            paymentIndentId, amount);
        if (isSuccess) {
          showSnackBarMessage(
            context,
            'Refund request done',
          );
        }

        print('paymentindent id : $paymentIndentId'); 
      } else {
        print('Error: Payment Intent ID is missing inside success response.');
      }
    } else {
      print('Error: Failed to fetch payment info.');
    }
  }
}
