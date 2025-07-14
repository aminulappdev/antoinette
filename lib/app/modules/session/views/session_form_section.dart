import 'package:antoinette/app/modules/chatting/controllers/add_chat_controller.dart';
import 'package:antoinette/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:antoinette/app/modules/payment/controllers/payment_services.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/session/controllers/booking_controller.dart';
import 'package:antoinette/app/modules/session/controllers/reschedule_booking_controller.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionFormScreen extends StatefulWidget {
  final Map<String, dynamic> slotData;
  static const String routeName = '/session-form-screen';
  const SessionFormScreen({super.key, required this.slotData});

  @override
  State<SessionFormScreen> createState() => _SessionFormScreenState();
}

class _SessionFormScreenState extends State<SessionFormScreen> {
  late String userId;
  ProfileController profileController = Get.find<ProfileController>();
  final BookingController bookingController = Get.find<BookingController>();
  final AddChatController addChatController = Get.find<AddChatController>();
  final RescheduleBookingController rescheduleBookingController =
      Get.find<RescheduleBookingController>();
  final PaymentService paymentService = PaymentService();
  String? selectedMood; // For storing selected mood

  @override
  void initState() {
    userId = profileController.profileData!.id!;
    print('Therapy Id ............');

    print(widget.slotData['slotId']);
    print(widget.slotData['bookingId']);

    // print(
    //     'UserId : $userId\nSession id : ${widget.slotData['sessionId']}\nSession slot : ${widget.slotData['slotId']}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox24,
                  CustomAppBar(name: 'Let’s Get to Know You'),
                  Text(
                    'This form helps your therapist understand your needs better. Answer as openly as you feel comfortable.',
                    style: GoogleFonts.cormorantGaramond(fontSize: 15.sp),
                    textAlign: TextAlign.center,
                  ),
                  heightBox8,
                  Text(
                    'Personal details',
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  ),
                  heightBox8,
                  Text('Full Name',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  Text(controller.profileData!.name ?? '',),
                  heightBox12,
                  Text('Age',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  Text(controller.profileData!.age ?? 'Not mentioned'),
                  heightBox12,
                  Text('Contact',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  Text( controller.profileData!.contactNumber ?? ''),
                  heightBox12,
                  Text(
                    'Current Emotional State:',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff626262),
                    ),
                  ),
                  heightBox8,

                  /// ✅ Single-select checkbox section
                  Wrap(
                    spacing: 10.w,
                    children:
                        ['Happy', 'Anxious', 'Stressed', 'Other'].map((mood) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: selectedMood == mood,
                            onChanged: (_) {
                              setState(() {
                                selectedMood = mood;
                              });
                            },
                          ),
                          Text(mood),
                          SizedBox(width: 10),
                        ],
                      );
                    }).toList(),
                  ),
                  heightBox12,

                  GetBuilder<BookingController>(builder: (controller) {
                    bool isDisabled =
                        selectedMood == null || controller.inProgress;

                    return Opacity(
                      opacity: selectedMood == null ? 0.5 : 1.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IgnorePointer(
                            ignoring:
                                isDisabled, // ইগনোর করবো যদি disable অবস্থায় থাকে
                            child: GradientElevatedButton(
                              onPressed: () {
                                print('Clicked on submit button');
                                print("Selected Mood: $selectedMood");

                                addChatTherapist(
                                    userId, widget.slotData['therapyId']);
                                widget.slotData['bookingId'] == null
                                    ? bookingButton()
                                    : rescheduleBookingButton();
                              },
                              text: controller.inProgress ? '' : 'Submit',
                            ),
                          ),
                          if (controller.inProgress)
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> bookingButton() async {
    // if (widget.slotData['bookingId'] == null ||
    //     widget.slotData['slotId'] == null) {
    //   // print('main funtion e jay nay');
    //   showSnackBarMessage(
    //       context, "Please select a valid date and time slot", true);
    //   return;
    // }

    if (selectedMood == null) {
      // print('Select your mood');
      showSnackBarMessage(
          context, "Please select your current emotional state", true);
      return;
    }

    final bool isSuccess = await bookingController.bookingSession(
        userId,
        widget.slotData['sessionId'],
        widget.slotData['slotId'],
        widget.slotData['therapyType'],
        selectedMood!);

    if (isSuccess) {
      if (mounted) {
        paymentService.payment(context, 'Booking', userId,
            bookingController.sessionBookingResponseData!.id!);
        // showSnackBarMessage(context, 'Booking successful');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, bookingController.errorMessage!, true);
      }
    }
  }

  Future<void> rescheduleBookingButton() async {
    if (widget.slotData['sessionId'] == null ||
        widget.slotData['slotId'] == null) {
      // print('main funtion e jay nay');
      showSnackBarMessage(
          context, "Please select a valid date and time slot", true);
      return;
    }

    if (selectedMood == null) {
      // print('Select your mood');
      showSnackBarMessage(
          context, "Please select your current emotional state", true);
      return;
    }

    final bool isSuccess = await rescheduleBookingController.bookingSession(
      widget.slotData['bookingId'],
      widget.slotData['slotId'],
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Booking successful');
        Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, bookingController.errorMessage!, true);
      }
    }
  }

  Future<void> addChatTherapist(String userId, String therapistId) async {
    final bool isSuccess = await addChatController.addChat(userId, therapistId);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Added new chat');
        print(
            'Chat create hoye geche .............................................');
        print('Therapoist id :  $therapistId');
        print(
            'Chat create hoye geche .............................................');
      } else {
        if (mounted) {
          showSnackBarMessage(context, addChatController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(
            context, addChatController.errorMessage ?? 'Ekhanei problem', true);
      }
    }

    // Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
  }
  
 
}
