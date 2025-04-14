import 'dart:async';
import 'package:antoinette/app/modules/checkIn/controllers/add_checkIn_controller.dart';
import 'package:antoinette/app/modules/checkIn/controllers/all_checkIn_list_controller.dart';
import 'package:antoinette/app/modules/checkIn/controllers/counter_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/all_contact_controller.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antoinette/app/modules/checkIn/views/custom_status_screen.dart';
import 'package:antoinette/app/modules/checkIn/widgets/add_checkIn_feature.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/toggle_button.dart';

class AddCheckInScreen extends StatefulWidget {
  final String customStatus;
  static const String routeName = '/add-check-screen';
  const AddCheckInScreen({
    super.key,
    required this.customStatus,
  });

  @override
  State<AddCheckInScreen> createState() => _AddCheckInScreenState();
}

class _AddCheckInScreenState extends State<AddCheckInScreen> {
  String? quickChekIn;
  bool isSelectedTR = false;
  bool isSelectedGOD = false;
  bool isSelectedTA = false;
  bool isSelectedTWA = false;
  bool isSelectedCS = false;
  bool isToggled = false;
  int hours = 0, minutes = 15, seconds = 0;
  Duration _selectedDuration = const Duration(minutes: 15);
  // List to store selected toggled contacts
  List<String> selectedContacts = [];
  late String userId;

  AddCheckInController addCheckInController = AddCheckInController();

  // Countdown Controller
  CountdownController countdownController = Get.put(CountdownController()); // Use GetX for countdown

  @override
  void initState() {
    super.initState();
    Get.find<AllContactController>().getContactList();
  }

  @override
  void dispose() {
    super.dispose();
    countdownController.stopCountdown(); // Stop the countdown when the page is disposed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(name: 'Add Check-In'),
              heightBox12,
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 22.sp,
                  ),
                  widthBox4,
                  Text(
                    'Set Check-In Timer',
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  )
                ],
              ),
              Container(
                height: 230.h,
                color: Colors.transparent,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: _selectedDuration,
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() {
                      _selectedDuration = newDuration;
                    });
                  },
                ),
              ),
              heightBox12,
              Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 22.sp,
                  ),
                  widthBox4,
                  Text(
                    'Quick Check-In',
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  )
                ],
              ),
              heightBox12,
              Row(
                children: [
                  AddCheckInFeature(
                    icon: '🏍️',
                    feature: 'Taking a ride',
                    ontap: () {
                      quickChekIn = 'Taking a ride';
                      isSelectedTR = true;
                      isSelectedGOD = false;
                      isSelectedTA = false;
                      isSelectedTWA = false;
                      isSelectedCS = false;
                      setState(() {});
                    },
                    isSelectedf: isSelectedTR,
                  ),
                  widthBox12,
                  AddCheckInFeature(
                    icon: '💕',
                    feature: 'Going on a date',
                    ontap: () {
                      quickChekIn = 'Going on a date';
                      isSelectedTR = false;
                      isSelectedGOD = true;
                      isSelectedTA = false;
                      isSelectedTWA = false;
                      isSelectedCS = false;
                      setState(() {});
                    },
                    isSelectedf: isSelectedGOD,
                  ),
                ],
              ),
              heightBox12,
              Row(
                children: [
                  AddCheckInFeature(
                    icon: '💼',
                    feature: 'Travel alone',
                    ontap: () {
                      quickChekIn = 'Travel alone';
                      isSelectedTR = false;
                      isSelectedGOD = false;
                      isSelectedTA = true;
                      isSelectedTWA = false;
                      isSelectedCS = false;
                      setState(() {});
                    },
                    isSelectedf: isSelectedTA,
                  ),
                  widthBox12,
                  AddCheckInFeature(
                    icon: '🏍️',
                    feature: 'Taking a walk alone',
                    ontap: () {
                      quickChekIn = 'Taking a walk alone';
                      isSelectedTR = false;
                      isSelectedGOD = false;
                      isSelectedTA = false;
                      isSelectedTWA = true;
                      isSelectedCS = false;
                      setState(() {});
                    },
                    isSelectedf: isSelectedTWA,
                  ),
                ],
              ),
              heightBox12,
              AddCheckInFeature(
                icon: '📝',
                feature: widget.customStatus == ''
                    ? 'Add custom status'
                    : widget.customStatus,
                ontap: () {
                  Navigator.pushNamed(context, CustomStatusScreen.routeName);
                },
                isSelectedf: isSelectedCS,
              ),
              heightBox12,
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 22.h,
                  ),
                  widthBox4,
                  Text(
                    'Set Check-In Timer',
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  )
                ],
              ),
              heightBox12,
              GetBuilder<AllContactController>(
                builder: (controller) {
                  if (controller.inProgress) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: controller.contactList?.length,
                      itemBuilder: (context, index) {
                        var contactId = controller.contactList?[index].sId;
                        var contact = controller.contactList?[index].name;
                        userId = controller.contactList![index].user!.sId!;
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              ToggleButton(
                                isToggled: selectedContacts.contains(contactId),
                                onToggle: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedContacts.add(contactId!);
                                    } else {
                                      selectedContacts.remove(contactId);
                                    }
                                  });
                                },
                              ),
                              widthBox4,
                              Text(contact!),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              GradientElevatedButton(
                onPressed: () {
                  onTapToNextButton();
                },
                text: 'Check-In',
              ),
              SizedBox(height: 1.h),
              // Display countdown from CountdownController
              Obx(() {
                var remainingTime = countdownController.remainingTime.value;
                return Text(
                  'Time Left: ${remainingTime.inMinutes}:${remainingTime.inSeconds % 60}',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (quickChekIn != null) {
      final bool isSuccess = await addCheckInController.addCheckIn(
          userId, _selectedDuration.toString(), quickChekIn!, selectedContacts);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Checking Added');
          Get.find<AllCheckInController>().getCheckInList();
          Navigator.pop(context);
          countdownController.startCountdown(_selectedDuration);

       
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, addCheckInController.errorMessage!, true);
        }
      }
    }
  }
}
