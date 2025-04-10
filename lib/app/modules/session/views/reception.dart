import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/session/controllers/booking_controller.dart';
import 'package:antoinette/app/modules/session/controllers/get_session_slotById_controller.dart';
import 'package:antoinette/app/modules/session/model/session_details_model.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Reception extends StatefulWidget {
  final SessionDataModel sessionDataModel;
  const Reception({super.key, required this.sessionDataModel});

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {
  late String userId;
  final BookingController bookingController = BookingController();
  ProfileController profileController = Get.find<ProfileController>();
  
  // Therapy options and selected therapy
  String selectedTherapy = "Video Therapy";
  final List<String> therapyOptions = [
    "Video Therapy",
    "In-Person Therapy",
    "Text Therapy",
  ];

  // List of enabled dates from model
  List<DateTime> enabledDates = [];

  // To keep track of selected time slot
  String? selectedTimeSlot;
  String? selectedSlotId;

  // Initialize TableCalendar's selected date
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {

    super.initState();
    userId = profileController.profileData!.sId!;
    // Fetch session slots
    Get.find<AllSessionSlotByIdController>()
        .getSessionById(widget.sessionDataModel.sId!)
        .then((_) {
      var controller = Get.find<AllSessionSlotByIdController>();

      // Controller theke sessionListById theke valid dates nite hobe
      List<DateTime> validDates = [];
      controller.sessionListById?.forEach((sessionSlot) {
        DateTime date = DateTime.parse(sessionSlot!.date!);
        validDates.add(date);
      });

      setState(() {
        enabledDates = validDates; // Update enabled dates list
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSessionSlotByIdController>(builder: (controller) {
      if (controller.inProgress) {
        return Center(child: CircularProgressIndicator());
      }

      // Fetch time slots for the selected date
      List<String> availableTimeSlots = [];
      if (controller.selectedDate != null) {
        availableTimeSlots = controller.getTimeSlotsForSelectedDate(controller.selectedDate!);
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Therapy type selection
            Row(
              children: [
                Text("Choose Therapy Type:", style: GoogleFonts.poppins(fontSize: 15.sp)),
                SizedBox(width: 10.h),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6ECE4), // Soft beige background
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedTherapy,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
                        items: therapyOptions.map((String option) {
                          return DropdownMenuItem<String>(value: option, child: Text(option, style: GoogleFonts.poppins(fontSize: 12.sp)));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTherapy = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            heightBox8,

            // TableCalendar for date selection
            Text("Select Date:", style: GoogleFonts.poppins(fontSize: 15.sp)),
            heightBox8,
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDate,
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                  controller.updateSelectedDate(selectedDay);
                  selectedTimeSlot = null; // Reset the time slot selection
                  selectedSlotId = null; // Reset the slot ID
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                disabledDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              enabledDayPredicate: (day) {
                // Enable only valid dates from the model
                return enabledDates.any((date) =>
                    date.year == day.year &&
                    date.month == day.month &&
                    date.day == day.day);
              },
            ),
            heightBox8,

            // Time slot selection
            Text("Select Date & Time:", style: GoogleFonts.poppins(fontSize: 15.sp)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: availableTimeSlots.map((timeSlot) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: timeSlot,
                        groupValue: selectedTimeSlot, // Group value is based on the selected time slot
                        onChanged: (String? value) {
                          setState(() {
                            selectedTimeSlot = value; // Update the selected time slot
                            selectedSlotId = value; // Assuming the slot ID matches the time slot value
                            print('My slot id .....................');
                          });
                        },
                        activeColor: Colors.black,
                      ),
                      Text(timeSlot, style: GoogleFonts.poppins(fontSize: 12.sp)),
                    ],
                  ),
                );
              }).toList(),
            ),
            heightBox8,

            // Book session button
            ElevatedButton(
              onPressed: onTapToNextButton,
              child: Text("Book Session", style: GoogleFonts.poppins(fontSize: 15.sp)),
            ),
          ],
        ),
      );
    });
  }

  Future<void> onTapToNextButton() async {
    if (selectedDate == null || selectedTimeSlot == null || selectedSlotId == null) {
      showSnackBarMessage(context, "Please select a valid date and time slot", true);
      return;
    }

    final bool isSuccess = await bookingController.bookingSession(
       userId, // Replace with the actual user ID
      widget.sessionDataModel.sId!, // Using the session ID from the model
      selectedSlotId!, // Slot ID will be selected time slot ID
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Booking successful');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, bookingController.errorMessage!, true);
      }
    }
  }
}
