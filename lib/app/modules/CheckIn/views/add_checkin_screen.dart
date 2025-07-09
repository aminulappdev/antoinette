// ignore_for_file: avoid_print

import 'dart:async';
import 'package:antoinette/app/modules/checkIn/controllers/add_checkIn_controller.dart';
import 'package:antoinette/app/modules/checkIn/controllers/all_checkIn_list_controller.dart';
import 'package:antoinette/app/modules/checkIn/controllers/counter_controller.dart';
import 'package:antoinette/app/modules/common/controllers/socket_service.dart';
import 'package:antoinette/app/modules/contact/controllers/all_contact_controller.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:antoinette/get_storage.dart';
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
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as ph;

class AddCheckInScreen extends StatefulWidget {
  static const String routeName = '/add-check-screen';
  const AddCheckInScreen({super.key});

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
  int hours = 0, minutes = 0, seconds = 0;
  Duration _selectedDuration = const Duration(minutes: 15);

  List<String> selectedContacts = [];
  late String userId;

  double? latitude;
  double? longitude;

 

  AddCheckInController addCheckInController = AddCheckInController();
  CountdownController countdownController =
      Get.put(CountdownController()); // Global instance

  @override
  void initState() {
    super.initState();
    
    
    Get.find<AllContactController>().getContactList();
  }

  @override
  void dispose() {
    super.dispose();
    // Countdown is now globally managed, so no need to stop it here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox24,
              CustomAppBar(name: 'Add Check-In'),
              heightBox12,
              Row(
                children: [
                  Icon(Icons.access_time, size: 22.sp),
                  widthBox4,
                  Text('Set Check-In Timer',
                      style: GoogleFonts.poppins(fontSize: 15.sp)),
                ],
              ),
              SizedBox(
                height: 230.h,
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
                  Icon(Icons.search, size: 22.sp),
                  widthBox4,
                  Text('Quick Check-In',
                      style: GoogleFonts.poppins(fontSize: 15.sp)),
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
                    feature: 'Travelling alone',
                    ontap: () {
                      quickChekIn = 'Travelling alone';
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
                    icon: '🚶‍♂️',
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
                feature: isSelectedCS && quickChekIn != null
                    ? quickChekIn!
                    : 'Add custom status',
                ontap: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    CustomStatusScreen.routeName,
                  );

                  if (result != null && result is String) {
                    quickChekIn = result;
                    isSelectedCS = true;
                    isSelectedTR = false;
                    isSelectedGOD = false;
                    isSelectedTA = false;
                    isSelectedTWA = false;
                    setState(() {});
                  }
                },
                isSelectedf: isSelectedCS,
              ),
              heightBox12,
              Row(
                children: [
                  Icon(Icons.person_2, size: 22.h),
                  widthBox4,
                  Text('Trusted contacts',
                      style: GoogleFonts.poppins(fontSize: 15.sp)),
                ],
              ),
              heightBox4,
              GetBuilder<AllContactController>(builder: (controller) {
                if (controller.contactList == null ||
                    controller.contactList!.isEmpty) {
                  return SizedBox(
                    height: 150.h,
                    child: Center(child: Text('No contacts available')),
                  );
                } else if (controller.inProgress) {
                  return Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.contactList?.length,
                    itemBuilder: (context, index) {
                      // Ensure the contact data is not null
                      var contact = controller.contactList?[index];
                      if (contact == null) {
                        return SizedBox
                            .shrink(); // Return an empty widget if the contact is null
                      }

                      var contactId = contact.sId;
                      var contactName = contact.name;
                      userId = contact.user?.sId ??
                          ''; // Ensure userId is set safely

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
                            Text(contactName ?? 'Unknown'),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 10.h),
              Center(
                child: InkWell(
                  onTap: () async {
                    await requestLocationPermission();
                    await getCurrentLocation();
                  },
                  child: Container(
                    height: 36.h,
                    width: 250.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: AppColors.iconButtonThemeColor)),
                    child: Center(child: Text('Share your location')),
                  ),
                ),
              ),
              heightBox12,
              // Check-In button logic with condition
              latitude != null &&
                      quickChekIn != null &&
                      selectedContacts.isNotEmpty
                  ? GradientElevatedButton(
                      onPressed: () {
                        print('check in called');
                        onTapToNextButton();
                      },
                      text: 'Check-In',
                    )
                  : Opacity(
                      opacity: 0.4,
                      child: GradientElevatedButton(
                        onPressed: () {},
                        text: 'Check-In',
                      ),
                    ),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (quickChekIn != null && latitude != null) {
      final bool isSuccess = await addCheckInController.addCheckIn(
          userId,
          _selectedDuration.toString(),
          quickChekIn!,
          selectedContacts,
          latitude!,
          longitude!);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Check-In added successfully');
          Get.find<AllCheckInController>().getCheckInList();

          Navigator.pop(context);
          countdownController
              .startCountdown(_selectedDuration); // Start countdown globally
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, addCheckInController.errorMessage!, true);
        }
      }
    }
  }

  Future<void> requestLocationPermission() async {
    final ph.PermissionStatus status = await ph.Permission.location.request();
    if (status.isGranted) {
      // Permission granted; you can now retrieve the location.
    } else if (status.isDenied) {
      // Permission denied.
      print('Location_permission_denied');
    }
  }

  Future<void> getCurrentLocation() async {
    final loc.Location location = loc.Location();
    try {
      final loc.LocationData locationData = await location.getLocation();
      setState(() {
        latitude = locationData.latitude!;
        longitude = locationData.longitude!;
        print('Location is $latitude and $longitude');
      });
      // Handle the location data as needed.
    } catch (e) {
      // Handle errors, such as permissions not granted or location services disabled.
      print('Error getting location: $e');
    }
  }
}
